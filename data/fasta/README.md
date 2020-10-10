## FASTA

This directory contains protein FASTA files used for mass spectrometric database search. 

Proteomes were obtained from [UniProt](https://www.uniprot.org/uniprot), and include both reviewed and unreviewed accessions, and canonical and isoform sequences. Proteins less than 10 amino acids in length were subsequently filtered.

Proteomes were downloaded and filtered for the following species:

- `UP000000589`: Mus musculus 
- `UP000000803`: Drosophila melanogaster
- `UP000001203`: Cyanothece sp. (strain ATCC 51142)
- `UP000001450`: Plasmodium falciparum
- `UP000001514`: Selaginella moellendorffii
- `UP000001593`: Nematostella vectensis
- `UP000001940`: Caenorhabditis elegans
- `UP000002195`: Dictyostelium discoideum
- `UP000002311`: Saccharomyces cerevisiae
- `UP000002494`: Rattus norvegicus
- `UP000004994`: Solanum lycopersicum
- `UP000005640`: Homo sapiens
- `UP000006548`: Arabidopsis thaliana
- `UP000006906`: Chlamydomonas reinhardtii
- `UP000007110`: Strongylocentrotus purpuratus
- `UP000007305`: Zea mays
- `UP000008066`: Chaetomium thermophilum
- `UP000008524`: Trypanosoma brucei
- `UP000008827`: Glycine max
- `UP000019116`: Triticum aestivum
- `UP000031513`: Plasmodium knowlesi
- `UP000032141`: Brassica oleracea
- `UP000059680`: Oryza sativa
- `UP000074855`: Plasmodium berghei
- `UP000186698`: Xenopus laevis

The subdirectories contain the following information:

- `raw`: protein FASTA files downloaded directly from UniProt
- `filtered`: filtered protein FASTA files, used for proteomic database search
