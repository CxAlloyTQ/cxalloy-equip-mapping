Absolutely! Here’s a clear, organized summary of your project requirements for the Building Automation Equipment Mapping UI. This version is structured for clarity and can be used as the basis for a formal requirements document.

Project Summary: Building Automation Equipment Mapping UI
Overview

Develop a Next.js + TypeScript web application for intelligent mapping and classification of BACnet equipment and points using raw “trio” files and connector data. The system will automate equipment type detection, normalize point names and descriptions, and enable efficient mapping to CxAlloy project equipment.

Core Features

1. Equipment & Point Ingestion

Parse uploaded BACnet “trio” files and connector data.
Automatically classify equipment type and name using filename conventions.
Extract and display all points associated with each piece of equipment.

2. Point Normalization & Tagging

Normalize point names and generate fully expanded, human-readable descriptions (no acronyms/abbreviations).
Use a dictionary of BACnet acronyms, point types (e.g., AI, AO, BI, BO), data types, and units to inform normalization.
Generate standardized Project Haystack v5 tags for each point.

3. UI Layout

Left Panel (Navigation/Configuration):
List all detected equipment, grouped by equipment type.
Toggle between equipment view and point configuration templates (“signatures”) for each equipment type.
Allow users to manage and select point configuration templates for each equipment type.
Middle Panel (Equipment Details):
Show selected equipment’s details (description, model, vendor, etc.).
Display a scrollable, single-line list of all points for the equipment, showing:
Original point name
Normalized point name
Fully expanded description
Data type, unit, and other relevant details
Allow users to apply a point configuration template to the equipment and switch between “all points” and “template points” via a dropdown.
Right Panel (CxAlloy Mapping):
Show a list of CxAlloy project equipment (mock data for now).
Indicate which CxAlloy equipment is mapped/unmapped.
Allow users to map selected BACnet equipment (from the middle panel) to CxAlloy equipment via a “Map” button.
Filter CxAlloy equipment by mapped/unmapped status.
Key Processing Requirements
Filename-based Equipment Classification:
Use trio file names to infer equipment type and name.
Point Name & Description Normalization:
Expand cryptic BACnet point names using a custom dictionary, point type, data type, and units.
Template/Signature Management:
Allow creation and application of point configuration templates per equipment type.
Mapping Logic:
Enable mapping between BACnet equipment and CxAlloy equipment, updating mapping status in the UI.
Additional Notes
The system should be extensible to support new equipment types, point templates, and mapping workflows.
All normalization and mapping logic should be robust to handle variations in BACnet naming and data conventions.
UI should be clean, responsive, and optimized for engineering workflows.
Next Steps
Define the BACnet acronym/abbreviation dictionary and normalization rules.
Specify the Project Haystack v5 tagging logic.
Design initial UI wireframes for the three-panel layout.
Outline data models for equipment, points, templates, and mappings.

