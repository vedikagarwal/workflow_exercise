#!/bin/bash -ue
spades.py         -1 SRR1972739_R1.trimmed.fastq.gz         -2 SRR1972739_R2.trimmed.fastq.gz         -o SRR1972739_assembly         -t 4

# Copy final contigs and scaffolds to output directory
cp SRR1972739_assembly/contigs.fasta SRR1972739_contigs.fasta
cp SRR1972739_assembly/scaffolds.fasta SRR1972739_scaffolds.fasta
