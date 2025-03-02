cp data/mqpar/conf/modifications.local.xml ~/MaxQuant/bin/conf
~/R-3.6.0/bin/Rscript R/maxquant/run_maxquant.R \
    --mqpar_file ~/git/CF-MS-searches/data/mqpar/PXD003754/mqpar-PXD003754-PT3442S1.xml \
    --fasta_file ~/git/CF-MS-searches/data/fasta/filtered/UP000005640-H.sapiens.fasta.gz \
    --base_dir /mnt/PXD003754 \
    --mq_dir ~/MaxQuant/bin \
    --output_dir /mnt/PXD003754/PT3442S1 \
    --lysc \
    --carbamidomethylation none \
    --cysteine_nem fixed
