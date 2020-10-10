# Preprocess data originally reported in the supporting materials of 
# Gorka et al., Sci Rep 2019. 
setwd("~/git/CF-MS-searches")
options(stringsAsFactors = F)
library(tidyverse)
library(magrittr)

# read MaxQuant results
dat = read.delim(
  "data/supplements/Gorka2019/proteinGroups_replicate_separately.txt.gz")

# extract LFQ
lfq = dat %>%
  dplyr::select(starts_with('LFQ.')) %>%
  as.matrix() %>%
  set_rownames(dat$Majority.protein.IDs)

# split up by replicates
replicates = gsub("^.*_", "", colnames(lfq))
mats = map(unique(replicates), ~ {
  keep = which(endsWith(colnames(lfq), .))
  lfq %>%
    extract(, keep) %>%
    # remove proteins never quantified
    extract(rowSums(. > 0) > 0, )
}) %>% setNames(unique(replicates))

# recode replicate names
repl_idxs = names(mats) %>%
  gsub("S", "", .) %>%
  as.numeric() 
repl_names = paste0(ifelse(repl_idxs %% 2 == 1, 'ED', 'EN'), '_',
                    ceiling(repl_idxs / 2))
names(mats) = repl_names

# save as RDS
saveRDS(mats, 'data/supplements/PXD010919.rds')
