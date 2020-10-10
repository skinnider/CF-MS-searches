# Preprocess data originally reported in the supporting materials of 
# Aryal et al., J Proteome Res 2018. 
setwd("~/git/CF-MS-searches")
options(stringsAsFactors = F)
library(tidyverse)
library(magrittr)
library(readxl)

# read table from SI
supp = read_excel("data/supplements/Aryal2018/pr8b00170_si_001.xlsx",
                  sheet = 2, skip = 5)

# extract B1
bio1 = supp %>%
  dplyr::select(starts_with('B1_F')) %>%
  as.matrix() %>%
  replace(. == 0, NA)
colnames(bio1) %<>% gsub("^.*_", "", .)
rownames(bio1) = supp$`Protein IDs`

# extract B2
bio2 = supp %>%
  dplyr::select(starts_with('B2_F')) %>%
  as.matrix() %>%
  replace(. == 0, NA)
colnames(bio2) %<>% gsub("^.*_", "", .)
rownames(bio2) = supp$`Protein IDs`

# save as RDS
replicates = list('B1' = bio1, 'B2' = bio2)
saveRDS(replicates, 'data/supplements/MSV000082916.rds')
