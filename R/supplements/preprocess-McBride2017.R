# Preprocess data originally reported in the supporting materials of 
# McBride et al., MCP 2017. 
setwd("~/git/CF-MS-searches")
options(stringsAsFactors = F)
library(tidyverse)
library(magrittr)

# list all files
files = list.files("data/supplements/McBride2017", pattern = 'proteinGroups',
                   full.names = T)

# process each file separately
## sucrose
sucrose = read.delim(
  "data/supplements/McBride2017/proteinGroups_SucVelGrad.txt.gz") %>%
  filter(Reverse != '+', Potential.contaminant != '+',
         Only.identified.by.site != '+')
# extract intensities for each replicate
sucrose1 = sucrose %>% 
  extract(, grepl("suc1", colnames(.), ignore.case = T)) %>%
  dplyr::select(starts_with('Intensity.')) %>%
  as.matrix() %>%
  set_rownames(superose$Majority.protein.IDs) %>%
  extract(rowSums(. > 0) > 0, )
sucrose2 = sucrose %>% 
  extract(, grepl("suc2", colnames(.), ignore.case = T)) %>%
  dplyr::select(starts_with('Intensity.')) %>%
  as.matrix() %>%
  set_rownames(superose$Majority.protein.IDs) %>%
  extract(rowSums(. > 0) > 0, )

## superdex
superdex = read.delim(
  "data/supplements/McBride2017/proteinGroups_Superdex.txt.gz") %>%
  filter(Reverse != '+', Potential.contaminant != '+',
         Only.identified.by.site != '+')
# extract intensities for each replicate
superdex1 = superdex %>% 
  extract(, grepl("_1_", colnames(.), ignore.case = T)) %>%
  dplyr::select(starts_with('Intensity.')) %>%
  as.matrix() %>%
  set_rownames(superdex$Majority.protein.IDs) %>%
  extract(rowSums(. > 0) > 0, )
superdex2 = superdex %>% 
  extract(, grepl("_2_", colnames(.), ignore.case = T)) %>%
  dplyr::select(starts_with('Intensity.')) %>%
  as.matrix() %>%
  set_rownames(superdex$Majority.protein.IDs) %>%
  extract(rowSums(. > 0) > 0, )

## superose
superose = read.delim(
  "data/supplements/McBride2017/proteinGroups_Superose.txt.gz") %>%
  filter(Reverse != '+', Potential.contaminant != '+',
         Only.identified.by.site != '+')
# extract intensities for each replicate
superose1 = superose %>% 
  extract(, grepl("superose1_", colnames(.), ignore.case = T)) %>%
  dplyr::select(starts_with('Intensity.')) %>%
  as.matrix() %>%
  set_rownames(superose$Majority.protein.IDs) %>%
  extract(rowSums(. > 0) > 0, )
superose2 = superose %>% 
  extract(, grepl("_2_", colnames(.), ignore.case = T)) %>%
  dplyr::select(starts_with('Intensity.')) %>%
  as.matrix() %>%
  set_rownames(superose$Majority.protein.IDs) %>%
  extract(rowSums(. > 0) > 0, )

# save as RDS
replicates = list(Sucrose1 = sucrose1, Sucrose2 = sucrose2,
                  Superdex1 = superdex1, Superdex2 = superdex2,
                  Superose1 = superose1, Superose2 = superose2)
saveRDS(replicates, 'data/supplements/PXD006694.rds')
