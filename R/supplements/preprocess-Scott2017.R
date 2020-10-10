# Preprocess data originally reported in the supporting materials of 
# Scott et al., MSB 2017. 
setwd("~/git/CF-MS-searches")
options(stringsAsFactors = F)
library(tidyverse)
library(magrittr)
library(readxl)

# read SEC (cytoplasmic) profiles
sec = read.xlsx("data/supplements/Scott2017/msb167067-sup-0013-tableev11.xlsx",
                sheet = 1, startRow = 2)

# split by replicates and channels
replicates = list()
for (replicate in unique(sec$`PCP-SILAC.Replicate`)) {
  for (channel in c('heavy', 'medium')) {
    dat = sec %>%
      filter(`PCP-SILAC.Replicate` == replicate)
    if (channel == 'heavy') {
      dat0 = dat %>% extract(, grepl('H/L', colnames(.)))
    } else {
      dat0 = dat %>% extract(, grepl('M/L', colnames(.)))
    }
    dat0 %<>% extract(, !grepl('normalized', colnames(.)))
    
    # convert to numeric
    mat = dat0 %>% 
      mutate_all(as.numeric) %>%
      as.matrix() %>%
      set_rownames(dat$Majority.protein.IDs) %>%
      # remove proteins never quantified
      extract(rowSums(!is.na(.)) > 0, )
    
    # add to list
    repl_name = paste0('SEC', replicate, '-', channel)
    replicates[[repl_name]] = mat
  }
}

# now, repeat for BN-PAGE
bn = read.xlsx("data/supplements/Scott2017/msb167067-sup-0013-tableev11.xlsx",
                sheet = 2, startRow = 2)
for (replicate in unique(bn$`Replicate`)) {
  for (channel in c('heavy', 'medium')) {
    dat = bn %>%
      filter(`Replicate` == replicate)
    if (channel == 'heavy') {
      dat0 = dat %>% extract(, grepl('H/L', colnames(.)))
    } else {
      dat0 = dat %>% extract(, grepl('M/L', colnames(.)))
    }
    dat0 %<>% extract(, !grepl('normalized', colnames(.)))
    
    # convert to numeric
    mat = dat0 %>% 
      mutate_all(as.numeric) %>%
      as.matrix() %>%
      set_rownames(dat$Majority.protein.IDs) %>%
      # remove proteins never quantified
      extract(rowSums(!is.na(.)) > 0, )
    
    # add to list
    repl_name = paste0('BN', replicate, '-', channel)
    replicates[[repl_name]] = mat
  }
}

# save as RDS
saveRDS(replicates, 'data/supplements/PXD002892.rds')
