# chondria

#title: "Detection of a nuisance alga with environmental DNA"
#authors: "Nichols P.K., Fraiola K.M.S., Sherwood A.S., Marko P.B."
#year: 2023

## 1. SAMPLE METADATA
#Metadata file must contain:
#* SampleID (biological replicate ID, must match platedata)
#* Location (site location identifier)
#* Depth_m (depth in meters of site)

## 2. qPCR PLATE DATA
#Platedata file must contain the following columns:
#* ID (unique to each qPCR reaction, must match Cq data)
#* PlateID (corresponding to well location on sample plate)
#* SampleID (biological replicate ID, must match metadata)
#* Project ("Motivating" dataset from this study, "Classification" for any additional data to be classified by the RF model)
#* Threshold (calculated quantification threshold per sample plate)
#* E (calculated efficiency per plate)

## 3. qPCR Cq-VALUES
#Cq data file must contain:
  
#* ID (unique to each qPCR reaction, must match platedata)
#* Cq-value (calculated per qPCR reaction, left blank if no amplification)

Set working directory to location of above three files, plus the included trained RF Classification Model (1rfmodel_2023.rda).
Run the R script using new eDNA qPCR data. The trained model will classify sites using efficiency-corrected DNA starting quantities and site depths. 
Predictions are saved to a new CSV file (2sitepredictions.csv). The percentage of positive predictions per site are plotted.

Please note: The predictions are based on assumptions that eDNA sampling and processing were conducted following the protocol outlined in Nichols et al. (2023).
Verify any detections with amplification and melt curve analyses. Check for contamination in control samples.
