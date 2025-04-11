#!/bin/bash -ue
seqkit stats -a SRR1556289_R1.trimmed.fastq.gz > SRR1556289_R1.stats.txt
seqkit stats -a SRR1556289_R2.trimmed.fastq.gz > SRR1556289_R2.stats.txt
cat SRR1556289_R1.stats.txt SRR1556289_R2.stats.txt > SRR1556289_combined.stats.txt
