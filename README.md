# primates-genome-phylo
Code and data from Collins &amp; Hrbek (2018)

## Summary

This repository contains a bash script for downloading whole genomes from Genbank and a script for generating a local BLAST databases. It then contains three python scripts for extracting RADtag, UCE and Exon data from the databases. It also contains a bash script for running these three python scripts. Finally it contains a file each of UCEs and Exons.

## Prerequisites

1 - Scripts are written in python3, so install numpy, scipy and Biopython modules for python3

2 - Install Blast+ from NCBI, and and put in the path


## Directory structure for running scripts

Running the scripts assumes a specific directory structure. Scripts and UCE and Exon files are in the ./scripts directory. Genomes are in ./temp/genomes with subdirectories corresponding to species and containing the genome of the species (in fasta format), and each species subdirectory contains a ./blast subdirectory which has the species genome converted into a blast database.

```
./base-dir/scripts - contains scripts and UCE and Exon files in fasta format plus species subdirectories

./base-dir/temp/Genus_species - contains species genome in fasta format plus blast subdirectory

./base-dir/temp/Genus_species/blast - contains local blast database of the species genome
```

The scripts assume that the species subdirectory, the genome and the blast database use the same name. (e.g. Homo_sapiens -> ./Homo_sapiens, Homo_sapiens.fasta, ./Homo_sapiens/blast/Homo_sapiens...)


## Running scripts

### Download genomes

You can download genomes directly from NCBI, or use wget to download. All genomes 
should be uncompressed fasta format with the extention .fas and be placed in the 
./base-dir/temp/Genus_species folder.  You can also run the script

```
bash genome_download.sh
```

### Generate local blast databases

Generate local blast database for each genome using the following script

```
bash generate_blast_db.sh
```
Alternately you can generate the database by running this command 
while being in the ./temp/Genus_species directory

```
makeblastdb -in Genus_species.fas -out ./blast/Genus_species -dbtype nucl -title Genus_species -parse_seqids
```

### Running scripts to extract loci

You can run the scripts individually from the ./scripts directory

```
./extract_RAD Genus_species lower_fragment_size upper_fragment_size

./extract_UCE Genus_species uce.fasta size_of_flanking_region

./extract_EXON Genus_species exon.fasta size_of_flanking_region
```

or you can run a bash script to extract all loci from all genomes at once

```
bash extract_loci.sh
```

## Python scripts

All three scripts output a compressed fasta file ready for processing in Step 6 of the pyRAD pipeline.
Format of the fasta file is:

\>Genus_species_1_c1  
GATCGATC...  
\>Genus_species_2_c1  
GATCGATC...  
...

### extract_RAD

This script is an expanded version of an older script used for estimating the number of ddRADtags in a given size range and reports various statistics about the genome.  This version also saves the ddRADtags in this size range (default 350-450 bp) and all RADtags in the genome. The script extracts this nformation from fasta formated species' genome.

For options run ./extract_RAD -h


### extract_UCE

This script extracts UCE and their flanking regions. The UCE probes are the standard Tetrapods-UCE-2.5Kv1 2560 probe set (see http://ultraconserved.org/) 
developed by Faircloth and collaborators.

For options run ./extract_UCE -h


### extract_EXON

This script extracts EXON.  These exon are orthologous to the 512 exon dataset used by the Lemmon lab (see http://datadryad.org/bitstream/handle/10255/dryad.39324/Lemmon-etal2012_Probes.zip?sequence=1).

For options run ./extract_EXON -h
