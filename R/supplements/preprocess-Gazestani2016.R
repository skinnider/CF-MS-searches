# Preprocess data originally reported in the supporting materials of 
# Gazestani et al., PLoS Pathog 2016. 
setwd("~/git/CF-MS-searches")
options(stringsAsFactors = F)
library(tidyverse)
library(magrittr)
library(readxl)

### IEX
# read data
iex1 = read.delim(
  "data/supplements/Gazestani2016/Cyto-IEX-proteinGroups.txt.gz") %>%
  filter(Reverse != '+' & Potential.contaminant != '+')
iex2 = read.delim(
  "data/supplements/Gazestani2016/Mito-IEX-proteinGroups.txt.gz") %>%
  filter(Reverse != '+' & Potential.contaminant != '+')

# filter observations supported by <2 peptides
pept1 = iex1 %>% 
  dplyr::select(starts_with('Peptides.')) %>%
  as.matrix()
pept2 = iex2 %>% 
  dplyr::select(starts_with('Peptides.')) %>%
  as.matrix()

# extract intensities
iex1 %<>%
  dplyr::select(starts_with("Intensity.")) %>% 
  set_rownames(iex1$Majority.protein.IDs) %>% 
  as.matrix()
iex1[pept1 < 2] = 0
iex2 %<>%
  dplyr::select(starts_with("Intensity.")) %>% 
  set_rownames(iex2$Majority.protein.IDs) %>% 
  as.matrix()
iex2[pept2 < 2] = 0

# remove proteins never quantified
iex1 %<>% extract(rowSums(. > 0) > 0, )
iex2 %<>% extract(rowSums(. > 0) > 0, )

# save as RDS
replicates = list('Cyto-IEX' = iex1, 'Mito-IEX' = iex2)
saveRDS(replicates, 'data/supplements/PXD002640.rds')
