#!/bin/bash -ue
spades.py         -1 SRR1556289_R1.trimmed.fastq.gz         -2 SRR1556289_R2.trimmed.fastq.gz         -o SRR1556289_assembly         -t 4

# Copy final contigs and scaffolds to output directory
cp SRR1556289_assembly/contigs.fasta SRR1556289_contigs.fasta
cp SRR1556289_assembly/scaffolds.fasta SRR1556289_scaffolds.fasta
