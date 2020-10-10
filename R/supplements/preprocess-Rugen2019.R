# Preprocess data originally reported in the supporting materials of 
# Rugen et al., MCP 2019. 
setwd("~/git/CF-MS-searches")
options(stringsAsFactors = F)
library(tidyverse)
library(magrittr)
library(readxl)

# set up all files
filenames = c('Rep1' = '143793_1_supp_314592_pqrn8y.xlsx',
              'Rep2' = '143793_1_supp_314619_pqyn8z.xlsx',
              'Rep3' = '143793_1_supp_314621_pqln8z.xlsx',
              'Rep4' = '143793_1_supp_314623_pq5n90.xlsx') 

# loop over files
replicates = list()
for (experiment in names(files)) {
  filename = filenames[experiment]
  file = file.path('data/supplements/Rugen2019', filename)
  skip = ifelse(experiment == 'Rep2', 1, 2)
  dat = read_excel(file, skip = skip)

  # extract iBAQ
  mat = dat %>%
    dplyr::select(starts_with('iBAQ')) %>%
    as.matrix() %>%
    set_rownames(dat[[1]])

  # remove proteins never quantified
  mat %<>% extract(rowSums(. > 0) > 0, )
  replicates[[experiment]] = mat
}

# save as RDS
saveRDS(replicates, 'data/supplements/PXD011088.rds')
