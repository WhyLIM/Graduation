 # @Author: Min Li
 # @Email: mli.bio@outlook.com
 # @Last Modified by: Min Li
 # @Timestamp for Last Modification: 2022-05-08 18:11:10
 # @Description: This R file is used to find the common drugs screened by three calculations.

library(tidyverse)
setwd("D:/Study/Project/Graduation/7_proximity_calculate")

rm(list = ls())
proximity_2528 <- read.csv("proximity_seed2528.csv", sep = ",", header = T, stringsAsFactors = F)
proximity_3901 <- read.csv("proximity_seed3901.csv", sep = ",", header = T, stringsAsFactors = F)
proximity_5413 <- read.csv("proximity_seed5413.csv", sep = ",", header = T, stringsAsFactors = F)

drug_2528 <- proximity_2528[which(proximity_2528$zscore < -2 & proximity_2528$pvalue <= 0.05), 1]
drug_3901 <- proximity_3901[which(proximity_3901$zscore < -2 & proximity_3901$pvalue <= 0.05), 1]
drug_5413 <- proximity_5413[which(proximity_5413$zscore < -2 & proximity_5413$pvalue <= 0.05), 1]

drugs <- intersect(drug_2528, drug_3901) %>% intersect(drug_5413)

drugs_df <- data.frame()

for (drug in drugs) {
  drugs_df <- rbind(drugs_df, proximity_2528[which(proximity_2528$Drug == drug), ]) %>% 
    rbind(proximity_3901[which(proximity_3901$Drug == drug), ]) %>% 
    rbind(proximity_5413[which(proximity_5413$Drug == drug), ])
}

drugs_result <- aggregate(drugs_df[, -1], by = list(Drug=drugs_df$Drug), mean) %>% dplyr::arrange(zscore, pvalue)

write.csv(drugs_result, "Drugs_result.csv", row.names = F)
