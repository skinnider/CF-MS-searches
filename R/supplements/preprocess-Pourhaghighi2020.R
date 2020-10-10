# Preprocess data originally reported in the supporting materials of 
# Pourhaghighi et al., Cell Syst 2020. 
setwd("~/git/CF-MS-searches")
options(stringsAsFactors = F)
library(tidyverse)
library(magrittr)
library(readxlsb)

# read file
dat = read_csv("data/supplements/Pourhaghighi2020/SupplementaryTableS1 1.csv.gz",
               skip = 2)
proteins = dat$Protein.IDs

# split by replicates
experiments = colnames(dat) %>%
  extract(-1) %>% ## protein IDs
  strsplit("\\.") %>%
  map_chr(~ ifelse(length(.) > 2,
                   paste0(.[1], .[2]), .[1])) %>%
  ## match up manually to MQ experiment names
  fct_recode('2D_IEF1' = '2DIEF1',
             '2d_IEF2' = '2DIEF2',
             '2D_IEF3' = '2DIEF3',
             '2D_IEF4' = '2DIEF4',
             '2D_IEF5' = '2DIEF5',
             'Cyto60' = 'Cyt60',
             'HIEX110' = 'Hep'
             # IEX90
             # Mem60
             )

# extract matrices
replicates = list()
for (experiment in experiments) {
  keep = which(experiments == experiment)
  mat = dat[, keep + 1] %>%
    as.matrix() %>%
    set_rownames(proteins) %>%
    # remove proteins never quantified
    extract(rowSums(. > 0) > 0, ) 
  replicates[[as.character(experiment)]] = mat
}

# save as RDS
saveRDS(replicates, 'data/supplements/PXD011304.rds')
