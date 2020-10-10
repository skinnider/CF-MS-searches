# Preprocess data originally reported in the supporting materials of 
# Wan et al., Nature 2015.
setwd("~/git/CF-MS-searches")
options(stringsAsFactors = F)
library(tidyverse)
library(magrittr)

# first, set up maps between species and accessions
accessions = c('PXD002319' = 'Ce',
               'PXD002320' = 'Dd', 
               'PXD002321' = 'Dm',
               'PXD002322' = 'Hs',
               'PXD002323' = 'Mm',
               'PXD002324' = 'Nv',
               'PXD002325' = 'Sp',
               'PXD002326' = 'Xl',
               'PXD002327' = 'Sc')

# process one species at a time
dirs = list.dirs('data/supplements/Wan2015', recursive = F)
all = list()
for (accession in names(accessions)) {
  species = accessions[accession]
  
  # list files
  dir = dirs[startsWith(basename(dirs), species)]
  files = list.files(dir, full.names = T, pattern = '*.gz$')  
  experiments = gsub("\\..*$", "", basename(files))
  
  # read data
  dats = map(files, read.delim)
  replicates = map(dats, ~ dplyr::select(., -TotalCount) %>% 
                     column_to_rownames('X.ProtID') %>%
                     as.matrix() %>%
                     # extract any proteins never quantified
                     extract(rowSums(. > 0) > 0, )) %>%
    setNames(experiments)
  
  # save as RDS
  output_file = paste0("data/supplements/", accession, ".rds")
  saveRDS(replicates, output_file)
  
  # add to list for manual inspection
  all[[accession]] = replicates
}
