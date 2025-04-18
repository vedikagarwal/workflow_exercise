# Nextflow Genomics Workflow

This repository contains a Nextflow workflow for genomic analysis created for BIOL7210.

## Workflow Overview

This workflow performs the following steps:
1. Quality control and trimming of raw reads using `fastp`
2. Assembly of trimmed reads using `SPAdes`
3. Generation of read statistics using `SeqKit` (running in parallel with assembly)

### Workflow Diagram

![image](https://github.com/user-attachments/assets/1ffeb893-0192-467b-99d0-bfb4b430f019)


## Requirements

- Nextflow (v24.10.5)
- Conda (v23.11.0) or later
- Operating System: Linux, MacOS, or Windows with WSL2
- Architecture: x86_64

## Test Data

This workflow has been tested using paired-end RNA-Seq data from the 2014 Zaire ebolavirus outbreak in Sierra Leone.

- Accession: SRR1972739

- Organism: Zaire ebolavirus

- Sample: G4252.1

- Sequencing Platform: Illumina HiSeq 2500

- Study: Broad Institute, PRJNA257197 / SRP045416

- Library Layout: Paired-end, RNA-Seq from human serum, cDNA selection

The data is stored in the following files:

```bash
test_data/reads/SRR1972739_1.fastq.gz
test_data/reads/SRR1972739_2.fastq.gz
```

## Quick Start

### Clone the repository

```bash
git clone https://github.com/vedikagarwal/workflow_exercise.git
cd workflow_exercise/nextflow-genomics-workflow
```

### Run the workflow

1. Install Nextflow (if not already installed):
```bash
conda create -n nf -c bioconda nextflow=24.10.5 -y
conda activate nf
```

2. Run the workflow using Conda for tool management:
```bash
nextflow run main.nf -profile conda,test
```

The workflow will automatically:
- Set up environments for each tool
- Run the tools in the proper order
- Generate output in the `results` directory

## Output

The workflow generates the following outputs:

- `results/fastp/`: Trimmed reads and QC reports
- `results/spades/`: Assembly output including contigs and scaffolds
- `results/seqkit/`: Read statistics

## Performance

With the included test data, this workflow should complete in less than 10 minutes on a standard laptop.
