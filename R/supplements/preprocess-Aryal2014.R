# Preprocess data originally reported in the supporting materials of 
# Aryal et al., Plant Cell 2014. 
setwd("~/git/CF-MS-searches")
options(stringsAsFactors = F)
library(tidyverse)
library(magrittr)
library(readxl)

# read table from SI
supp = read_excel("data/supplements/Aryal2014/tpc127563_SupplementalDS1-4.xlsx",
                  sheet = 2, skip = 5)

# extract Bio1
bio1 = supp %>% 
  dplyr::select(`F1...9`:`F34...42`) %>%
  as.matrix()
colnames(bio1) %<>% gsub("\\..*$", "", .)
rownames(bio1) = supp$`Locus IDs`

# extract Bio2
bio2 = supp %>% 
  dplyr::select(`F1...44`:`F34...77`) %>%
  as.matrix()
colnames(bio2) %<>% gsub("\\..*$", "", .)
rownames(bio2) = supp$`Locus IDs`

# save as RDS
replicates = list('Bio1' = bio1, 'Bio2' = bio2)
saveRDS(replicates, 'data/supplements/MSV000082122.rds')
