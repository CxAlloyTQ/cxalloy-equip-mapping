Building Automation Equipment Mapping UI - Project Requirements
Project Overview

A Next.js TypeScript application for intelligent mapping and classification of BACnet equipment and points from trio files, with automated equipment type detection and Project Haystack standardization.

Core Functionality
1. Data Processing & Classification
Equipment Detection: Extract equipment type and name from trio filename patterns (e.g., "L-5" → Lab Air Valve, "VVR_2.1" → VAV Controller)
Point Normalization: Transform cryptic BACnet point names into human-readable descriptions using:
BACnet acronym/abbreviation dictionary
Point type analysis (AI, AO, AV, BI, BO, BV, MSV)
Data type consideration (Number, Bool, String)
Unit-based inference (°F, cfm, %RH, etc.)
Haystack Tagging: Generate Project Haystack 5 standardized tags for each point
Connector Integration: Cross-reference trio files with connector data for complete equipment profiles
2. User Interface Layout
Left Panel - Equipment Browser
Equipment List: Display equipment grouped by type (VAV Controllers, Lab Air Valves, RTU Controllers, etc.)
Toggle Mode: Switch between:
Equipment view (browse actual equipment)
Template view (manage point configuration templates)
Template Management: Create/edit equipment-specific point templates (e.g., "VAV No Reheat", "VAV with Reheat")
Middle Panel - Equipment Details
Equipment Information: Display equipment metadata (description, model, vendor, status)
Point List: Scrollable table showing:
Original trio point name
Normalized point name
Human-readable description
Data type, units, and other attributes
Template Selector: Dropdown to apply point configuration templates
Single-row Display: Compact point rows with all relevant data visible
Right Panel - CxAlloy Integration
Project Equipment: List equipment from CxAlloy project (mock data initially)
Mapping Status: Filter between mapped/unmapped equipment
Map Button: One-click mapping between BACnet and CxAlloy equipment
Status Updates: Real-time mapping status and database updates
3. Technical Requirements
Data Processing
Filename-based equipment classification
BACnet acronym dictionary for point name expansion
Multi-factor point analysis (type + data type + units)
Project Haystack tag generation
Template-based point configuration
User Experience
Responsive Next.js TypeScript application
Real-time equipment filtering and search
Drag-and-drop or click-to-map functionality
Template-based workflow optimization
Database integration for persistent mapping
Integration Points
Trio file parsing and processing
Connector data correlation
CxAlloy project API (mock initially)
Database operations for mapping persistence
Key Features
Intelligent Point Recognition: Automated conversion of cryptic BACnet names to readable descriptions
Template System: Reusable point configurations for equipment types
Dual-mode Interface: Equipment browsing vs. template management
Visual Mapping: Clear indication of mapping status and relationships
Standardization: Project Haystack compliance for industry interoperability

This application streamlines the complex process of building automation data mapping by combining automated intelligence with user-friendly templates and visual mapping tools.