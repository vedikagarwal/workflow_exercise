#!/bin/bash -ue
spades.py             --pe1-1 SRR1556289_1.trimmed.fastq.gz             --pe1-2 SRR1556289_2.trimmed.fastq.gz             -o ./spades_output             --careful             -t 2

# Copy the output files with the sample name prefix
cp spades_output/scaffolds.fasta SRR1556289_scaffolds.fasta
cp spades_output/contigs.fasta SRR1556289_contigs.fasta
cp spades_output/spades.log SRR1556289_spades.log
