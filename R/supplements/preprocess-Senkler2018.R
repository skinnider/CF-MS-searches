# Preprocess data originally reported in the supporting materials of 
# Senkler et al., Curr Biol 2018. 
setwd("~/git/CF-MS-searches")
options(stringsAsFactors = F)
library(tidyverse)
library(magrittr)
library(readxl)

# read file
dat = read.delim(
  "data/supplements/Senkler2018/proteinGroups_results.txt.gz") %>%
  filter(Potential.contaminant != '+', 
         Reverse != '+', 
         Only.identified.by.site != '+')

# extract iBAQ
mat = dat %>%
  dplyr::select(starts_with('iBAQ.')) %>%
  as.matrix() %>%
  set_rownames(dat[[1]])

# remove proteins never quantified
mat %<>% extract(rowSums(. > 0) > 0, )

# save as RDS
replicates = list(map = mat)
saveRDS(replicates, 'data/supplements/PXD008974.rds')
