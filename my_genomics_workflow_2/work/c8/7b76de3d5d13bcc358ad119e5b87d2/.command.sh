#!/bin/bash -ue
fastp             --in1 SRR1556289_1.fastq.gz             --in2 SRR1556289_2.fastq.gz             --out1 SRR1556289_1.trimmed.fastq.gz             --out2 SRR1556289_2.trimmed.fastq.gz             --json SRR1556289.fastp.json             --html SRR1556289.fastp.html             --thread 2
