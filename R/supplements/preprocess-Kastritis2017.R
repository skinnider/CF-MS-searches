# Preprocess data originally reported in the supporting materials of 
# Kastritis et al., MSB 2017. 
setwd("~/git/CF-MS-searches")
options(stringsAsFactors = F)
library(tidyverse)
library(magrittr)
library(readxl)

# read table from SI
supp = read_excel("data/supplements/Kastritis2017/Dataset_EV1_MSData.xlsx",
                  sheet = 2, skip = 4)

# extract numeric matrix
mat = supp %>%
  dplyr::select(starts_with("iBAQ")) %>%
  as.matrix() 
mat1 = mat[, grepl("F[^d][^d]A", colnames(mat))]
mat2 = mat[, grepl("F[^d][^d]B", colnames(mat))]
mat3 = mat[, grepl("C", colnames(mat))]

# remove 'iBAQ' from colnames
colnames(mat1) %<>% gsub("^.* ", "", .)
colnames(mat2) %<>% gsub("^.* ", "", .)
colnames(mat3) %<>% gsub("^.* ", "", .)

# set rownames
rownames(mat1) = supp$`UniProt Accession`
rownames(mat2) = supp$`UniProt Accession`
rownames(mat3) = supp$`UniProt Accession`

# remove proteins never quantified
mat1 %<>% extract(rowSums(mat1 > 0) > 0, )
mat2 %<>% extract(rowSums(mat2 > 0) > 0, )
mat3 %<>% extract(rowSums(mat3 > 0) > 0, )

# save as RDS
replicates = list(A = mat1, B = mat2, C = mat3)
saveRDS(replicates, 'data/supplements/PXD006660.rds')
