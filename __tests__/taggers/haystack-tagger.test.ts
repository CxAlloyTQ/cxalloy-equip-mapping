/**
 * Comprehensive Test Suite for Project Haystack v5 Tagging System
 * Tests tag generation, semantic inference, validation, and export functionality
 */

// Note: These imports would normally be from the actual modules
// For testing purposes, we'll create mock implementations

import { HaystackTagger } from '../../lib/taggers/haystack-tagger';
import { NormalizedPoint } from '../../types/bacnet';
import { validateHaystackTags } from '../../lib/utils/haystack-validation';

describe('HaystackTagger', () => {
  let tagger: HaystackTagger;

  beforeEach(() => {
    tagger = new HaystackTagger({
      enableSemanticInference: true,
      includeVendorTags: true,
      strictValidation: true,
      exportFormat: 'skyspark',
      confidenceThreshold: 0.7
    });
  });

  // Helper function to create mock BACnet points
  const createMockBACnetPoint = (name, objectType = 'AI', units, dataType = 'Number') => {
    return {
      objectName: name,
      dis: name,
      objectType,
      dataType,
      category: 'SENSOR',
      description: '',
      units
    };
  };

  // Helper function to create mock normalized points
  const createMockNormalizedPoint = (originalName, normalizedName, pointFunction = 'SENSOR', description) => {
    return {
      originalPointId: originalName,
      equipmentId: 'TEST_EQUIP',
      originalName,
      originalDescription: '',
      objectName: originalName,
      objectType: 'AI',
      normalizedName,
      expandedDescription: description || normalizedName,
      pointFunction,
      category: 'SENSOR',
      dataType: 'Number',
      units: undefined,
      haystackTags: [],
      confidence: 'HIGH',
      confidenceScore: 0.9,
      normalizationMethod: 'test',
      normalizationRules: [],
      hasAcronymExpansion: true,
      hasUnitNormalization: false,
      hasContextInference: false,
      requiresManualReview: false,
      normalizedAt: new Date()
    };
  };

  describe('Basic Tag Generation', () => {
    it('should generate basic tags for a simple point', async () => {
      const point: NormalizedPoint = {
        id: 'test-point-1',
        originalName: 'AHU_1_TEMP_SENSOR',
        normalizedName: 'AHU 1 Temperature Sensor',
        objectType: 'AI',
        unit: '°F',
        equipmentType: 'AHU',
        description: 'Zone temperature sensor'
      };

      const result = await tagger.generateHaystackTags(point);

      expect(result.id).toBe('test-point-1');
      expect(result.tags).toContain('point');
      expect(result.tags).toContain('sensor');
      expect(result.tags).toContain('temp');
      expect(result.tags).toContain('ahu');
      expect(result.confidence).toBeGreaterThan(0.5);
    });

    it('should handle points without equipment context', async () => {
      const point: NormalizedPoint = {
        id: 'test-point-2',
        originalName: 'TEMP_01',
        normalizedName: 'Temperature 01',
        objectType: 'AI',
        unit: '°F'
      };

      const result = await tagger.generateHaystackTags(point);

      expect(result.tags).toContain('point');
      expect(result.tags).toContain('sensor');
      expect(result.tags).toContain('temp');
      expect(result.confidence).toBeGreaterThan(0.3);
    });
  });

  describe('Object Type Mapping', () => {
    it('should map AI to sensor', async () => {
      const point: NormalizedPoint = {
        id: 'ai-test',
        originalName: 'AI_TEST',
        normalizedName: 'Analog Input Test',
        objectType: 'AI'
      };

      const result = await tagger.generateHaystackTags(point);
      expect(result.tags).toContain('sensor');
    });

    it('should map AO to cmd', async () => {
      const point: NormalizedPoint = {
        id: 'ao-test',
        originalName: 'AO_TEST',
        normalizedName: 'Analog Output Test',
        objectType: 'AO'
      };

      const result = await tagger.generateHaystackTags(point);
      expect(result.tags).toContain('cmd');
    });

    it('should map BI to binary sensor', async () => {
      const point: NormalizedPoint = {
        id: 'bi-test',
        originalName: 'BI_TEST',
        normalizedName: 'Binary Input Test',
        objectType: 'BI'
      };

      const result = await tagger.generateHaystackTags(point);
      expect(result.tags).toContain('sensor');
      expect(result.tags).toContain('binary');
    });

    it('should map BO to binary cmd', async () => {
      const point: NormalizedPoint = {
        id: 'bo-test',
        originalName: 'BO_TEST',
        normalizedName: 'Binary Output Test',
        objectType: 'BO'
      };

      const result = await tagger.generateHaystackTags(point);
      expect(result.tags).toContain('cmd');
      expect(result.tags).toContain('binary');
    });
  });

  describe('Unit-based Inference', () => {
    it('should infer temp from °F', async () => {
      const point: NormalizedPoint = {
        id: 'temp-f',
        originalName: 'TEMP_F',
        normalizedName: 'Temperature F',
        objectType: 'AI',
        unit: '°F'
      };

      const result = await tagger.generateHaystackTags(point);
      expect(result.tags).toContain('temp');
    });

    it('should infer flow from CFM', async () => {
      const point: NormalizedPoint = {
        id: 'flow-cfm',
        originalName: 'FLOW_CFM',
        normalizedName: 'Flow CFM',
        objectType: 'AI',
        unit: 'CFM'
      };

      const result = await tagger.generateHaystackTags(point);
      expect(result.tags).toContain('flow');
    });

    it('should infer pressure from PSI', async () => {
      const point: NormalizedPoint = {
        id: 'pressure-psi',
        originalName: 'PRESSURE_PSI',
        normalizedName: 'Pressure PSI',
        objectType: 'AI',
        unit: 'PSI'
      };

      const result = await tagger.generateHaystackTags(point);
      expect(result.tags).toContain('pressure');
    });

    it('should infer humidity from %RH', async () => {
      const point: NormalizedPoint = {
        id: 'humidity-rh',
        originalName: 'HUMIDITY_RH',
        normalizedName: 'Humidity RH',
        objectType: 'AI',
        unit: '%RH'
      };

      const result = await tagger.generateHaystackTags(point);
      expect(result.tags).toContain('humidity');
    });
  });

  describe('Equipment Context Tagging', () => {
    it('should tag AHU equipment properly', async () => {
      const point: NormalizedPoint = {
        id: 'ahu-point',
        originalName: 'AHU_1_SF_STATUS',
        normalizedName: 'AHU 1 Supply Fan Status',
        objectType: 'BI',
        equipmentType: 'AHU',
        equipmentId: 'ahu-001'
      };

      const result = await tagger.generateHaystackTags(point);
      expect(result.tags).toContain('ahu');
      expect(result.tags).toContain('equip');
      expect(result.tags).toContain('fan');
      expect(result.tags.some(tag => tag.startsWith('equipRef:'))).toBe(true);
    });

    it('should tag VAV equipment properly', async () => {
      const point: NormalizedPoint = {
        id: 'vav-point',
        originalName: 'VAV_101_DAMPER_CMD',
        normalizedName: 'VAV 101 Damper Command',
        objectType: 'AO',
        equipmentType: 'VAV',
        equipmentId: 'vav-101'
      };

      const result = await tagger.generateHaystackTags(point);
      expect(result.tags).toContain('vav');
      expect(result.tags).toContain('equip');
      expect(result.tags).toContain('damper');
      expect(result.tags).toContain('cmd');
    });

    it('should tag Chiller equipment properly', async () => {
      const point: NormalizedPoint = {
        id: 'chiller-point',
        originalName: 'CHILLER_1_EWT',
        normalizedName: 'Chiller 1 Entering Water Temperature',
        objectType: 'AI',
        unit: '°F',
        equipmentType: 'Chiller'
      };

      const result = await tagger.generateHaystackTags(point);
      expect(result.tags).toContain('chiller');
      expect(result.tags).toContain('equip');
      expect(result.tags).toContain('temp');
      expect(result.tags).toContain('entering');
    });
  });

  describe('Location Context Tagging', () => {
    it('should identify zone location', async () => {
      const point: NormalizedPoint = {
        id: 'zone-temp',
        originalName: 'ZONE_TEMP_101',
        normalizedName: 'Zone Temperature 101',
        objectType: 'AI',
        unit: '°F'
      };

      const result = await tagger.generateHaystackTags(point);
      expect(result.tags).toContain('zone');
      expect(result.tags).toContain('temp');
    });

    it('should identify discharge location', async () => {
      const point: NormalizedPoint = {
        id: 'discharge-temp',
        originalName: 'DISCHARGE_AIR_TEMP',
        normalizedName: 'Discharge Air Temperature',
        objectType: 'AI',
        unit: '°F'
      };

      const result = await tagger.generateHaystackTags(point);
      expect(result.tags).toContain('discharge');
      expect(result.tags).toContain('temp');
    });

    it('should identify return location', async () => {
      const point: NormalizedPoint = {
        id: 'return-temp',
        originalName: 'RETURN_AIR_TEMP',
        normalizedName: 'Return Air Temperature',
        objectType: 'AI',
        unit: '°F'
      };

      const result = await tagger.generateHaystackTags(point);
      expect(result.tags).toContain('return');
      expect(result.tags).toContain('temp');
    });

    it('should identify outside location', async () => {
      const point: NormalizedPoint = {
        id: 'outside-temp',
        originalName: 'OAT_SENSOR',
        normalizedName: 'Outside Air Temperature Sensor',
        objectType: 'AI',
        unit: '°F'
      };

      const result = await tagger.generateHaystackTags(point);
      expect(result.tags).toContain('outside');
      expect(result.tags).toContain('temp');
    });
  });

  describe('Semantic Inference', () => {
    it('should apply semantic patterns for AHU supply air temp', async () => {
      const point: NormalizedPoint = {
        id: 'ahu-supply-temp',
        originalName: 'AHU_1_SAT',
        normalizedName: 'AHU 1 Supply Air Temperature',
        objectType: 'AI',
        unit: '°F',
        equipmentType: 'AHU'
      };

      const result = await tagger.generateHaystackTags(point);
      expect(result.tags).toContain('ahu');
      expect(result.tags).toContain('discharge');
      expect(result.tags).toContain('air');
      expect(result.tags).toContain('temp');
      expect(result.tags).toContain('sensor');
    });

    it('should apply semantic patterns for VAV reheat valve', async () => {
      const point: NormalizedPoint = {
        id: 'vav-reheat',
        originalName: 'VAV_101_RH_VLV_CMD',
        normalizedName: 'VAV 101 Reheat Valve Command',
        objectType: 'AO',
        equipmentType: 'VAV'
      };

      const result = await tagger.generateHaystackTags(point);
      expect(result.tags).toContain('vav');
      expect(result.tags).toContain('valve');
      expect(result.tags).toContain('cmd');
      expect(result.tags).toContain('reheat');
    });

    it('should apply semantic patterns for chiller water temp', async () => {
      const point: NormalizedPoint = {
        id: 'chiller-water-temp',
        originalName: 'CHW_SUPPLY_TEMP',
        normalizedName: 'Chilled Water Supply Temperature',
        objectType: 'AI',
        unit: '°F',
        equipmentType: 'Chiller'
      };

      const result = await tagger.generateHaystackTags(point);
      expect(result.tags).toContain('chiller');
      expect(result.tags).toContain('water');
      expect(result.tags).toContain('temp');
      expect(result.tags).toContain('supply');
    });
  });

  describe('Vendor-Specific Context', () => {
    it('should add vendor tags when enabled', async () => {
      const point: NormalizedPoint = {
        id: 'vendor-point',
        originalName: 'TEMP_01',
        normalizedName: 'Temperature 01',
        objectType: 'AI',
        unit: '°F',
        vendor: 'Schneider Electric'
      };

      const result = await tagger.generateHaystackTags(point);
      expect(result.tags.some(tag => tag.startsWith('vendor:'))).toBe(true);
      expect(result.tags).toContain('vendor:schneider-electric');
    });

    it('should not add vendor tags when disabled', async () => {
      const taggerNoVendor = new HaystackTagger({
        includeVendorTags: false
      });

      const point: NormalizedPoint = {
        id: 'vendor-point',
        originalName: 'TEMP_01',
        normalizedName: 'Temperature 01',
        objectType: 'AI',
        unit: '°F',
        vendor: 'Schneider Electric'
      };

      const result = await taggerNoVendor.generateHaystackTags(point);
      expect(result.tags.some(tag => tag.startsWith('vendor:'))).toBe(false);
    });
  });

  describe('Validation and Compliance', () => {
    it('should validate generated tags', async () => {
      const point: NormalizedPoint = {
        id: 'validation-test',
        originalName: 'AHU_1_TEMP',
        normalizedName: 'AHU 1 Temperature',
        objectType: 'AI',
        unit: '°F',
        equipmentType: 'AHU'
      };

      const result = await tagger.generateHaystackTags(point);
      const validation = await tagger.validateTags(result);

      expect(validation.valid).toBe(true);
      expect(validation.compliance).toBeGreaterThan(80);
    });

    it('should handle validation errors gracefully', async () => {
      const invalidTags = ['invalid-tag', 'another-invalid'];
      const validation = validateHaystackTags(invalidTags);

      expect(validation.valid).toBe(false);
      expect(validation.errors.length).toBeGreaterThan(0);
    });
  });

  describe('Export Functionality', () => {
    it('should export to SkySpark format', async () => {
      const point: NormalizedPoint = {
        id: 'export-test',
        originalName: 'AHU_1_TEMP',
        normalizedName: 'AHU 1 Temperature',
        objectType: 'AI',
        unit: '°F',
        equipmentType: 'AHU'
      };

      const result = await tagger.generateHaystackTags(point);
      const exported = await tagger.exportTags([result], 'skyspark');

      expect(exported).toContain('ver:"3.0"');
      expect(exported).toContain(result.id);
      expect(exported).toContain(result.dis);
    });

    it('should export to Zinc format', async () => {
      const point: NormalizedPoint = {
        id: 'export-zinc',
        originalName: 'AHU_1_TEMP',
        normalizedName: 'AHU 1 Temperature',
        objectType: 'AI',
        unit: '°F',
        equipmentType: 'AHU'
      };

      const result = await tagger.generateHaystackTags(point);
      const exported = await tagger.exportTags([result], 'zinc');

      expect(exported).toContain('ver:"3.0"');
      expect(exported).toContain(result.id);
    });

    it('should export to Trio format', async () => {
      const point: NormalizedPoint = {
        id: 'export-trio',
        originalName: 'AHU_1_TEMP',
        normalizedName: 'AHU 1 Temperature',
        objectType: 'AI',
        unit: '°F',
        equipmentType: 'AHU'
      };

      const result = await tagger.generateHaystackTags(point);
      const exported = await tagger.exportTags([result], 'trio');

      expect(exported).toContain(`id: @${result.id}`);
      expect(exported).toContain(`dis: "${result.dis}"`);
    });
  });

  describe('Batch Processing', () => {
    it('should process multiple points in batch', async () => {
      const points: NormalizedPoint[] = [
        {
          id: 'batch-1',
          originalName: 'AHU_1_TEMP',
          normalizedName: 'AHU 1 Temperature',
          objectType: 'AI',
          unit: '°F',
          equipmentType: 'AHU'
        },
        {
          id: 'batch-2',
          originalName: 'VAV_101_DAMPER',
          normalizedName: 'VAV 101 Damper',
          objectType: 'AO',
          equipmentType: 'VAV'
        },
        {
          id: 'batch-3',
          originalName: 'CHILLER_1_STATUS',
          normalizedName: 'Chiller 1 Status',
          objectType: 'BI',
          equipmentType: 'Chiller'
        }
      ];

      const results = await tagger.processBatch(points);

      expect(results).toHaveLength(3);
      expect(results[0].id).toBe('batch-1');
      expect(results[1].id).toBe('batch-2');
      expect(results[2].id).toBe('batch-3');

      // Check that each result has appropriate tags
      expect(results[0].tags).toContain('temp');
      expect(results[1].tags).toContain('damper');
      expect(results[2].tags).toContain('chiller');
    });

    it('should handle errors in batch processing', async () => {
      const points: NormalizedPoint[] = [
        {
          id: 'good-point',
          originalName: 'AHU_1_TEMP',
          normalizedName: 'AHU 1 Temperature',
          objectType: 'AI',
          unit: '°F',
          equipmentType: 'AHU'
        },
        // This point might cause issues
        {
          id: 'problematic-point',
          originalName: '',
          normalizedName: '',
          objectType: ''
        }
      ];

      const results = await tagger.processBatch(points);

      expect(results).toHaveLength(2);
      expect(results[0].tags).toContain('temp'); // Good point should work
      expect(results[1].warnings).toBeDefined(); // Problematic point should have warnings
    });
  });

  describe('Complex Real-world Scenarios', () => {
    it('should handle AHU supply air temperature sensor', async () => {
      const point: NormalizedPoint = {
        id: 'ahu-sat-sensor',
        originalName: 'AHU_01_SAT_SENSOR',
        normalizedName: 'AHU 01 Supply Air Temperature Sensor',
        objectType: 'AI',
        unit: '°F',
        equipmentType: 'AHU',
        equipmentId: 'ahu-01',
        description: 'Supply air temperature sensor for AHU 01'
      };

      const result = await tagger.generateHaystackTags(point);

      expect(result.tags).toContain('point');
      expect(result.tags).toContain('sensor');
      expect(result.tags).toContain('temp');
      expect(result.tags).toContain('ahu');
      expect(result.tags).toContain('discharge');
      expect(result.tags).toContain('air');
      expect(result.confidence).toBeGreaterThan(0.8);
    });

    it('should handle VAV reheat valve command', async () => {
      const point: NormalizedPoint = {
        id: 'vav-reheat-cmd',
        originalName: 'VAV_201_RH_VLV_CMD',
        normalizedName: 'VAV 201 Reheat Valve Command',
        objectType: 'AO',
        equipmentType: 'VAV',
        equipmentId: 'vav-201',
        description: 'Reheat valve position command for VAV box 201'
      };

      const result = await tagger.generateHaystackTags(point);

      expect(result.tags).toContain('point');
      expect(result.tags).toContain('cmd');
      expect(result.tags).toContain('valve');
      expect(result.tags).toContain('vav');
      expect(result.tags).toContain('reheat');
      expect(result.confidence).toBeGreaterThan(0.8);
    });

    it('should handle chiller entering water temperature', async () => {
      const point: NormalizedPoint = {
        id: 'chiller-ewt',
        originalName: 'CH_01_EWT_SENSOR',
        normalizedName: 'Chiller 01 Entering Water Temperature Sensor',
        objectType: 'AI',
        unit: '°F',
        equipmentType: 'Chiller',
        equipmentId: 'ch-01',
        description: 'Chilled water entering temperature sensor'
      };

      const result = await tagger.generateHaystackTags(point);

      expect(result.tags).toContain('point');
      expect(result.tags).toContain('sensor');
      expect(result.tags).toContain('temp');
      expect(result.tags).toContain('chiller');
      expect(result.tags).toContain('entering');
      expect(result.tags).toContain('water');
      expect(result.confidence).toBeGreaterThan(0.8);
    });
  });

  describe('Error Handling', () => {
    it('should handle missing required fields gracefully', async () => {
      const point: NormalizedPoint = {
        id: 'minimal-point',
        originalName: 'UNKNOWN',
        normalizedName: 'Unknown Point'
      };

      const result = await tagger.generateHaystackTags(point);

      expect(result.id).toBe('minimal-point');
      expect(result.tags).toContain('point');
      expect(result.confidence).toBeLessThan(0.5);
      expect(result.warnings).toBeDefined();
    });

    it('should handle invalid object types', async () => {
      const point: NormalizedPoint = {
        id: 'invalid-obj-type',
        originalName: 'INVALID_OBJ',
        normalizedName: 'Invalid Object Type',
        objectType: 'INVALID'
      };

      const result = await tagger.generateHaystackTags(point);

      expect(result.id).toBe('invalid-obj-type');
      expect(result.tags).toContain('point');
      expect(result.confidence).toBeLessThan(0.5);
    });
  });

  describe('Configuration Management', () => {
    it('should return current configuration', () => {
      const config = tagger.getConfiguration();

      expect(config.enableSemanticInference).toBe(true);
      expect(config.includeVendorTags).toBe(true);
      expect(config.strictValidation).toBe(true);
      expect(config.exportFormat).toBe('skyspark');
      expect(config.confidenceThreshold).toBe(0.7);
    });

    it('should update configuration', () => {
      tagger.updateConfiguration({
        enableSemanticInference: false,
        confidenceThreshold: 0.5
      });

      const config = tagger.getConfiguration();

      expect(config.enableSemanticInference).toBe(false);
      expect(config.confidenceThreshold).toBe(0.5);
      expect(config.includeVendorTags).toBe(true); // Should remain unchanged
    });
  });

  describe('Compliance Reporting', () => {
    it('should generate compliance report for batch results', async () => {
      const points: NormalizedPoint[] = [
        {
          id: 'compliance-1',
          originalName: 'AHU_1_TEMP',
          normalizedName: 'AHU 1 Temperature',
          objectType: 'AI',
          unit: '°F',
          equipmentType: 'AHU'
        },
        {
          id: 'compliance-2',
          originalName: 'VAV_101_DAMPER',
          normalizedName: 'VAV 101 Damper',
          objectType: 'AO',
          equipmentType: 'VAV'
        }
      ];

      const results = await tagger.processBatch(points);
      expect(results).toHaveLength(2);

      // Each result should have reasonable compliance
      for (const result of results) {
        expect(result.confidence).toBeGreaterThan(0.5);
        expect(result.tags).toContain('point');
      }
    });
  });
}); 