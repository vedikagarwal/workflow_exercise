#!/bin/bash -ue
fastp         --in1 SRR1556289_1.fastq.gz         --in2 SRR1556289_2.fastq.gz         --out1 SRR1556289_R1.trimmed.fastq.gz         --out2 SRR1556289_R2.trimmed.fastq.gz         --detect_adapter_for_pe         --thread 4         --html SRR1556289_fastp.html         --json SRR1556289_fastp.json
