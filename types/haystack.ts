/**
 * Comprehensive TypeScript interfaces for Project Haystack v5 integration
 * Supports semantic tagging, validation, and export functionality
 */

// Core Haystack types
export interface HaystackMarker {
  name: string;
  value?: string | number | boolean;
}

export interface HaystackTagSet {
  id: string;
  dis: string;
  tags: string[];
  confidence: number;
  metadata?: Record<string, any>;
  warnings?: string[];
}

export interface TagValidationResult {
  valid: boolean;
  compliance: number;
  complianceLevel?: 'full' | 'high' | 'medium' | 'low';
  errors: string[];
  warnings: string[];
  suggestions?: string[];
}

// Export types
export type ExportFormat = 'skyspark' | 'zinc' | 'trio';

export interface ExportOptions {
  format: ExportFormat;
  includeMetadata?: boolean;
  includeWarnings?: boolean;
  sortTags?: boolean;
}

export interface BatchExportResult {
  format: ExportFormat;
  content: string;
  pointCount: number;
  exportedAt: string;
  warnings?: string[];
}

// Advanced tagging configuration
export interface TaggingConfiguration {
  enableSemanticInference: boolean;
  includeVendorTags: boolean;
  strictValidation: boolean;
  exportFormat: ExportFormat;
  confidenceThreshold: number;
  customMappings?: Record<string, string[]>;
  excludePatterns?: string[];
}

// Compliance reporting
export interface HaystackComplianceReport {
  totalPoints: number;
  validPoints: number;
  averageCompliance: number;
  complianceDistribution: {
    full: number;
    high: number;
    medium: number;
    low: number;
  };
  commonIssues: Array<{
    issue: string;
    count: number;
    percentage: number;
  }>;
  recommendations: string[];
  tagStatistics: {
    mostCommonTags: Array<{
      tag: string;
      count: number;
      percentage: number;
    }>;
    unusualTags: string[];
    deprecatedTags: string[];
  };
}

// Tag generation pipeline
export interface TagGenerationPipeline {
  steps: Array<{
    name: string;
    enabled: boolean;
    confidence: number;
    tags: string[];
  }>;
  totalConfidence: number;
  warnings: string[];
  reasoning: string[];
}

// Semantic analysis types
export type SemanticCategory = 
  | 'temperature'
  | 'pressure'
  | 'flow'
  | 'humidity'
  | 'co2'
  | 'power'
  | 'energy'
  | 'speed'
  | 'level'
  | 'alarm'
  | 'control';

export interface TagConfidence {
  tag: string;
  confidence: number;
  source: 'pattern' | 'unit' | 'objectType' | 'equipment' | 'semantic';
  reasoning: string;
}

export interface MarkerRelationship {
  primary: string;
  related: string[];
  conflicting: string[];
  required?: string[];
}

// Quality assessment
export interface TagQualityMetrics {
  completeness: number; // 0-100
  consistency: number; // 0-100
  compliance: number; // 0-100
  specificity: number; // 0-100
  overall: number; // 0-100
}

export interface QualityAssessment {
  pointId: string;
  metrics: TagQualityMetrics;
  issues: Array<{
    type: 'error' | 'warning' | 'suggestion';
    message: string;
    severity: 'high' | 'medium' | 'low';
  }>;
  recommendations: string[];
}

// Batch processing types
export interface BatchProcessingOptions {
  chunkSize?: number;
  parallelProcessing?: boolean;
  progressCallback?: (processed: number, total: number) => void;
  errorHandling?: 'strict' | 'lenient' | 'skip';
}

export interface BatchProcessingResult {
  processed: number;
  successful: number;
  failed: number;
  warnings: number;
  duration: number;
  results: HaystackTagSet[];
  errors: Array<{
    pointId: string;
    error: string;
  }>;
}

// Tag mapping and inference types
export interface TagMappingRule {
  pattern: RegExp | string;
  tags: string[];
  confidence: number;
  conditions?: {
    requires?: string[];
    excludes?: string[];
    objectTypes?: string[];
    units?: string[];
  };
}

export interface SemanticPattern {
  name: string;
  patterns: RegExp[];
  tags: string[];
  confidence: number;
  category: SemanticCategory;
  equipmentTypes?: string[];
}

// Historical and trending types
export interface TagUsageStatistics {
  tag: string;
  usageCount: number;
  usagePercentage: number;
  averageConfidence: number;
  equipmentTypes: string[];
  commonCombinations: string[][];
}

export interface TrendingAnalysis {
  period: string;
  newTags: string[];
  deprecatedTags: string[];
  popularTags: string[];
  complianceImprovement: number;
  qualityTrends: {
    completeness: number;
    consistency: number;
    compliance: number;
  };
}

// Integration types
export interface HaystackIntegrationConfig {
  serverUrl?: string;
  username?: string;
  password?: string;
  projectId?: string;
  timeout?: number;
  retryAttempts?: number;
  enableCaching?: boolean;
}

export interface SkySparkExportConfig {
  projectName: string;
  includeHistory?: boolean;
  includeTimeSeries?: boolean;
  customFields?: Record<string, any>;
}

// Validation and error types
export interface ValidationContext {
  strictMode: boolean;
  allowCustomTags: boolean;
  requireEquipmentContext: boolean;
  minimumConfidence: number;
}

export interface ValidationError {
  type: 'structure' | 'semantics' | 'compliance' | 'reference';
  message: string;
  suggestion?: string;
  severity: 'error' | 'warning' | 'info';
}

// Advanced analytics types
export interface TagAnalytics {
  distribution: Record<string, number>;
  correlations: Array<{
    tagA: string;
    tagB: string;
    correlation: number;
  }>;
  anomalies: Array<{
    pointId: string;
    tags: string[];
    reason: string;
    confidence: number;
  }>;
  patterns: Array<{
    pattern: string;
    frequency: number;
    examples: string[];
  }>;
}

// Legacy support types
export interface LegacyHaystackTag {
  name: string;
  value?: any;
  kind?: string;
  unit?: string;
  meta?: Record<string, any>;
}

export interface MigrationPlan {
  fromVersion: string;
  toVersion: string;
  steps: Array<{
    description: string;
    action: 'add' | 'remove' | 'replace' | 'rename';
    oldTag?: string;
    newTag?: string;
    reason: string;
  }>;
  estimatedEffort: 'low' | 'medium' | 'high';
  riskLevel: 'low' | 'medium' | 'high';
}

// Performance monitoring
export interface PerformanceMetrics {
  processingTime: number;
  memoryUsage: number;
  cacheHitRate?: number;
  throughput: number;
  errorRate: number;
}

export interface ProcessingStatistics {
  totalPoints: number;
  averageProcessingTime: number;
  peakMemoryUsage: number;
  cacheStatistics?: {
    hits: number;
    misses: number;
    hitRate: number;
  };
  errorStatistics: {
    totalErrors: number;
    errorsByType: Record<string, number>;
    errorRate: number;
  };
}

// Export all types for easy access
export type {
  HaystackMarker,
  HaystackTagSet,
  TagValidationResult,
  ExportFormat,
  ExportOptions,
  BatchExportResult,
  TaggingConfiguration,
  HaystackComplianceReport,
  TagGenerationPipeline,
  SemanticCategory,
  TagConfidence,
  MarkerRelationship,
  TagQualityMetrics,
  QualityAssessment,
  BatchProcessingOptions,
  BatchProcessingResult,
  TagMappingRule,
  SemanticPattern,
  TagUsageStatistics,
  TrendingAnalysis,
  HaystackIntegrationConfig,
  SkySparkExportConfig,
  ValidationContext,
  ValidationError,
  TagAnalytics,
  LegacyHaystackTag,
  MigrationPlan,
  PerformanceMetrics,
  ProcessingStatistics
};

// Default export with commonly used types
export default {
  HaystackTagSet,
  TagValidationResult,
  TaggingConfiguration,
  HaystackComplianceReport,
  ExportFormat,
  SemanticCategory
}; 