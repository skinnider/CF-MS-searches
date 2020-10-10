# Preprocess data originally reported in the supporting materials of 
# Larance et al., MCP 2016. 
setwd("~/git/CF-MS-searches")
options(stringsAsFactors = F)
library(tidyverse)
library(magrittr)
library(readxl)

# read supplementary table
suppl = read_excel("data/supplements/Larance2016/mcp.O115.055467-3.xlsx",
                   skip = 3)

# map experiments to files
des = read.delim("data/supplements/Larance2016/experimentalDesignTemplate.txt") %>%
  separate(Experiment, c("condition", "experiment1", "fraction"), '_') %>%
  mutate(experiment2 = substr(Name, 1, 8)) %>%
  dplyr::select(-Fraction, -X) %>%
  mutate(condition = fct_recode(condition, Native = 'PBS', Crosslinked = 'PFA'))

# extract LFQ
lfq = suppl %>%
  dplyr::select(starts_with('LFQ.')) %>% 
  as.matrix() %>%
  set_rownames(suppl$Protein.IDs)

# split by replicates
replicates = gsub("^.*\\.", "", colnames(lfq)) %>% substr(1, nchar(.) - 3)
mats = map(unique(replicates), ~ {
  keep = which(replicates == .)
  lfq %>%
    extract(, keep) %>% 
    # remove proteins never quantified
    extract(rowSums(. > 0) > 0, )
}) %>% setNames(unique(replicates))

# recode experiment names
repl_map = des %>%
  mutate(original = paste0(condition, '_', experiment1)) %>%
  distinct(original, experiment2) %$%
  setNames(experiment2, original)
names(mats) = repl_map[names(mats)]

# save as RDS
saveRDS(mats, 'data/supplements/PXD003754.rds')
