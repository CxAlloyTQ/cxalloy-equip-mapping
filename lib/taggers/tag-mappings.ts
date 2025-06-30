/**
 * Comprehensive Tag Mappings for Project Haystack v5
 * Maps BACnet concepts to standardized Haystack markers and tags
 */

/**
 * BACnet Object Type to Haystack Role Mappings
 */
export const OBJECT_TYPE_MAPPINGS: Record<string, { role: string; tags: string[]; confidence: number }> = {
  // Analog Objects
  'AI': { role: 'sensor', tags: ['sensor'], confidence: 0.9 },
  'AO': { role: 'cmd', tags: ['cmd'], confidence: 0.9 },
  'AV': { role: 'sp', tags: ['sp'], confidence: 0.8 },
  
  // Binary Objects
  'BI': { role: 'sensor', tags: ['sensor', 'binary'], confidence: 0.9 },
  'BO': { role: 'cmd', tags: ['cmd', 'binary'], confidence: 0.9 },
  'BV': { role: 'sp', tags: ['sp', 'binary'], confidence: 0.8 },
  
  // Multi-state Objects
  'MI': { role: 'sensor', tags: ['sensor', 'multi'], confidence: 0.8 },
  'MO': { role: 'cmd', tags: ['cmd', 'multi'], confidence: 0.8 },
  'MV': { role: 'sp', tags: ['sp', 'multi'], confidence: 0.7 },
  
  // Calendar and Schedule Objects
  'CAL': { role: 'schedule', tags: ['schedule'], confidence: 0.7 },
  'SCH': { role: 'schedule', tags: ['schedule'], confidence: 0.7 },
  
  // Notification and Event Objects
  'NC': { role: 'alarm', tags: ['alarm', 'notification'], confidence: 0.8 },
  'EE': { role: 'alarm', tags: ['alarm', 'event'], confidence: 0.8 }
};

/**
 * Unit to Physical Quantity Mappings
 */
export const UNIT_MAPPINGS: Record<string, { quantity: string; tags: string[]; confidence: number }> = {
  // Temperature Units
  '°F': { quantity: 'temperature', tags: ['temp'], confidence: 0.95 },
  '°C': { quantity: 'temperature', tags: ['temp'], confidence: 0.95 },
  'degF': { quantity: 'temperature', tags: ['temp'], confidence: 0.95 },
  'degC': { quantity: 'temperature', tags: ['temp'], confidence: 0.95 },
  'F': { quantity: 'temperature', tags: ['temp'], confidence: 0.9 },
  'C': { quantity: 'temperature', tags: ['temp'], confidence: 0.9 },
  
  // Pressure Units
  'PSI': { quantity: 'pressure', tags: ['pressure'], confidence: 0.95 },
  'Pa': { quantity: 'pressure', tags: ['pressure'], confidence: 0.95 },
  'kPa': { quantity: 'pressure', tags: ['pressure'], confidence: 0.95 },
  'inWC': { quantity: 'pressure', tags: ['pressure'], confidence: 0.95 },
  'inH2O': { quantity: 'pressure', tags: ['pressure'], confidence: 0.95 },
  'mmHg': { quantity: 'pressure', tags: ['pressure'], confidence: 0.9 },
  'bar': { quantity: 'pressure', tags: ['pressure'], confidence: 0.9 },
  
  // Flow Units
  'CFM': { quantity: 'flow', tags: ['flow', 'air'], confidence: 0.95 },
  'GPM': { quantity: 'flow', tags: ['flow', 'water'], confidence: 0.95 },
  'L/s': { quantity: 'flow', tags: ['flow'], confidence: 0.95 },
  'L/min': { quantity: 'flow', tags: ['flow'], confidence: 0.95 },
  'm³/h': { quantity: 'flow', tags: ['flow'], confidence: 0.95 },
  'ft³/min': { quantity: 'flow', tags: ['flow'], confidence: 0.9 },
  
  // Humidity Units
  '%RH': { quantity: 'humidity', tags: ['humidity'], confidence: 0.95 },
  'RH': { quantity: 'humidity', tags: ['humidity'], confidence: 0.9 },
  
  // Power Units
  'kW': { quantity: 'power', tags: ['power'], confidence: 0.95 },
  'W': { quantity: 'power', tags: ['power'], confidence: 0.95 },
  'HP': { quantity: 'power', tags: ['power'], confidence: 0.9 },
  'BTU/h': { quantity: 'power', tags: ['power'], confidence: 0.9 },
  
  // Energy Units
  'kWh': { quantity: 'energy', tags: ['energy'], confidence: 0.95 },
  'Wh': { quantity: 'energy', tags: ['energy'], confidence: 0.95 },
  'BTU': { quantity: 'energy', tags: ['energy'], confidence: 0.9 },
  'MJ': { quantity: 'energy', tags: ['energy'], confidence: 0.9 },
  
  // Speed Units
  'RPM': { quantity: 'speed', tags: ['speed'], confidence: 0.95 },
  'Hz': { quantity: 'freq', tags: ['freq'], confidence: 0.95 },
  
  // Percentage and Dimensionless
  '%': { quantity: 'level', tags: ['level'], confidence: 0.8 },
  'percent': { quantity: 'level', tags: ['level'], confidence: 0.8 },
  
  // CO2 Units
  'ppm': { quantity: 'co2', tags: ['co2'], confidence: 0.85 },
  'PPM': { quantity: 'co2', tags: ['co2'], confidence: 0.85 },
  
  // Voltage and Current
  'V': { quantity: 'voltage', tags: ['elec', 'volt'], confidence: 0.9 },
  'A': { quantity: 'current', tags: ['elec', 'current'], confidence: 0.9 },
  'mA': { quantity: 'current', tags: ['elec', 'current'], confidence: 0.9 }
};

/**
 * Equipment Type to Haystack Marker Mappings
 */
export const EQUIPMENT_TYPE_MAPPINGS: Record<string, { tags: string[]; confidence: number }> = {
  // Air Handling Equipment
  'AHU': { tags: ['ahu', 'equip'], confidence: 0.95 },
  'RTU': { tags: ['rtu', 'ahu', 'equip'], confidence: 0.95 },
  'VAV': { tags: ['vav', 'equip'], confidence: 0.95 },
  'CAV': { tags: ['cav', 'equip'], confidence: 0.9 },
  'MAU': { tags: ['mau', 'ahu', 'equip'], confidence: 0.9 },
  'ERV': { tags: ['erv', 'equip'], confidence: 0.9 },
  'HRV': { tags: ['hrv', 'equip'], confidence: 0.9 },
  
  // HVAC Equipment
  'Chiller': { tags: ['chiller', 'equip'], confidence: 0.95 },
  'Boiler': { tags: ['boiler', 'equip'], confidence: 0.95 },
  'CoolingTower': { tags: ['coolingTower', 'equip'], confidence: 0.95 },
  'HeatPump': { tags: ['heatPump', 'equip'], confidence: 0.95 },
  'Furnace': { tags: ['furnace', 'equip'], confidence: 0.9 },
  'UnitHeater': { tags: ['unitHeater', 'equip'], confidence: 0.9 },
  
  // Pumps and Fans
  'Pump': { tags: ['pump', 'equip'], confidence: 0.95 },
  'Fan': { tags: ['fan', 'equip'], confidence: 0.95 },
  'ExhaustFan': { tags: ['exhaustFan', 'fan', 'equip'], confidence: 0.9 },
  'SupplyFan': { tags: ['supplyFan', 'fan', 'equip'], confidence: 0.9 },
  'ReturnFan': { tags: ['returnFan', 'fan', 'equip'], confidence: 0.9 },
  
  // Terminal Equipment
  'FCU': { tags: ['fcu', 'equip'], confidence: 0.9 },
  'VRF': { tags: ['vrf', 'equip'], confidence: 0.9 },
  'Radiator': { tags: ['radiator', 'equip'], confidence: 0.85 },
  'Baseboard': { tags: ['baseboard', 'equip'], confidence: 0.85 },
  
  // Electrical Equipment
  'Panel': { tags: ['elecPanel', 'equip'], confidence: 0.9 },
  'Meter': { tags: ['elecMeter', 'equip'], confidence: 0.9 },
  'UPS': { tags: ['ups', 'equip'], confidence: 0.85 },
  'Generator': { tags: ['generator', 'equip'], confidence: 0.85 },
  
  // Lighting Equipment
  'LightingPanel': { tags: ['lightingPanel', 'equip'], confidence: 0.9 },
  'Dimmer': { tags: ['dimmer', 'equip'], confidence: 0.85 },
  
  // Security and Safety
  'FirePanel': { tags: ['firePanel', 'equip'], confidence: 0.9 },
  'SecurityPanel': { tags: ['securityPanel', 'equip'], confidence: 0.9 }
};

/**
 * Physical Quantity Pattern Mappings
 */
export const PHYSICAL_QUANTITY_MAPPINGS: Record<string, string[]> = {
  'temp': ['temperature', 'temp', 'thermal'],
  'pressure': ['pressure', 'press', 'static', 'differential'],
  'flow': ['flow', 'airflow', 'waterflow', 'cfm', 'gpm', 'volume'],
  'humidity': ['humidity', 'humid', 'moisture', 'rh'],
  'co2': ['co2', 'carbon dioxide', 'carbondioxide', 'ppm'],
  'power': ['power', 'electric', 'kw', 'watt', 'demand'],
  'energy': ['energy', 'kwh', 'consumption', 'usage'],
  'speed': ['speed', 'rpm', 'frequency', 'hz'],
  'level': ['level', 'position', 'percent', 'percentage', 'opening']
};

/**
 * Location Context Mappings
 */
export const LOCATION_MAPPINGS: Record<string, string[]> = {
  'zone': ['zone', 'room', 'space', 'area'],
  'discharge': ['discharge', 'supply', 'sup', 'leaving'],
  'return': ['return', 'ret', 'entering'],
  'outside': ['outside', 'outdoor', 'oa', 'oat', 'external'],
  'mixed': ['mixed', 'mix', 'ma', 'mat'],
  'exhaust': ['exhaust', 'exh', 'relief'],
  'entering': ['entering', 'inlet', 'upstream'],
  'leaving': ['leaving', 'outlet', 'downstream']
};

/**
 * Point Role Pattern Mappings
 */
export const POINT_ROLE_MAPPINGS: Record<string, string[]> = {
  'setpoint': ['sp', 'setpoint'],
  'command': ['cmd', 'writable'],
  'feedback': ['sensor', 'feedback'],
  'status': ['sensor', 'status'],
  'alarm': ['alarm', 'fault'],
  'enable': ['cmd', 'enable'],
  'override': ['cmd', 'override']
};

/**
 * Semantic Tag Combinations for Common Patterns
 */
export const SEMANTIC_COMBINATIONS: Record<string, string[]> = {
  // Temperature combinations
  'zone-temp-sensor': ['point', 'sensor', 'temp', 'zone'],
  'discharge-temp-sensor': ['point', 'sensor', 'temp', 'discharge'],
  'return-temp-sensor': ['point', 'sensor', 'temp', 'return'],
  'outside-temp-sensor': ['point', 'sensor', 'temp', 'outside'],
  'temp-setpoint': ['point', 'sp', 'temp'],
  
  // Fan combinations
  'fan-status': ['point', 'sensor', 'fan', 'run'],
  'fan-speed-cmd': ['point', 'cmd', 'fan', 'speed'],
  'fan-speed-feedback': ['point', 'sensor', 'fan', 'speed'],
  
  // Valve combinations
  'valve-cmd': ['point', 'cmd', 'valve'],
  'valve-feedback': ['point', 'sensor', 'valve'],
  'damper-cmd': ['point', 'cmd', 'damper'],
  'damper-feedback': ['point', 'sensor', 'damper'],
  
  // Pressure combinations
  'static-pressure': ['point', 'sensor', 'pressure', 'static'],
  'differential-pressure': ['point', 'sensor', 'pressure', 'differential'],
  
  // Flow combinations
  'airflow-sensor': ['point', 'sensor', 'flow', 'air'],
  'waterflow-sensor': ['point', 'sensor', 'flow', 'water']
};

/**
 * Tag Priority System for Consistent Ordering
 */
export const TAG_PRIORITIES: Record<string, number> = {
  // Core markers (highest priority)
  'point': 100,
  'sensor': 90,
  'cmd': 90,
  'sp': 90,
  
  // Physical quantities
  'temp': 80,
  'pressure': 80,
  'flow': 80,
  'humidity': 80,
  'co2': 80,
  'power': 80,
  'energy': 80,
  
  // Equipment markers
  'equip': 70,
  'ahu': 65,
  'vav': 65,
  'rtu': 65,
  'chiller': 65,
  'boiler': 65,
  'pump': 65,
  'fan': 65,
  
  // Location markers
  'zone': 60,
  'discharge': 60,
  'return': 60,
  'outside': 60,
  'mixed': 60,
  'exhaust': 60,
  
  // Modifiers
  'binary': 50,
  'multi': 50,
  'static': 50,
  'differential': 50,
  'air': 50,
  'water': 50,
  
  // System markers
  'hvac': 40,
  'elec': 40,
  'lighting': 40,
  'security': 40,
  'fire': 40,
  
  // Vendor and custom tags (lowest priority)
  'vendor': 10
};

/**
 * Sort tags by priority for consistent ordering
 */
export function sortTagsByPriority(tags: string[]): string[] {
  return tags.sort((a, b) => {
    const priorityA = TAG_PRIORITIES[a] || TAG_PRIORITIES[a.split(':')[0]] || 0;
    const priorityB = TAG_PRIORITIES[b] || TAG_PRIORITIES[b.split(':')[0]] || 0;
    
    if (priorityA !== priorityB) {
      return priorityB - priorityA; // Higher priority first
    }
    
    // If same priority, sort alphabetically
    return a.localeCompare(b);
  });
}

// Legacy mappings for backward compatibility
export const TAG_MAPPINGS = {
  OBJECT_TYPE_MAPPINGS,
  UNIT_MAPPINGS,
  EQUIPMENT_TYPE_MAPPINGS,
  PHYSICAL_QUANTITY_MAPPINGS,
  LOCATION_MAPPINGS,
  POINT_ROLE_MAPPINGS
};

// Export all mappings for easy access
export default {
  OBJECT_TYPE_MAPPINGS,
  UNIT_MAPPINGS,
  EQUIPMENT_TYPE_MAPPINGS,
  PHYSICAL_QUANTITY_MAPPINGS,
  LOCATION_MAPPINGS,
  POINT_ROLE_MAPPINGS,
  SEMANTIC_COMBINATIONS,
  TAG_PRIORITIES,
  sortTagsByPriority
}; 