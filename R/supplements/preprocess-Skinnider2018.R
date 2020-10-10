# Preprocess data originally reported in the supporting materials of 
# Skinnider et al., bioRxiv 2018. 
setwd("~/git/CF-MS-searches")
options(stringsAsFactors = F)
library(tidyverse)
library(magrittr)
library(readxl)

# read original data
original_files = list.files("data/supplements/Skinnider2018",
                            pattern = "*.csv.gz$",
                            full.names = T)
tissues = gsub("maxquant_|\\.csv.*$", "", basename(original_files))
replicates = map(original_files, ~ 
                   read.csv(.) %>%
                   dplyr::select(-Replicate.number) %>%
                   column_to_rownames('Major.Protein.group') %>%
                   as.matrix() %>%
                   # extract proteins never quantified
                   extract(rowSums(!is.na(.)) > 0, )) %>%
  setNames(tissues)

# save as RDS
saveRDS(replicates, 'data/supplements/PXD007288.rds')
