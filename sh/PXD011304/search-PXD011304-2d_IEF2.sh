~/R-3.6.0/bin/Rscript R/maxquant/run_maxquant.R \
    --mqpar_file ~/git/CF-MS-searches/data/mqpar/PXD011304/mqpar-PXD011304-2d_IEF2.xml \
    --fasta_file ~/git/CF-MS-searches/data/fasta/filtered/UP000000589-M.musculus.fasta.gz \
    --base_dir /mnt/sdc1/PXD011304 \
    --mq_dir ~/MaxQuant/bin \
    --output_dir /mnt/sdc1/PXD011304/2d_IEF2 \
    --n_threads 30
