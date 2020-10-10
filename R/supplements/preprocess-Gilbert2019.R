# Preprocess data originally reported in the supporting materials of 
# Gilbert et al., J Proteome Res 2019. 
setwd("~/git/CF-MS-searches")
options(stringsAsFactors = F)
library(tidyverse)
library(magrittr)
library(readxl)

# read data
rep1 = read_excel("data/supplements/Gilbert2019/pr8b00382_si_002.xlsx", 
                  sheet = 2)
rep2 = read_excel("data/supplements/Gilbert2019/pr8b00382_si_002.xlsx",
                  sheet = 3)

# limit to LFQ
mat1 = rep1 %>%
  dplyr::select(starts_with('LFQ')) %>%
  as.matrix() %>%
  set_rownames(rep1$`Protein IDs`)
mat2 = rep2 %>%
  dplyr::select(starts_with('LFQ')) %>%
  as.matrix() %>%
  set_rownames(rep2$`Protein IDs`)

# save as RDS
replicates = list(Rep1 = mat1, Rep2 = mat2)
saveRDS(replicates, 'data/supplements/PXD009511.rds')
