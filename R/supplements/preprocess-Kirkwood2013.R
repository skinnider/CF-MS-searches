# Preprocess data originally reported in the supporting materials of 
# Kirkwood et al., MCP 2013. 
setwd("~/git/CF-MS-searches")
options(stringsAsFactors = F)
library(tidyverse)
library(magrittr)

# read MaxQuant results
dat = read.delim("data/supplements/Kirkwood2013/proteinGroups.txt.gz")

# extract counts
mat = dat %>%
  dplyr::select(starts_with('Slice.')) %>%
  extract(, -1) %>% ## 'Slice average'
  as.matrix() %>%
  replace(is.na(.), 0)

# set rownames
rownames(mat) = dat$Majority.protein.IDs

# set column names and split into replicates
design = read.delim("data/mqpar/PXD001220/experimentalDesignTemplate.txt")
colnames(mat) = design$Name
replicates = map(unique(design$Experiment), ~ {
  keep = which(design$Experiment == .)
  mat %>%
    extract(, keep) %>% 
    # remove proteins never quantified
    extract(rowSums(. > 0) > 0, )
}) %>% setNames(unique(design$Experiment))

# save as RDS
saveRDS(replicates, 'data/supplements/PXD001220.rds')
