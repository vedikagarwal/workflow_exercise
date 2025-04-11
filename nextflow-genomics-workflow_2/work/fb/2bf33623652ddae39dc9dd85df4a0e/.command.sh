#!/bin/bash -ue
seqkit stats -a SRR1972739_R1.trimmed.fastq.gz > SRR1972739_R1.stats.txt
seqkit stats -a SRR1972739_R2.trimmed.fastq.gz > SRR1972739_R2.stats.txt
cat SRR1972739_R1.stats.txt SRR1972739_R2.stats.txt > SRR1972739_combined.stats.txt
