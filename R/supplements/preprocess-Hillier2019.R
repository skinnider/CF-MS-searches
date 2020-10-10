# Preprocess data originally reported in the supporting materials of 
# Hillier et al., Cell Rep 2019. 
setwd("~/git/CF-MS-searches")
options(stringsAsFactors = F)
library(tidyverse)
library(magrittr)

# list all files
files = list.files("data/supplements/Hillier2019", pattern = 'proteinGroups',
                   full.names = T)

# loop over files
replicates = list()
for (file in files) {
  experiment = gsub("-.*$", "", basename(file))
  dat = read.delim(file) %>%
    filter(Reverse != '+', Potential.contaminant != '+',
           Only.identified.by.site != '+')
  
  # extract intensities
  mat = dat %>% 
    dplyr::select(starts_with('Intensity.')) %>%
    as.matrix() 
  
  # set rownames
  rownames(mat) = dat$Majority.protein.IDs
  
  # remove proteins never quantified
  mat %<>% extract(rowSums(. > 0) > 0, )
  replicates[[experiment]] = mat
}

# save as RDS
saveRDS(replicates, 'data/supplements/PXD009039.rds')
