# chondria

# Site-occupancy detection modeling of nuisance algae from eDNA qPCR detections
### Nichols P.K.
### 2025

This R Markdown file imports and processes qPCR data generated on a Bio Molecular Systems MIC for single species site-occupancy detection modeling. The following files are required:

## 1. SAMPLE METADATA
Metadata file with sample and site information. Example file: "1qPCR_metadata.csv"

Metadata file must contain:
* Sample (sample identifier, must match Cq data; character)
* Biological_replicate (codes which biological replicate sample belongs to; numerical)
* Site (site location identifier; character)
* Sample_type (must be either "Control" or any other character values, such as "Sample" for biological samples)
* Lat (site latitude; numeric)
* Lon (site longitude; numeric)
* Depth_m (site depth in meters; numeric)
* Visual_presence (1 if visually observed, 0 or left blank otherwise)
* Any additional columns of model predictors or metadata (as applicable)

## 2. qPCR Cq-VALUES
Combined file with all Cq-values generated from molecular qPCR detections. Example file: "1Cq_data.csv"

Cq data file must contain:
  
* Well (corresponds to well location in BMS MIC run; numerical 1-48)
* Sample (biological replicate ID, must match metadata file; character)
* Cq (calculated per qPCR reaction, "-1" default if no amplification; numeric)
* Efficiency (efficiency as calculated by BMS MIC; numeric)
* ID (USER-ADDED COLUMN: continuous and unique identifier for each qPCR reaction, must match platedata; character)

Open eDNA_occupancy.RMD in R Studio with working directory set to the location of the above files to run the example data.
