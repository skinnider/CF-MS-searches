# Preprocess data originally reported in the supporting materials of 
# Mergner et al., Nature 2020. 
setwd("~/git/CF-MS-searches")
options(stringsAsFactors = F)
library(tidyverse)
library(magrittr)
library(readxl)

# read supplementary table
suppl = read_excel("data/supplements/Mergner2020/41586_2020_2094_MOESM9_ESM.xlsx",
                   sheet = 2, skip = 1)

# split into constituent experiments
expts = split(suppl, suppl$tissue)

# for each experiment, extract matrix of protein intensities
mats = map(expts, ~ dplyr::select(., `UniProt id`, starts_with("Top3")) %>%
             column_to_rownames('UniProt id') %>%
             as.matrix() %>%
             # remove proteins never quantified
             extract(rowSums(. > 0) > 0, ))

# save as RDS
saveRDS(mats, 'data/supplements/PXD013868.rds')
