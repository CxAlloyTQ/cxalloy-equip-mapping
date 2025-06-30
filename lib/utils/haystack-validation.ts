/**
 * Project Haystack v5 Compliance Validation and Export Utilities
 * Validates tags against Haystack specifications and exports to various formats
 */

import { HaystackTagSet, TagValidationResult, HaystackComplianceReport } from '@/types/haystack';

/**
 * Official Project Haystack v5 marker definitions
 */
const OFFICIAL_HAYSTACK_MARKERS = new Set([
  // Core markers
  'point', 'equip', 'site', 'space', 'floor', 'ref', 'marker',
  
  // Point role markers
  'sensor', 'cmd', 'sp', 'setpoint',
  
  // Physical quantity markers
  'temp', 'temperature', 'pressure', 'flow', 'humidity', 'power', 'energy',
  'voltage', 'current', 'freq', 'frequency', 'co2', 'co', 'voc',
  
  // Equipment markers
  'ahu', 'vav', 'rtu', 'chiller', 'boiler', 'pump', 'fan', 'humidifier',
  'dehumidifier', 'fcu', 'cuh', 'uh', 'coolingTower', 'heatExchanger',
  'elecPanel', 'elecMeter', 'economizer',
  
  // Location markers
  'zone', 'discharge', 'return', 'outside', 'mixed', 'exhaust', 'relief',
  'entering', 'leaving', 'supply', 'coil', 'filter', 'damper', 'valve',
  'duct', 'pipe', 'roof', 'basement', 'mechanical',
  
  // System markers
  'hvac', 'elec', 'water', 'air', 'hot', 'chilled', 'condenser',
  'cooling', 'heating', 'reheat',
  
  // Property markers
  'writable', 'analog', 'binary', 'enum', 'run', 'enable', 'status',
  'alarm', 'fault', 'feedback', 'position', 'speed', 'stage',
  
  // Unit markers
  'fahrenheit', 'celsius', 'kelvin', 'pascal', 'percentage', 'electric',
  'min', 'max', 'high', 'low', 'static', 'differential',
  
  // Quality markers
  'concentration', 'quality', 'time', 'level', 'angle',
  
  // Equipment component markers
  'compressor', 'evaporator', 'condenser', 'burner', 'flame',
  
  // Scheduling and control markers
  'schedule', 'override', 'manual', 'auto'
]);

/**
 * Deprecated or non-standard markers that should be flagged
 */
const DEPRECATED_MARKERS = new Set([
  'bacnet', 'vendor', 'device', 'network', 'instance'
]);

/**
 * Required marker combinations for semantic completeness
 */
const REQUIRED_COMBINATIONS = [
  {
    name: 'Point Role',
    description: 'All points should have a role marker',
    required: ['point'],
    shouldHave: ['sensor', 'cmd', 'sp'],
    severity: 'warning'
  },
  {
    name: 'Equipment Context',
    description: 'HVAC points should have equipment context',
    required: ['point', 'hvac'],
    shouldHave: ['ahu', 'vav', 'rtu', 'chiller', 'boiler', 'pump', 'fan'],
    severity: 'info'
  },
  {
    name: 'Physical Quantity',
    description: 'Sensor points should have physical quantity',
    required: ['point', 'sensor'],
    shouldHave: ['temp', 'pressure', 'flow', 'humidity', 'power', 'energy'],
    severity: 'info'
  }
];

/**
 * Conflicting marker combinations that should not coexist
 */
const CONFLICTING_COMBINATIONS = [
  {
    name: 'Multiple Roles',
    description: 'Points should not have multiple role markers',
    markers: ['sensor', 'cmd', 'sp'],
    maxAllowed: 1,
    severity: 'error'
  },
  {
    name: 'Temperature Units',
    description: 'Points should not have multiple temperature unit markers',
    markers: ['fahrenheit', 'celsius', 'kelvin'],
    maxAllowed: 1,
    severity: 'warning'
  },
  {
    name: 'Equipment Types',
    description: 'Points should not have multiple primary equipment types',
    markers: ['ahu', 'vav', 'rtu', 'chiller', 'boiler'],
    maxAllowed: 1,
    severity: 'warning'
  }
];

/**
 * Validate Haystack tags against Project Haystack v5 specifications
 */
export function validateHaystackTags(tagSet: HaystackTagSet): TagValidationResult {
  const result: TagValidationResult = {
    isValid: true,
    valid: true,
    errors: [],
    warnings: [],
    suggestions: [],
    completeness: 1.0,
    confidence: 1.0,
    compliance: {
      level: 'full',
      score: 100,
      details: []
    }
  };

  let complianceScore = 100;

  // Validate individual markers
  for (const marker of tagSet.markers || []) {
    if (!OFFICIAL_HAYSTACK_MARKERS.has(marker)) {
      if (DEPRECATED_MARKERS.has(marker)) {
        result.warnings.push(`Deprecated marker: ${marker}`);
        complianceScore -= 2;
      } else if (!marker.includes(':')) { // Allow vendor-specific markers with colons
        result.warnings.push(`Non-standard marker: ${marker}`);
        complianceScore -= 3;
      }
    }
  }

  // Check for required combinations
  for (const combination of REQUIRED_COMBINATIONS) {
    const hasRequired = combination.required.every(marker => tagSet.markers?.includes(marker));
    if (hasRequired) {
      const hasShouldHave = combination.shouldHave.some(marker => tagSet.markers?.includes(marker));
      if (!hasShouldHave) {
        const message = `${combination.name}: ${combination.description}. Consider adding one of: ${combination.shouldHave.join(', ')}`;
        if (combination.severity === 'warning') {
          result.warnings.push(message);
          complianceScore -= 5;
        } else {
          result.suggestions.push(message);
          complianceScore -= 2;
        }
      }
    }
  }

  // Check for conflicting combinations
  for (const conflict of CONFLICTING_COMBINATIONS) {
    const presentMarkers = conflict.markers.filter(marker => tagSet.markers?.includes(marker));
    if (presentMarkers.length > conflict.maxAllowed) {
      const message = `${conflict.name}: ${conflict.description}. Found: ${presentMarkers.join(', ')}`;
      if (conflict.severity === 'error') {
        result.errors.push(message);
        result.valid = false;
        result.isValid = false;
        complianceScore -= 15;
      } else {
        result.warnings.push(message);
        complianceScore -= 8;
      }
    }
  }

  // Validate required base marker
  if (!tagSet.markers?.includes('point')) {
    result.errors.push('Missing required "point" marker');
    result.valid = false;
    result.isValid = false;
    complianceScore -= 20;
  }

  // Validate tag structure
  const structureValidation = validateTagStructure(tagSet);
  result.errors.push(...structureValidation.errors);
  result.warnings.push(...structureValidation.warnings);
  if (structureValidation.errors.length > 0) {
    result.valid = false;
    result.isValid = false;
  }
  complianceScore -= structureValidation.errors.length * 10;
  complianceScore -= structureValidation.warnings.length * 3;

  // Validate references
  const refValidation = validateReferences(tagSet);
  result.warnings.push(...refValidation.warnings);
  complianceScore -= refValidation.warnings.length * 2;

  // Set compliance level and score
  complianceScore = Math.max(0, complianceScore);
  if (result.compliance) {
    result.compliance.score = complianceScore;
    
    if (complianceScore >= 95) {
      result.compliance.level = 'full';
    } else if (complianceScore >= 80) {
      result.compliance.level = 'high';
    } else if (complianceScore >= 60) {
      result.compliance.level = 'medium';
    } else {
      result.compliance.level = 'low';
    }

    result.compliance.details = [
      `Compliance Score: ${complianceScore}/100`,
      `Compliance Level: ${result.compliance.level}`,
      `Errors: ${result.errors.length}`,
      `Warnings: ${result.warnings.length}`,
      `Suggestions: ${result.suggestions.length}`
    ];
  }

  return result;
}

/**
 * Validate tag structure and syntax
 */
function validateTagStructure(tagSet: HaystackTagSet): { errors: string[]; warnings: string[] } {
  const errors: string[] = [];
  const warnings: string[] = [];

  // Validate ID
  if (!tagSet.id || typeof tagSet.id !== 'string') {
    errors.push('Invalid or missing point ID');
  } else if (!/^[a-zA-Z][a-zA-Z0-9_]*$/.test(tagSet.id)) {
    warnings.push('Point ID should follow Haystack naming conventions (alphanumeric + underscore)');
  }

  // Validate display name
  if (!tagSet.dis || typeof tagSet.dis !== 'string') {
    warnings.push('Missing display name (dis)');
  }

  // Validate marker syntax
  for (const marker of tagSet.markers || []) {
    if (typeof marker !== 'string') {
      errors.push(`Invalid marker type: ${typeof marker}`);
    } else if (marker.includes(' ')) {
      errors.push(`Marker contains spaces: ${marker}`);
    } else if (marker.length === 0) {
      errors.push('Empty marker detected');
    }
  }

  // Validate references
  for (const ref of tagSet.refs || []) {
    if (!ref.name || !ref.id) {
      errors.push(`Invalid reference structure: ${JSON.stringify(ref)}`);
    }
  }

  // Validate values
  if (tagSet.values) {
    for (const [key, value] of Object.entries(tagSet.values)) {
      if (key.includes(' ')) {
        warnings.push(`Value key contains spaces: ${key}`);
      }
      if (value === null || value === undefined) {
        warnings.push(`Null/undefined value for key: ${key}`);
      }
    }
  }

  return { errors, warnings };
}

/**
 * Validate references
 */
function validateReferences(tagSet: HaystackTagSet): { warnings: string[] } {
  const warnings: string[] = [];

  for (const ref of tagSet.refs || []) {
    // Check for common reference patterns
    if (ref.name === 'equipRef' && !ref.id.match(/^[a-zA-Z][a-zA-Z0-9_]*$/)) {
      warnings.push(`Equipment reference should follow naming conventions: ${ref.id}`);
    }
    
    if (ref.name === 'siteRef' && !ref.id.match(/^[a-zA-Z][a-zA-Z0-9_]*$/)) {
      warnings.push(`Site reference should follow naming conventions: ${ref.id}`);
    }

    // Note: refs structure doesn't include display names in this interface
  }

  return { warnings };
}

/**
 * Export tags to SkySpark format
 */
export function exportToSkySpark(tagSet: HaystackTagSet): string {
  const lines: string[] = [];
  
  // Header
  lines.push('ver:"3.0"');
  lines.push('');
  
  // Column definitions
  const columns = ['id', 'dis'];
  
  // Add marker columns
  for (const marker of (tagSet.markers || []).sort()) {
    columns.push(marker);
  }
  
  // Add value columns
  if (tagSet.values) {
    for (const key of Object.keys(tagSet.values).sort()) {
      if (!columns.includes(key)) {
        columns.push(key);
      }
    }
  }
  
  // Add reference columns
  for (const ref of tagSet.refs || []) {
    if (!columns.includes(ref.name)) {
      columns.push(ref.name);
    }
  }
  
  lines.push(columns.join(','));
  
  // Data row
  const row: string[] = [];
  
  for (const column of columns) {
    if (column === 'id') {
      row.push(`@${tagSet.id}`);
    } else if (column === 'dis') {
      row.push(`"${tagSet.dis}"`);
    } else if (tagSet.markers?.includes(column)) {
      row.push('M');
    } else if (tagSet.values && column in tagSet.values) {
      const value = tagSet.values[column];
      if (typeof value === 'string') {
        row.push(`"${value}"`);
      } else if (typeof value === 'number') {
        row.push(value.toString());
      } else if (typeof value === 'boolean') {
        row.push(value ? 'T' : 'F');
      } else {
        row.push(`"${String(value)}"`);
      }
    } else {
      // Check references
      const ref = tagSet.refs?.find(r => r.name === column);
      if (ref) {
        row.push(`@${ref.id}`);
      } else {
        row.push('');
      }
    }
  }
  
  lines.push(row.join(','));
  
  return lines.join('\n');
}

/**
 * Export tags to Zinc format
 */
export function exportToZinc(tagSet: HaystackTagSet): string {
  const lines: string[] = [];
  
  // Header
  lines.push('ver:"3.0"');
  
  // Grid definition
  const grid = {
    meta: tagSet.meta || {},
    cols: [] as Array<{ name: string; meta?: any }>,
    rows: [] as Array<Record<string, any>>
  };
  
  // Define columns
  grid.cols.push({ name: 'id' });
  grid.cols.push({ name: 'dis' });
  
  // Add marker columns
  for (const marker of (tagSet.markers || []).sort()) {
    grid.cols.push({ name: marker });
  }
  
  // Add value columns
  if (tagSet.values) {
    for (const key of Object.keys(tagSet.values).sort()) {
      grid.cols.push({ name: key });
    }
  }
  
  // Create row
  const row: Record<string, any> = {
    id: `r:${tagSet.id}`,
    dis: tagSet.dis
  };
  
  // Add markers
  for (const marker of (tagSet.markers || []).sort()) {
    row[marker] = 'm:';
  }
  
  // Add values
  if (tagSet.values) {
    for (const [key, value] of Object.entries(tagSet.values)) {
      if (typeof value === 'string') {
        row[key] = `s:${value}`;
      } else if (typeof value === 'number') {
        row[key] = `n:${value}`;
      } else if (typeof value === 'boolean') {
        row[key] = value ? 't:' : 'f:';
      }
    }
  }
  
  grid.rows.push(row);
  
  // Format as Zinc
  lines.push(JSON.stringify(grid, null, 2));
  
  return lines.join('\n');
}

/**
 * Export tags to Trio format
 */
export function exportToTrio(tagSet: HaystackTagSet): string {
  const lines: string[] = [];
  
  // Point definition
  lines.push(`id: @${tagSet.id}`);
  lines.push(`dis: "${tagSet.dis}"`);
  
  // Add markers
  for (const marker of (tagSet.markers || []).sort()) {
    lines.push(`${marker}`);
  }
  
  // Add values
  if (tagSet.values) {
    for (const [key, value] of Object.entries(tagSet.values).sort()) {
      if (typeof value === 'string') {
        lines.push(`${key}: "${value}"`);
      } else if (typeof value === 'number') {
        lines.push(`${key}: ${value}`);
      } else if (typeof value === 'boolean') {
        lines.push(`${key}: ${value ? 'T' : 'F'}`);
      } else {
        lines.push(`${key}: "${String(value)}"`);
      }
    }
  }
  
  // Add references
  for (const ref of tagSet.refs || []) {
    lines.push(`${ref.name}: @${ref.id}`);
  }
  
  return lines.join('\n');
}

/**
 * Generate compliance report
 */
export function generateComplianceReport(results: TagValidationResult[]): {
  summary: {
    totalPoints: number;
    validPoints: number;
    averageScore: number;
    complianceLevels: Record<string, number>;
  };
  issues: {
    errors: Array<{ message: string; count: number }>;
    warnings: Array<{ message: string; count: number }>;
    suggestions: Array<{ message: string; count: number }>;
  };
  recommendations: string[];
} {
  const summary = {
    totalPoints: results.length,
    validPoints: results.filter(r => r.valid).length,
    averageScore: results.reduce((sum, r) => sum + (r.compliance?.score || 0), 0) / results.length,
    complianceLevels: {
      full: results.filter(r => r.compliance?.level === 'full').length,
      high: results.filter(r => r.compliance?.level === 'high').length,
      medium: results.filter(r => r.compliance?.level === 'medium').length,
      low: results.filter(r => r.compliance?.level === 'low').length,
    },
  };

  // Aggregate issues
  const errorCounts = new Map<string, number>();
  const warningCounts = new Map<string, number>();
  const suggestionCounts = new Map<string, number>();

  results.forEach(result => {
    result.errors.forEach(error => {
      errorCounts.set(error, (errorCounts.get(error) || 0) + 1);
    });
    result.warnings.forEach(warning => {
      warningCounts.set(warning, (warningCounts.get(warning) || 0) + 1);
    });
    result.suggestions.forEach(suggestion => {
      suggestionCounts.set(suggestion, (suggestionCounts.get(suggestion) || 0) + 1);
    });
  });

  const issues = {
    errors: Array.from(errorCounts.entries()).map(([message, count]) => ({ message, count }))
      .sort((a, b) => b.count - a.count),
    warnings: Array.from(warningCounts.entries()).map(([message, count]) => ({ message, count }))
      .sort((a, b) => b.count - a.count),
    suggestions: Array.from(suggestionCounts.entries()).map(([message, count]) => ({ message, count }))
      .sort((a, b) => b.count - a.count)
  };

  // Generate recommendations
  const recommendations: string[] = [];
  
  if (summary.averageScore < 80) {
    recommendations.push('Consider reviewing point naming conventions and tag assignments');
  }
  
  if (issues.errors.length > 0) {
    recommendations.push('Address critical errors to ensure Haystack compliance');
  }
  
  if (summary.complianceLevels.low > summary.totalPoints * 0.2) {
    recommendations.push('More than 20% of points have low compliance - review tagging strategy');
  }
  
  if (issues.warnings.some(w => w.message.includes('role marker'))) {
    recommendations.push('Ensure all points have appropriate role markers (sensor, cmd, sp)');
  }

  return { summary, issues, recommendations };
}

/**
 * Validate batch of tag sets
 */
export function validateBatchHaystackTags(tagSets: HaystackTagSet[]): TagValidationResult[] {
  return tagSets.map(tagSet => validateHaystackTags(tagSet));
}

/**
 * Generate comprehensive compliance report for batch analysis
 */
export function generateBatchComplianceReport(tagSets: HaystackTagSet[]): HaystackComplianceReport {
  const report: HaystackComplianceReport = {
    totalEntities: tagSets.length,
    compliantEntities: 0,
    complianceRate: 0,
    generatedAt: new Date(),
    totalPoints: tagSets.length,
    validPoints: 0,
    averageCompliance: 0,
    complianceDistribution: { full: 0, high: 0, medium: 0, low: 0 },
    commonIssues: [],
    recommendations: [],
    tagStatistics: { mostCommonTags: [], unusualTags: [], deprecatedTags: [] },
  };

  if (tagSets.length === 0) {
    return report;
  }

  let totalCompliance = 0;
  const tagCounts = new Map<string, number>();
  const allIssues: string[] = [];
  const deprecatedTags = new Set<string>();
  const unusualTags = new Set<string>();

  // Analyze each tag set
  for (const tagSet of tagSets) {
    const validation = validateHaystackTags(tagSet);
    
    if (validation.valid) {
      report.validPoints = (report.validPoints || 0) + 1;
    }
    
    totalCompliance += (validation.compliance?.score || 0);
    // Count compliance levels
    if (validation.compliance?.level && report.complianceDistribution) {
      report.complianceDistribution[validation.compliance.level]++;
    }
    
    // Collect issues
    allIssues.push(...validation.errors, ...validation.warnings);
    
    // Count tag usage
    for (const tag of tagSet.markers || []) {
      tagCounts.set(tag, (tagCounts.get(tag) || 0) + 1);
      const baseTag = tag.split(':')[0];
      if (DEPRECATED_MARKERS.has(baseTag)) {
        deprecatedTags.add(tag);
      } else if (!OFFICIAL_HAYSTACK_MARKERS.has(baseTag) && !tag.includes(':')) {
        unusualTags.add(tag);
      }
    }
  }

  // Calculate averages
  report.averageCompliance = Math.round(totalCompliance / tagSets.length);

  // Find most common tags
  if (report.tagStatistics) {
    report.tagStatistics.mostCommonTags = Array.from(tagCounts.entries())
      .sort((a, b) => b[1] - a[1])
      .slice(0, 10);
    report.tagStatistics.unusualTags = Array.from(tagCounts.entries())
      .filter(([tag, count]) => count === 1)
      .map(([tag]) => tag);
    report.tagStatistics.deprecatedTags = Array.from(deprecatedTags);
  }

  // Find common issues
  const issueCounts = new Map<string, number>();
  for (const issue of allIssues) {
    issueCounts.set(issue, (issueCounts.get(issue) || 0) + 1);
  }

  report.commonIssues = Array.from(issueCounts.entries())
    .sort((a, b) => b[1] - a[1])
    .slice(0, 5)
    .map(([issue, count]) => ({ issue, count, severity: 'medium' as const }));

  // Generate recommendations
  if (report.averageCompliance < 80) {
    report.recommendations.push('Consider reviewing tag assignments to improve Haystack compliance');
  }

  if (deprecatedTags.size > 0) {
    report.recommendations.push(`Update ${deprecatedTags.size} deprecated markers to current Haystack v5 standards`);
  }

  if (unusualTags.size > 0) {
    report.recommendations.push(`Review ${unusualTags.size} non-standard tags for potential standardization`);
  }

  if ((report.validPoints || 0) / (report.totalPoints || 1) < 0.9) {
    report.recommendations.push('Focus on resolving validation errors to improve point quality');
  }

  return report;
}

/**
 * Validate tag structure and references
 */
export function validateTagListStructure(tags: string[]): {
  valid: boolean;
  structureErrors: string[];
  referenceErrors: string[];
} {
  const structureErrors: string[] = [];
  const referenceErrors: string[] = [];

  for (const tag of tags) {
    // Check tag format
    if (tag.includes(' ')) {
      structureErrors.push(`Tag contains spaces: "${tag}"`);
    }

    if (tag.startsWith('-') || tag.endsWith('-')) {
      structureErrors.push(`Tag has invalid format: "${tag}"`);
    }

    // Check reference format
    if (tag.includes('Ref:')) {
      const refValue = tag.split(':')[1];
      if (!refValue || refValue.length === 0) {
        referenceErrors.push(`Empty reference value: "${tag}"`);
      }
    }

    // Check vendor tag format
    if (tag.startsWith('vendor:')) {
      const vendorValue = tag.split(':')[1];
      if (!vendorValue || vendorValue.length === 0) {
        referenceErrors.push(`Empty vendor value: "${tag}"`);
      }
    }
  }

  return {
    valid: structureErrors.length === 0 && referenceErrors.length === 0,
    structureErrors,
    referenceErrors
  };
}

/**
 * Suggest improvements for tag sets
 */
export function suggestTagImprovements(tags: string[]): {
  additions: string[];
  removals: string[];
  replacements: Array<{ old: string; new: string; reason: string }>;
} {
  const additions: string[] = [];
  const removals: string[] = [];
  const replacements: Array<{ old: string; new: string; reason: string }> = [];

  // Suggest required additions
  if (tags.includes('temp') && !tags.some(t => ['sensor', 'cmd', 'sp'].includes(t))) {
    additions.push('sensor'); // Default suggestion for temperature points
  }

  if (tags.includes('equip') && !tags.some(t => ['ahu', 'vav', 'rtu', 'chiller', 'boiler', 'pump', 'fan'].includes(t))) {
    additions.push('ahu'); // Default equipment type suggestion
  }

  // Suggest replacements for deprecated tags
  const deprecatedReplacements: Record<string, { new: string; reason: string }> = {
    'cur': { new: 'sensor', reason: 'Replace deprecated "cur" with "sensor"' },
    'writable': { new: 'cmd', reason: 'Replace deprecated "writable" with "cmd"' },
    'kind': { new: '', reason: 'Remove deprecated "kind" marker' }
  };

  for (const tag of tags) {
    if (deprecatedReplacements[tag]) {
      const replacement = deprecatedReplacements[tag];
      if (replacement.new) {
        replacements.push({ old: tag, new: replacement.new, reason: replacement.reason });
      } else {
        removals.push(tag);
      }
    }
  }

  return { additions, removals, replacements };
}

// Export validation utilities
export default {
  validateHaystackTags,
  exportToSkySpark,
  exportToZinc,
  exportToTrio,
  generateComplianceReport,
  validateTagStructure,
  suggestTagImprovements,
  OFFICIAL_HAYSTACK_MARKERS,
  DEPRECATED_MARKERS
}; 