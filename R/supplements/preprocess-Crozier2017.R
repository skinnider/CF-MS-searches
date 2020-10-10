# Preprocess data originally reported in the supporting materials of 
# Crozier et al., MCP 2017. 
setwd("~/git/CF-MS-searches")
options(stringsAsFactors = F)
library(tidyverse)
library(magrittr)

# list files
files = list.files("data/supplements/Crozier2017", pattern = 'proteinGroups',
                   full.names = T)
dats = map(files, read.delim) %>%
  setNames(gsub("-.*$", "", basename(files)))

# iBAQ quantitations used in the paper
ibaqs = map(dats, ~ column_to_rownames(., 'Majority.protein.IDs') %>% 
              dplyr::select(starts_with('iBAQ.')))

# now, split by replicates
repls = map(ibaqs, ~ {
  replicates = gsub("^.*\\.|_.*$", "", colnames(.))
  expr = .
  map(unique(replicates), ~ {
    replicate = .
    extract(expr, , replicates == replicate) %>%
      set_colnames(paste0('F', gsub("^.*_", "", colnames(.))))
  }) %>%
    setNames(unique(replicates))
})

# unnest the top layer 
columns = rep(names(repls), lengths(repls))
replicates = flatten(repls) %>%
  setNames(paste0(columns, '_', names(.)))
  
# save as RDS
saveRDS(replicates, 'data/supplements/PXD005968.rds')
