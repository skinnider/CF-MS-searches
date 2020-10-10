# run on Windows in git bash
GIT_DIR=~/git/CF-MS-searches
MNT_DIR=/f
cd $GIT_DIR
/c/Program\ Files/R/R-3.6.2/bin/Rscript R/maxquant/run_maxquant.R \
    --mqpar_file ${GIT_DIR}/data/mqpar/PXD007288/mqpar-PXD007288-Muscle1.xml \
    --fasta_file ~/git/CF-MS-searches/data/fasta/filtered/UP000000589-M.musculus.fasta.gz \
    --base_dir ${MNT_DIR}/PXD007288 \
    --mq_dir ~/Downloads/MaxQuant_1.6.5.0/MaxQuant/bin \
    --output_dir ${MNT_DIR}/PXD007288/Muscle1 \
    --n_threads 30 \
    --disable_lfq_norm

