#title: "Detection of a nuisance alga with environmental DNA"
#authors: "Nichols P.K., Fraiola K.M.S., Sherwood A.S., Marko P.B."
#year: 2023

library(ggplot2)
library(randomForest)
library(plyr)
library(dplyr)

## 1. SAMPLE METADATA
#Metadata file must contain:
#* SampleID (biological replicate ID, must match platedata)
#* Location (site location identifier)
#* Depth_m (depth in meters of site)

meta=read.csv("1metadata_example.csv", header = T)

## 2. qPCR PLATE DATA
#Platedata file must contain the following columns:
#* ID (unique to each qPCR reaction, must match Cq data)
#* PlateID (corresponding to well location on sample plate)
#* SampleID (biological replicate ID, must match metadata)
#* Project ("Motivating" dataset from this study, "Classification" for any additional data to be classified by the RF model)
#* Threshold (calculated quantification threshold per sample plate)
#* E (calculated efficiency per plate)

plate.all=read.csv("1platedata_example.csv", header=T)
plate.all$SampleID=as.factor(as.character(plate.all$SampleID))

metadata.all=merge(meta, plate.all)

## 3. qPCR Cq-VALUES
#Cq data file must contain:
  
#* ID (unique to each qPCR reaction, must match platedata)
#* Cq-value (calculated per qPCR reaction, left blank if no amplification)

Cq.all=read.csv("1Quantification_Cq_Results_example.csv", header=T)
Cq.all$Cq.Mean=Cq.all$Cq
Cq.all$Cq.Mean[is.na(Cq.all$Cq.Mean)]=0

Cq.all$Cq=as.numeric(Cq.all$Cq)

Cq.meta=merge(Cq.all, metadata.all, by="ID")
Cq.meta$qPCR_presence=as.integer(ifelse(Cq.meta$Cq.Mean>0, 1, 0))

##Calculate efficiency-corrected SQ
Cq.meta$SQ.E=Cq.meta$Threshold/(Cq.meta$E^(Cq.meta$Cq)) #threshold and efficiency calculated for each qPCR sample plate
Cq.meta$SQ.E=as.numeric(Cq.meta$SQ.E)

Cq.data.new=subset(Cq.meta, Project=="Classification" | Project=="Motivating") #subset data to be predicted from model, change project to match metadata

## 4. RANDOM FOREST MODEL
#The trained RF model using data from Nichols et al. (2023) can be loaded to begin classification of new sites.
rf.model=readRDS(file="1rfmodel_2023.rda")

## 5 . PRESENCE-ABSENCE PREDICTIONS
#Predictions are made using the RF model on qPCR amplifications (technical replicates) from new sites. The percentage of positive predictions are plotted by site:
Cq.data.new$Presence=predict(rf.model, newdata=Cq.data.new)
Cq.data.new$Presence[is.na(Cq.data.new$Presence)]=0
Cq.data.new$Presence=as.numeric(as.character(Cq.data.new$Presence))


predictions=ddply(Cq.data.new, .(Location), summarise,  Positive_replicates=sum(Presence), Total_replicates=n(), Percent_positive=Positive_replicates/Total_replicates*100)

write.csv(predictions, file="2sitepredictions.csv", row.names = F)

ggplot(predictions, aes(x=Location, y=Percent_positive, fill=Location)) + geom_bar(stat="identity", color="black", position=position_dodge()) + labs(x="", y="Positive Technical Replicates (%)") + ggtitle("RF Model Predictions") + ylim(0,100) + theme_minimal() + theme(legend.position = "none", axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
