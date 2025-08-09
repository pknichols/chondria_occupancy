# Site-occupancy detection modeling of nuisance algae from eDNA qPCR detections
### Nichols P.K.
### 2025

This R Markdown file imports and processes qPCR data generated on a Bio Molecular Systems MIC for single species site-occupancy detection modeling as similarly performed for tracking the nuisance alga, Chondria tumulosa (Nichols et al. 2025). The following files are required:

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
* ID (USER-ADDED COLUMN: continuous and unique identifier for each qPCR reaction, must not overlap; character)

Open eDNA_occupancy.RMD in R Studio with working directory set to the location of the above files to run the example data. Output results of site-occupancy detection modeling for single-species qPCR eDNA assay (Griffin et al. 2020; Diana et al. 2021). 

NOTE: To improve model inference, user data should include all qPCR amplifications generated with identical sample protocol.

**References:**
* Diana, A., Matechou, E., Griffin, J. E., Buxton, A. S., & Griffiths, R. A. (2021). An RShiny app for modelling environmental DNA data: Accounting for false positive and false negative observation error. Ecography, 44(12), 1838–1844. https://doi.org/10.1111/ecog.05718

* Griffin, J. E., Matechou, E., Buxton, A. S., Bormpoudakis, D., & Griffiths, R. A. (2020). Modelling Environmental DNA Data; Bayesian Variable Selection Accounting for False Positive and False Negative Errors. Journal of the Royal Statistical Society Series C: Applied Statistics, 69(2), 377–392. https://doi.org/10.1111/rssc.12390

* Nichols, P. K., Fraiola, K. M. S., Sherwood, A. R., Hauk, B. B., Jr, K. H. L., Davis, C. A., Fumo, J. T., Counsell, C. W. W., Williams, T. M., Spalding, H. L., & Marko, P. B. (2025). Navigating uncertainty in environmental DNA detection of a nuisance marine macroalga. PLOS ONE, 20(2), e0318414. https://doi.org/10.1371/journal.pone.0318414

