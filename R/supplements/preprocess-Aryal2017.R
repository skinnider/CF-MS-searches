# Preprocess data originally reported in the supporting materials of 
# Aryal et al., J Proteomics 2017. 
setwd("~/git/CF-MS-searches")
options(stringsAsFactors = F)
library(tidyverse)
library(magrittr)
library(readxl)

# read table from SI
supp = read_excel("data/supplements/Aryal2017/1-s2.0-S1874391917302075-mmc1.xlsx",
                  sheet = 2)

# extract Bio1
bio1 = supp %>% 
  dplyr::select(starts_with('Bio1-F')) %>%
  as.matrix() %>%
  replace(. == 0, NA)
colnames(bio1) %<>% gsub("^.*-", "", .)
rownames(bio1) = supp$Accession

# extract Bio2
bio2 = supp %>% 
  dplyr::select(starts_with('Bio2_F')) %>%
  as.matrix() %>%
  replace(. == 0, NA)
colnames(bio2) %<>% gsub("^.*_", "", .)
rownames(bio2) = supp$Accession

# save as RDS
replicates = list('Bio1' = bio1, 'Bio2' = bio2)
saveRDS(replicates, 'data/supplements/MSV000081206.rds')
