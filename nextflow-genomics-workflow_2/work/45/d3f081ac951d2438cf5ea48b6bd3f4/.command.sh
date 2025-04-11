#!/bin/bash -ue
fastp         --in1 SRR1972739_1.fastq.gz         --in2 SRR1972739_2.fastq.gz         --out1 SRR1972739_R1.trimmed.fastq.gz         --out2 SRR1972739_R2.trimmed.fastq.gz         --detect_adapter_for_pe         --thread 4         --html SRR1972739_fastp.html         --json SRR1972739_fastp.json
