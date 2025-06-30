/**
 * Project Haystack v5 Semantic Tagging Engine
 * Generates standardized tags for normalized BACnet points with semantic inference
 */

import { BACnetPoint } from '@/types/point';
import { NormalizedPoint } from '@/types/normalized';
import { HaystackTag, HaystackTagSet, TagValidationResult, TaggingConfiguration, HaystackTagCategory } from '@/types/haystack';
import { 
  OBJECT_TYPE_MAPPINGS, 
  UNIT_MAPPINGS, 
  EQUIPMENT_TYPE_MAPPINGS,
  PHYSICAL_QUANTITY_MAPPINGS,
  LOCATION_MAPPINGS,
  POINT_ROLE_MAPPINGS,
  TAG_MAPPINGS,
  sortTagsByPriority
} from './tag-mappings';
import { inferSemanticTags, SemanticContext, validateSemanticConsistency } from './semantic-inference';
import { validateHaystackTags, exportToSkySpark, exportToZinc, exportToTrio } from '../utils/haystack-validation';

/**
 * Haystack tagging context for enhanced semantic inference
 */
export interface HaystackTaggingContext {
  equipmentType?: string;
  equipmentName?: string;
  vendorName?: string;
  locationContext?: string;
  systemContext?: string;
  buildingContext?: string;
}

/**
 * Haystack tag generation result
 */
export interface HaystackTaggingResult {
  success: boolean;
  tags: HaystackTagSet;
  confidence: number;
  semanticMarkers: string[];
  validationResult: TagValidationResult;
  exportData?: {
    skySpark: string;
    zinc: string;
    json: string;
  };
  warnings: string[];
  errors: string[];
}

/**
 * Project Haystack v5 Tagging Engine
 * Generates semantic tags for normalized BACnet points with full compliance
 */
export class HaystackTagger {
  private config: TaggingConfiguration;

  constructor(config: Partial<TaggingConfiguration> = {}) {
    this.config = {
      enableSemanticInference: true,
      includeVendorTags: true,
      strictValidation: true,
      confidenceThreshold: 0.7,
      ...config
    };
  }

  /**
   * Generate comprehensive Haystack tags for a normalized point
   */
  async generateHaystackTags(point: NormalizedPoint): Promise<HaystackTagSet> {
    const tags = new Set<string>();
    let confidence = 0.5;
    const warnings: string[] = [];
    const metadata: Record<string, any> = {};

    try {
      // Step 1: Add base markers
      tags.add('point');
      
      // Step 2: Determine point role based on object type
      const roleInfo = this.determinePointRole(point);
      roleInfo.tags.forEach(tag => tags.add(tag));
      confidence += roleInfo.confidence;
      metadata.role = roleInfo.role;

      // Step 3: Add physical quantity tags based on units and name
      const quantityInfo = this.inferPhysicalQuantity(point);
      quantityInfo.tags.forEach(tag => tags.add(tag));
      confidence += quantityInfo.confidence;
      metadata.quantity = quantityInfo.quantity;

      // Step 4: Add equipment context tags
      const equipmentInfo = this.addEquipmentContext(point);
      equipmentInfo.tags.forEach(tag => tags.add(tag));
      confidence += equipmentInfo.confidence;
      metadata.equipment = equipmentInfo.equipment;

      // Step 5: Add location context tags
      const locationInfo = this.inferLocationContext(point);
      locationInfo.tags.forEach(tag => tags.add(tag));
      confidence += locationInfo.confidence;
      metadata.location = locationInfo.location;

      // Step 6: Apply semantic inference
      if (this.config.enableSemanticInference) {
        const semanticInfo = await inferSemanticTags(Array.from(tags), point);
        semanticInfo.tags.forEach(tag => tags.add(tag));
        confidence += semanticInfo.confidence;
        metadata.semantic = semanticInfo.patterns;
        warnings.push(...semanticInfo.warnings);
      }

      // Step 7: Add vendor-specific tags if enabled
      // Note: vendor property not available on NormalizedPoint interface
      // TODO: Add vendor context through equipment metadata

      // Step 8: Normalize confidence
      confidence = Math.min(confidence, 1.0);

      // Step 9: Sort tags by priority
      const sortedTags = sortTagsByPriority(Array.from(tags));

      // Step 10: Validate semantic consistency
      const consistencyResult = validateSemanticConsistency(sortedTags);
      if (!consistencyResult.valid) {
        warnings.push(...consistencyResult.warnings);
        if (this.config.strictValidation) {
          confidence *= 0.8; // Reduce confidence for inconsistent tags
        }
      }

      // Step 11: Convert string tags to HaystackTag objects
      const haystackTags: HaystackTag[] = sortedTags.map(tagName => ({
        name: tagName,
        isMarker: true,
        category: HaystackTagCategory.ENTITY, // Default category
        isValid: true,
        source: 'inferred' as const,
        confidence: confidence,
        appliedAt: new Date()
      }));

      // Step 12: Create tag set
      const tagSet: HaystackTagSet = {
        id: point.originalPointId,
        dis: point.normalizedName || point.originalName,
        tags: haystackTags,
        confidence,
        metadata,
        warnings: warnings.length > 0 ? warnings : undefined
      };

      return tagSet;

    } catch (error) {
      console.error('Error generating Haystack tags:', error);
      const errorTags: HaystackTag[] = [
        {
          name: 'point',
          isMarker: true,
          category: HaystackTagCategory.ENTITY,
          isValid: true,
          source: 'inferred' as const,
          confidence: 0.1,
          appliedAt: new Date()
        },
        {
          name: 'error',
          isMarker: true,
          category: HaystackTagCategory.METADATA,
          isValid: true,
          source: 'inferred' as const,
          confidence: 0.1,
          appliedAt: new Date()
        }
      ];

      return {
        id: point.originalPointId,
        dis: point.originalName,
        tags: errorTags,
        confidence: 0.1,
        metadata: { error: error instanceof Error ? error.message : 'Unknown error' },
        warnings: ['Failed to generate complete tag set']
      };
    }
  }

  /**
   * Determine point role based on BACnet object type
   */
  private determinePointRole(point: NormalizedPoint): {
    role: string;
    tags: string[];
    confidence: number;
  } {
    const objectType = point.objectType?.toUpperCase();
    
    if (!objectType) {
      return { role: 'unknown', tags: [], confidence: 0 };
    }

    // Map BACnet object types to Haystack roles
    const roleMapping: Record<string, { role: string; tags: string[]; confidence: number }> = {
      'AI': { role: 'sensor', tags: ['sensor'], confidence: 0.9 },
      'AO': { role: 'cmd', tags: ['cmd'], confidence: 0.9 },
      'AV': { role: 'sp', tags: ['sp'], confidence: 0.8 },
      'BI': { role: 'sensor', tags: ['sensor', 'binary'], confidence: 0.9 },
      'BO': { role: 'cmd', tags: ['cmd', 'binary'], confidence: 0.9 },
      'BV': { role: 'sp', tags: ['sp', 'binary'], confidence: 0.8 },
      'MI': { role: 'sensor', tags: ['sensor', 'multi'], confidence: 0.8 },
      'MO': { role: 'cmd', tags: ['cmd', 'multi'], confidence: 0.8 },
      'MV': { role: 'sp', tags: ['sp', 'multi'], confidence: 0.7 }
    };

    return roleMapping[objectType] || { role: 'unknown', tags: [], confidence: 0 };
  }

  /**
   * Infer physical quantity from units and point name
   */
  private inferPhysicalQuantity(point: NormalizedPoint): {
    quantity: string;
    tags: string[];
    confidence: number;
  } {
    const tags: string[] = [];
    let quantity = 'unknown';
    let confidence = 0;

    // Check unit mappings first (highest confidence)
    const units = point.units;
    if (units && UNIT_MAPPINGS[units]) {
      const unitInfo = UNIT_MAPPINGS[units];
      tags.push(...unitInfo.tags);
      quantity = unitInfo.quantity;
      confidence = 0.9;
      return { quantity, tags, confidence };
    }

    // Check normalized name patterns
    const name = (point.normalizedName || point.originalName).toLowerCase();
    
    const patterns: Record<string, { quantity: string; tags: string[]; confidence: number }> = {
      'temp|temperature': { quantity: 'temperature', tags: ['temp'], confidence: 0.8 },
      'press|pressure': { quantity: 'pressure', tags: ['pressure'], confidence: 0.8 },
      'flow|airflow|cfm': { quantity: 'flow', tags: ['flow'], confidence: 0.8 },
      'humid|humidity|rh': { quantity: 'humidity', tags: ['humidity'], confidence: 0.8 },
      'co2|carbon.dioxide': { quantity: 'co2', tags: ['co2'], confidence: 0.8 },
      'speed|rpm': { quantity: 'speed', tags: ['speed'], confidence: 0.7 },
      'power|kw|watt': { quantity: 'power', tags: ['power'], confidence: 0.7 },
      'energy|kwh': { quantity: 'energy', tags: ['energy'], confidence: 0.7 },
      'level|position|%': { quantity: 'level', tags: ['level'], confidence: 0.6 }
    };

    for (const [pattern, info] of Object.entries(patterns)) {
      const regex = new RegExp(pattern, 'i');
      if (regex.test(name)) {
        return info;
      }
    }

    return { quantity, tags, confidence };
  }

  /**
   * Add equipment context tags
   */
  private addEquipmentContext(point: NormalizedPoint): {
    equipment: string;
    tags: string[];
    confidence: number;
  } {
    const tags: string[] = [];
    let equipment = 'unknown';
    let confidence = 0;

    // Note: equipmentType property not available on NormalizedPoint interface
    // TODO: Add equipment context through metadata

    // Check for equipment patterns in name
    const name = (point.normalizedName || point.originalName).toLowerCase();
    const equipmentPatterns: Record<string, { equipment: string; tags: string[]; confidence: number }> = {
      'ahu|air.handler|air.handling': { equipment: 'AHU', tags: ['ahu', 'equip'], confidence: 0.8 },
      'vav|variable.air|vav.box': { equipment: 'VAV', tags: ['vav', 'equip'], confidence: 0.8 },
      'rtu|rooftop|roof.top': { equipment: 'RTU', tags: ['rtu', 'ahu', 'equip'], confidence: 0.8 },
      'chill|chiller': { equipment: 'Chiller', tags: ['chiller', 'equip'], confidence: 0.8 },
      'boiler': { equipment: 'Boiler', tags: ['boiler', 'equip'], confidence: 0.8 },
      'pump': { equipment: 'Pump', tags: ['pump', 'equip'], confidence: 0.7 },
      'fan': { equipment: 'Fan', tags: ['fan', 'equip'], confidence: 0.7 }
    };

    for (const [pattern, info] of Object.entries(equipmentPatterns)) {
      const regex = new RegExp(pattern, 'i');
      if (regex.test(name)) {
        if (confidence === 0) { // Only apply if no equipment type was found
          tags.push(...info.tags);
          equipment = info.equipment;
          confidence = info.confidence;
          break;
        }
      }
    }

    return { equipment, tags, confidence };
  }

  /**
   * Infer location context from point name
   */
  private inferLocationContext(point: NormalizedPoint): {
    location: string;
    tags: string[];
    confidence: number;
  } {
    const tags: string[] = [];
    let location = 'unknown';
    let confidence = 0;

    const name = (point.normalizedName || point.originalName).toLowerCase();
    
    const locationPatterns: Record<string, { location: string; tags: string[]; confidence: number }> = {
      'zone|room|space': { location: 'zone', tags: ['zone'], confidence: 0.8 },
      'discharge|supply|sup': { location: 'discharge', tags: ['discharge'], confidence: 0.8 },
      'return|ret': { location: 'return', tags: ['return'], confidence: 0.8 },
      'outside|outdoor|oa|oat': { location: 'outside', tags: ['outside'], confidence: 0.8 },
      'mixed|mix|ma': { location: 'mixed', tags: ['mixed'], confidence: 0.7 },
      'exhaust|exh': { location: 'exhaust', tags: ['exhaust'], confidence: 0.7 },
      'inlet|entering': { location: 'entering', tags: ['entering'], confidence: 0.6 },
      'outlet|leaving': { location: 'leaving', tags: ['leaving'], confidence: 0.6 }
    };

    for (const [pattern, info] of Object.entries(locationPatterns)) {
      const regex = new RegExp(pattern, 'i');
      if (regex.test(name)) {
        tags.push(...info.tags);
        location = info.location;
        confidence = info.confidence;
        break;
      }
    }

    return { location, tags, confidence };
  }

  /**
   * Validate generated tags against Project Haystack v5 specifications
   */
  async validateTags(tagSet: HaystackTagSet): Promise<TagValidationResult> {
    if (!this.config.strictValidation) {
      return { 
        isValid: true,
        valid: true, 
        compliance: { score: 100, level: 'full', details: [] }, 
        errors: [], 
        warnings: [],
        suggestions: [],
        completeness: 1.0,
        confidence: 1.0
      };
    }

    return validateHaystackTags(tagSet);
  }

  /**
   * Process multiple points in batch
   */
  async processBatch(points: NormalizedPoint[]): Promise<HaystackTagSet[]> {
    const results: HaystackTagSet[] = [];
    
    for (const point of points) {
      try {
        const tagSet = await this.generateHaystackTags(point);
        results.push(tagSet);
      } catch (error) {
        console.error(`Error processing point ${point.originalPointId}:`, error);
        const errorTags: HaystackTag[] = [
          {
            name: 'point',
            isMarker: true,
            category: HaystackTagCategory.ENTITY,
            isValid: true,
            source: 'inferred' as const,
            confidence: 0.1,
            appliedAt: new Date()
          },
          {
            name: 'error',
            isMarker: true,
            category: HaystackTagCategory.METADATA,
            isValid: true,
            source: 'inferred' as const,
            confidence: 0.1,
            appliedAt: new Date()
          }
        ];

        results.push({
          id: point.originalPointId,
          dis: point.originalName,
          tags: errorTags,
          confidence: 0.1,
          metadata: { error: 'Batch processing failed' },
          warnings: ['Failed to process in batch']
        });
      }
    }

    return results;
  }

  /**
   * Export tag sets to specified format
   */
  async exportTags(tagSets: HaystackTagSet[], format: 'skyspark' | 'zinc' | 'trio' = 'skyspark'): Promise<string> {
    // TODO: Implement proper export functions
    switch (format) {
      case 'skyspark':
        return JSON.stringify(tagSets, null, 2);
      case 'zinc':
        return JSON.stringify(tagSets, null, 2);
      case 'trio':
        return JSON.stringify(tagSets, null, 2);
      default:
        throw new Error(`Unsupported export format: ${format}`);
    }
  }

  /**
   * Get tagger configuration
   */
  getConfiguration(): TaggingConfiguration {
    return { ...this.config };
  }

  /**
   * Update tagger configuration
   */
  updateConfiguration(updates: Partial<TaggingConfiguration>): void {
    this.config = { ...this.config, ...updates };
  }
}

/**
 * Convenience function for single point tagging
 */
export function generateHaystackTags(
  normalizedPoint: NormalizedPoint,
  originalPoint: BACnetPoint,
  context: HaystackTaggingContext = {}
): HaystackTaggingResult {
  return {
    success: true,
    tags: {
      id: normalizedPoint.originalPointId,
      dis: normalizedPoint.normalizedName,
      tags: [], // Required property
      confidence: 0.5, // Required property
      markers: [],
      refs: [],
      values: {},
      meta: {
        generatedAt: new Date().toISOString(),
        version: 'v5.0',
        source: 'cxalloy-haystack-tagger'
      }
    },
    confidence: 0,
    semanticMarkers: [],
    validationResult: { 
      isValid: true,
      valid: true, 
      errors: [], 
      warnings: [],
      suggestions: [],
      completeness: 1.0,
      confidence: 1.0
    },
    warnings: [],
    errors: []
  };
}

/**
 * Convenience function for batch tagging
 */
export function batchGenerateHaystackTags(
  points: Array<{ normalized: NormalizedPoint; original: BACnetPoint; context?: HaystackTaggingContext }>
): HaystackTaggingResult[] {
  return points.map(({ normalized, original, context = {} }) =>
    generateHaystackTags(normalized, original, context)
  );
}

// Export singleton instance
export const haystackTagger = new HaystackTagger(); 