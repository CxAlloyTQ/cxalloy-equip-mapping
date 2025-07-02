import { Equipment, EquipmentStatus, ConnectionState } from '../../types/equipment';
import { nanoid } from 'nanoid';
import path from 'path';

/**
 * A dictionary mapping common equipment name substrings to standardized equipment types.
 * Based on Project Haystack v5 and common industry conventions.
 * Keys are sorted by length descending to prioritize more specific matches (e.g., 'WSHP' before 'HP').
 */
const EQUIPMENT_TYPE_DICTIONARY: { [key: string]: string } = {
  'CRAC': 'Computer Room Air Conditioner',
  'CRAH': 'Computer Room Air Handler',
  'DOAS': 'Dedicated Outdoor Air System',
  'DOU': 'Dedicated Outdoor Air Unit',
  'WSHP': 'Water Source Heat Pump',
  'ERV': 'Energy Recovery Ventilator',
  'HRV': 'Heat Recovery Ventilator',
  'CUH': 'Cabinet Unit Heater',
  'AHU': 'Air Handling Unit',
  'RTU': 'Rooftop Unit',
  'VAV': 'VAV Terminal',
  'FCU': 'Fan Coil Unit',
  'VVR': 'VAV Controller',
  'VV-': 'VAV Controller',
  'CH': 'Chiller',
  'BLR': 'Boiler',
  'PMP': 'Pump',
  'FAN': 'Fan',
  'EF': 'Exhaust Fan',
  'CTF': 'Cooling Tower Fan',
  'CT': 'Cooling Tower',
  'UH': 'Unit Heater',
  'LAB': 'Lab Air Valve',
  'L-': 'Lab Air Valve',
  'VFD': 'Variable Frequency Drive',
  'HX': 'Heat Exchanger',
  'ECB': 'Controller',
  'TCP': 'TCP Controller',
};

// Memoization cache for equipment type lookups
const typeCache = new Map<string, { typeName: string; matchedKey: string }>();

/**
 * Intelligently determines the equipment type from its name based on the dictionary.
 * @param name - The name of the equipment (e.g., from a filename).
 * @returns An object containing the standardized `typeName` and the `matchedKey` from the dictionary.
 */
export function getEquipmentTypeFromName(name: string): { typeName: string; matchedKey: string } {
  if (typeCache.has(name)) {
    return typeCache.get(name)!;
  }

  const upperName = name.toUpperCase();
  const sortedKeys = Object.keys(EQUIPMENT_TYPE_DICTIONARY).sort((a, b) => b.length - a.length);

  for (const key of sortedKeys) {
    if (upperName.includes(key.toUpperCase())) {
      const result = { typeName: EQUIPMENT_TYPE_DICTIONARY[key], matchedKey: key };
      typeCache.set(name, result);
      return result;
    }
  }

  const result = { typeName: 'Unknown', matchedKey: '' };
  typeCache.set(name, result);
  return result;
}

/**
 * Classifies a piece of equipment based on its filename and associated TRIO data.
 * It uses the dictionary-based approach to determine the equipment type.
 * @param filename - The original filename of the trio data.
 * @param trioData - The parsed content of the trio file (currently unused but available for future enhancement).
 * @returns An `Equipment` object with classified information.
 */
export function classifyEquipment(filename: string, trioData: any): Equipment {
  const name = path.basename(filename, '.trio');
  const { typeName } = getEquipmentTypeFromName(name);

  // Generate a descriptive name. If type is known, prepend it.
  const displayName = typeName !== 'Unknown' ? `${typeName} - ${name}` : name;

  const equipment: Equipment = {
    id: nanoid(),
    name: name,
    displayName: displayName,
    type: typeName,
    filename: filename,
    status: EquipmentStatus.UNKNOWN,
    connectionState: ConnectionState.UNKNOWN,
    connectionStatus: 'unknown',
    vendor: 'Unknown',
    modelName: 'Unknown',
    location: null,
    description: null,
    points: [],
    createdAt: new Date(),
    updatedAt: new Date(),
  };

  return equipment;
}
