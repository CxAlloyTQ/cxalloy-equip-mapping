// app/api/auto-process-enhanced/route.ts

import { NextRequest, NextResponse } from 'next/server';
import { fileScannerService } from '../../../lib/services/file-scanner-service';
import { parseTrioFile } from '../../../lib/parsers/trio-parser';
import { classifyEquipment } from '../../../lib/classifiers/equipment-classifier';
import { normalizePointName, PointNormalizer } from '../../../lib/normalizers/point-normalizer';
import { generateHaystackTags } from '../../../lib/taggers/haystack-tagger';
import { EquipmentDatabaseService } from '../../../lib/database/equipment-db-service';
import { BACnetObjectType, PointDataType, PointCategory } from '../../../types/point';
import { Equipment } from '../../../types/equipment';
import { NormalizedPoint } from '../../../types/normalized';
import { nanoid } from 'nanoid';
import { parse } from 'csv-parse/sync';
import path from 'path';

// Initialize database service
const databaseService = new EquipmentDatabaseService();

// Helper function to normalize multiple points
function normalizePoints(
  records: any[], 
  equipment: Equipment, 
  options: { addFunctionSuffix?: boolean; useEnhancedConfidence?: boolean } = {}
): NormalizedPoint[] {
  return records.map((record, index) => {
    const pointName = record.dis || record.objectName || `Point_${index}`;
    const description = record.bacnetDesc || record.description || '';
    
    // Determine BACnet object type
    let objectType = BACnetObjectType.ANALOG_INPUT;
    if (record.cmd || record.writable) {
      objectType = record.kind === 'Bool' ? BACnetObjectType.BINARY_OUTPUT : BACnetObjectType.ANALOG_OUTPUT;
    } else if (record.kind === 'Bool') {
      objectType = BACnetObjectType.BINARY_INPUT;
    }

    // Create BACnet point structure
    const bacnetPoint = {
      objectName: pointName,
      dis: pointName,
      id: `${equipment.id}_${index}`,
      equipmentId: equipment.id,
      objectType,
      objectInstance: index + 1,
      displayName: pointName,
      dataType: record.kind === 'Bool' ? PointDataType.BOOLEAN : PointDataType.NUMBER,
      category: record.cmd ? PointCategory.COMMAND : PointCategory.SENSOR,
      description,
      units: record.unit || '',
      isWritable: !!record.writable || !!record.cmd,
      isCommand: !!record.cmd,
      createdAt: new Date(),
      updatedAt: new Date()
    };

    // Normalize using the point normalizer
    const normalizationResult = PointNormalizer.normalizePointName(bacnetPoint, {
      equipmentType: equipment.type,
      equipmentName: equipment.name,
      vendorName: equipment.vendor,
      units: record.unit,
      addFunctionSuffix: options.addFunctionSuffix,
      useEnhancedConfidence: options.useEnhancedConfidence
    });

    if (normalizationResult.success && normalizationResult.normalizedPoint) {
      return normalizationResult.normalizedPoint;
    }

    // Fallback if normalization fails
    return {
      originalPointId: pointName,
      equipmentId: equipment.id,
      originalName: pointName,
      originalDescription: description,
      objectName: pointName,
      objectType,
      normalizedName: pointName,
      expandedDescription: description || pointName,
      pointFunction: record.cmd ? 'Command' : 'Sensor',
      category: bacnetPoint.category,
      dataType: bacnetPoint.dataType,
      units: record.unit || '',
      haystackTags: [],
      confidence: 'Low',
      confidenceScore: 0.3,
      normalizationMethod: 'fallback',
      normalizationRules: [],
      hasAcronymExpansion: false,
      hasUnitNormalization: !!record.unit,
      hasContextInference: false,
      requiresManualReview: true,
      createdAt: new Date(),
      updatedAt: new Date()
    } as NormalizedPoint;
  });
}

// Helper function to parse connector data from CSV
async function parseConnectorData(content: string): Promise<any[]> {
  try {
    const records = parse(content, {
      columns: true,
      skip_empty_lines: true,
      trim: true
    });
    
    console.log(`[CSV Parser] Parsed ${records.length} records from ConnectorData`);
    return records;
  } catch (error) {
    console.error('[CSV Parser] Error parsing ConnectorData:', error);
    throw error;
  }
}

// Helper function to parse bacnet connections from CSV
async function parseBacnetConnections(content: string): Promise<any[]> {
  try {
    const records = parse(content, {
      columns: true,
      skip_empty_lines: true,
      trim: true
    });
    
    console.log(`[CSV Parser] Parsed ${records.length} records from BACnet Connections`);
    return records;
  } catch (error) {
    console.error('[CSV Parser] Error parsing BACnet Connections:', error);
    throw error;
  }
}

// Helper function to parse TRIO file content
async function parseTrioFileFromContent(content: string, filename: string): Promise<any> {
  const lines = content.split('\n');
  const records: any[] = [];
  let currentRecord: any = {};
  let inRecord = false;

  for (const line of lines) {
    const trimmedLine = line.trim();
    
    if (trimmedLine === '---') {
      // Record separator - save current record and start new one
      if (Object.keys(currentRecord).length > 0) {
        records.push(currentRecord);
        currentRecord = {};
      }
      inRecord = false;
    } else if (trimmedLine === '' && inRecord) {
      // Empty line - might end a record (but don't reset yet)
      continue;
    } else if (trimmedLine.includes(':') && !trimmedLine.startsWith('//') && !trimmedLine.startsWith('#')) {
      // Tag within record
      inRecord = true;
      const colonIndex = trimmedLine.indexOf(':');
      const key = trimmedLine.substring(0, colonIndex).trim();
      const value = trimmedLine.substring(colonIndex + 1).trim();
      
      // Remove quotes from values
      const cleanValue = value.replace(/^\"(.*)\"$/, '$1');
      currentRecord[key] = cleanValue;
    }
  }

  // Add final record if exists
  if (Object.keys(currentRecord).length > 0) {
    records.push(currentRecord);
  }

  console.log(`[TRIO Parser] Parsed ${records.length} records from ${filename}`);

  return {
    records,
    sections: { equipment: records },
    metadata: {
      filename,
      recordCount: records.length,
      source: 'sample_data'
    }
  };
}

// Helper function to create equipment from connector data
function createEquipmentFromConnectorData(connectorData: any): Equipment {
  const id = nanoid();
  const name = connectorData.dis || connectorData.bacnetDeviceName || 'Unknown Device';
  const vendor = connectorData.vendorName || 'Unknown Vendor';
  const model = connectorData.modelName || 'Unknown Model';
  
  const equipment: Equipment = {
    id,
    name,
    displayName: name,
    type: 'Unknown', // Will be determined by classifier
    filename: name + '.trio',
    status: connectorData.bacnetDeviceStatus === 'OPERATIONAL' ? 'ACTIVE' : 'INACTIVE',
    connectionState: connectorData.connState === 'open' ? 'CONNECTED' : 'CLOSED',
    connectionStatus: connectorData.connStatus || 'unknown',
    vendor,
    modelName: model,
    points: [],
    createdAt: new Date(),
    updatedAt: new Date(),
  };
  
  // Try to classify equipment based on name
  const classificationResult = classifyEquipment(name, {});
  
  if (classificationResult && classificationResult.type) {
    equipment.type = classificationResult.type;
    equipment.displayName = classificationResult.displayName || name;
  }
  
  return equipment;
}

interface ProcessingResult {
  success: boolean;
  scannedFiles: any;
  csvEnhancement: {
    enabled: boolean;
    equipmentCount: number;
    vendorRulesCount: number;
  };
  processedFiles: Array<{
    fileName: string;
    success: boolean;
    equipment?: any;
    pointCount?: number;
    error?: string;
    processingTime?: number;
    enhanced?: boolean;
  }>;
  summary: {
    totalFiles: number;
    successfulFiles: number;
    failedFiles: number;
    totalEquipment: number;
    totalPoints: number;
    enhancedFiles: number;
    averageConfidence: number;
  };
  sessionId: string;
}

// Process files in order - first CSV, then TRIO
async function processFilesInOrder(scanResult: any, sessionId: string): Promise<ProcessingResult> {
  const processedFiles: ProcessingResult['processedFiles'] = [];
  let totalPoints = 0;
  let totalEquipment = 0;
  let enhancedFiles = 0;
  let confidenceSum = 0;
  let confidenceCount = 0;
  let csvEnhancementEnabled = false;
  let connectorDataRecords: any[] = [];
  let bacnetConnectionsRecords: any[] = [];
  
  // Step 1: Clear all existing data
  console.log(`[Auto Process] Clearing existing data before processing`);
  await databaseService.clearAllData();
  
  // Step 2: Process CSV files first
  console.log(`[Auto Process] Processing CSV files first`);
  
  // Process ConnectorData.csv
  if (scanResult.csvFiles.connectorData) {
    const startTime = Date.now();
    
    try {
      console.log(`[Auto Process] Processing ${scanResult.csvFiles.connectorData.name}...`);
      
      // Read file content
      const fileContent = await fileScannerService.readSampleFile(scanResult.csvFiles.connectorData.name);
      
      // Parse CSV file
      connectorDataRecords = await parseConnectorData(fileContent);
      
      // Store equipment from connector data
      for (const record of connectorDataRecords) {
        const equipment = createEquipmentFromConnectorData(record);
        await databaseService.storeEquipmentWithPoints(
          scanResult.csvFiles.connectorData.id,
          equipment,
          [],
          sessionId
        );
        
        totalEquipment++;
      }
      
      const processingTime = Date.now() - startTime;
      
      processedFiles.push({
        fileName: scanResult.csvFiles.connectorData.name,
        success: true,
        pointCount: 0,
        processingTime,
        enhanced: false
      });
      
      csvEnhancementEnabled = true;
      
      console.log(`[Auto Process] Successfully processed ${scanResult.csvFiles.connectorData.name}: ${connectorDataRecords.length} records`);
      
    } catch (error) {
      const processingTime = Date.now() - startTime;
      console.error(`[Auto Process] Failed to process ${scanResult.csvFiles.connectorData.name}:`, error);
      
      processedFiles.push({
        fileName: scanResult.csvFiles.connectorData.name,
        success: false,
        error: error instanceof Error ? error.message : 'Unknown error',
        processingTime
      });
    }
  }
  
  // Process bacnet_connections.csv
  if (scanResult.csvFiles.bacnetConnections) {
    const startTime = Date.now();
    
    try {
      console.log(`[Auto Process] Processing ${scanResult.csvFiles.bacnetConnections.name}...`);
      
      // Read file content
      const fileContent = await fileScannerService.readSampleFile(scanResult.csvFiles.bacnetConnections.name);
      
      // Parse CSV file
      bacnetConnectionsRecords = await parseBacnetConnections(fileContent);
      
      const processingTime = Date.now() - startTime;
      
      processedFiles.push({
        fileName: scanResult.csvFiles.bacnetConnections.name,
        success: true,
        pointCount: 0,
        processingTime,
        enhanced: false
      });
      
      if (!csvEnhancementEnabled) {
        csvEnhancementEnabled = true;
      }
      
      console.log(`[Auto Process] Successfully processed ${scanResult.csvFiles.bacnetConnections.name}: ${bacnetConnectionsRecords.length} records`);
      
    } catch (error) {
      const processingTime = Date.now() - startTime;
      console.error(`[Auto Process] Failed to process ${scanResult.csvFiles.bacnetConnections.name}:`, error);
      
      processedFiles.push({
        fileName: scanResult.csvFiles.bacnetConnections.name,
        success: false,
        error: error instanceof Error ? error.message : 'Unknown error',
        processingTime
      });
    }
  }
  
  // Step 3: Process TRIO files
  console.log(`[Auto Process] Processing ${scanResult.trioFiles.length} TRIO files...`);
  
  for (const trioFile of scanResult.trioFiles) {
    const startTime = Date.now();
    
    try {
      console.log(`[Auto Process] Processing ${trioFile.name}...`);
      
      // Read file content
      const fileContent = await fileScannerService.readSampleFile(trioFile.name);
      
      // Parse TRIO file
      const trioData = await parseTrioFileFromContent(fileContent, trioFile.name);
      
      // Classify equipment
      let equipment = classifyEquipment(trioFile.name, trioData);
      
      // Enhance with connector data if available
      if (csvEnhancementEnabled) {
        const baseName = path.basename(trioFile.name, '.trio');
        const connectorMatch = connectorDataRecords.find(r => 
          r.dis === baseName || 
          r.bacnetDeviceName === baseName || 
          r.name === baseName
        );
        
        if (connectorMatch) {
          equipment.vendor = connectorMatch.vendorName || equipment.vendor;
          equipment.modelName = connectorMatch.modelName || equipment.modelName;
          equipment.status = connectorMatch.bacnetDeviceStatus === 'OPERATIONAL' ? 'ACTIVE' : equipment.status;
          equipment.connectionState = connectorMatch.connState === 'open' ? 'CONNECTED' : equipment.connectionState;
          equipment.connectionStatus = connectorMatch.connStatus || equipment.connectionStatus;
          
          enhancedFiles++;
        }
      }
      
      console.log(`[Auto Process] Classified ${equipment.name} as ${equipment.type}`);

      // Normalize points
      const normalizedPoints = normalizePoints(trioData.records || [], equipment, {
        addFunctionSuffix: true,
        useEnhancedConfidence: true
      });

      // Generate Haystack tags
      const taggedPoints = normalizedPoints.map(point => ({
        ...point,
        haystackTags: generateHaystackTags(point, equipment)
      }));

      // Store in database
      try {
        const storeResult = await databaseService.storeEquipmentWithPoints(
          trioFile.id,
          equipment,
          taggedPoints,
          sessionId
        );
        console.log(`[Auto Process] Stored ${trioFile.name} in database:`, storeResult);
      } catch (dbError) {
        console.error(`[Auto Process] Database storage failed for ${trioFile.name}:`, dbError);
      }

      const processingTime = Date.now() - startTime;
      const avgConfidence = taggedPoints.length > 0
        ? taggedPoints.reduce((sum, p) => sum + (typeof p.confidenceScore === 'number' ? p.confidenceScore : 0), 0) / taggedPoints.length
        : 0;
      
      processedFiles.push({
        fileName: trioFile.name,
        success: true,
        equipment,
        pointCount: taggedPoints.length,
        processingTime,
        enhanced: csvEnhancementEnabled
      });

      totalEquipment++;
      totalPoints += taggedPoints.length;
      confidenceSum += avgConfidence;
      confidenceCount++;

      console.log(`[Auto Process] Successfully processed ${trioFile.name}: ${taggedPoints.length} points, ${avgConfidence.toFixed(1)}% avg confidence`);

    } catch (error) {
      const processingTime = Date.now() - startTime;
      console.error(`[Auto Process] Failed to process ${trioFile.name}:`, error);
      
      processedFiles.push({
        fileName: trioFile.name,
        success: false,
        error: error instanceof Error ? error.message : 'Unknown error',
        processingTime
      });
    }
  }
  
  // Calculate summary
  const summary = {
    totalFiles: scanResult.trioFiles.length + (scanResult.csvFiles.connectorData ? 1 : 0) + (scanResult.csvFiles.bacnetConnections ? 1 : 0),
    successfulFiles: processedFiles.filter(f => f.success).length,
    failedFiles: processedFiles.filter(f => !f.success).length,
    totalEquipment,
    totalPoints,
    enhancedFiles,
    averageConfidence: confidenceCount > 0 ? confidenceSum / confidenceCount : 0
  };
  
  // Generate CSV enhancement info
  const csvEnhancement = {
    enabled: csvEnhancementEnabled,
    equipmentCount: connectorDataRecords.length,
    vendorRulesCount: bacnetConnectionsRecords.length
  };
  
  return {
    success: true,
    scannedFiles: scanResult,
    csvEnhancement,
    processedFiles,
    summary,
    sessionId
  };
}

export async function POST(request: NextRequest) {
  const sessionId = nanoid();
  console.log(`[Auto Process Enhanced] Starting auto-processing session: ${sessionId}`);

  try {
    // Step 1: Scan sample data directory
    console.log('[Auto Process Enhanced] Scanning sample data directory...');
    const scanResult = await fileScannerService.scanSampleData();
    
    if (scanResult.totalFiles === 0) {
      return NextResponse.json({
        success: false,
        error: 'No files found in public/sample_data directory',
        suggestion: 'Please add TRIO files and CSV files to the public/sample_data directory',
        sampleDataPath: fileScannerService.getSampleDataPath()
      }, { status: 404 });
    }

    console.log(`[Auto Process Enhanced] Found ${scanResult.totalFiles} files: ${scanResult.trioFiles.length} TRIO, ${Object.keys(scanResult.csvFiles).length} CSV`);
    
    // Step 2: Process files in order - CSV first, then TRIO
    const result = await processFilesInOrder(scanResult, sessionId);
    
    console.log(`[Auto Process Enhanced] Completed session ${sessionId}:`, result.summary);
    
    return NextResponse.json(result);
  } catch (error) {
    console.error('[Auto Process Enhanced] Processing failed:', error);
    return NextResponse.json({
      success: false,
      error: 'Auto-processing failed',
      details: error instanceof Error ? error.message : 'Unknown error',
      sessionId
    }, { status: 500 });
  }
}

// GET endpoint to check what files are available
export async function GET(request: NextRequest) {
  try {
    const scanResult = await fileScannerService.scanSampleData();
    
    return NextResponse.json({
      sampleDataPath: fileScannerService.getSampleDataPath(),
      scan: scanResult,
      csvEnhancementAvailable: !!(scanResult.csvFiles.bacnetConnections || scanResult.csvFiles.connectorData),
      readyToProcess: scanResult.trioFiles.length > 0
    });

  } catch (error) {
    console.error('[Auto Process Enhanced] Scan failed:', error);
    return NextResponse.json({
      success: false,
      error: 'Failed to scan sample data directory',
      details: error instanceof Error ? error.message : 'Unknown error'
    }, { status: 500 });
  }
}
