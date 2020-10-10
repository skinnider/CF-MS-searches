# Preprocess data originally reported in the supporting materials of 
# Connelly et al., Proteomics 2018. 
setwd("~/git/CF-MS-searches")
options(stringsAsFactors = F)
library(tidyverse)
library(magrittr)
library(readxl)

# read table from SI
supp = read_excel("data/supplements/Connelly2018/pmic12865-sup-0002-tables1.xlsx",
                  sheet = 2, skip = 6)

# extract Bio1
bio1 = supp %>%
  dplyr::select(`F15...3`:`F34...22`) %>%
  as.matrix() %>%
  replace(. == 0, NA)
colnames(bio1) %<>% gsub("\\..*$", "", .)
rownames(bio1) = supp$`Protein IDs`

# extract Bio2
bio2 = supp %>%
  dplyr::select(`F15...24`:`F34...43`) %>%
  as.matrix() %>%
  replace(. == 0, NA)
colnames(bio2) %<>% gsub("\\..*$", "", .)
rownames(bio2) = supp$`Protein IDs`

# save as RDS
replicates = list('Bio1' = bio1, 'Bio2' = bio2)
saveRDS(replicates, 'data/supplements/MSV000081520.rds')
