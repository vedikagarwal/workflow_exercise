#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Include modules
include { FASTP } from './modules/fastp'
include { SPADES } from './modules/spades'
include { SEQKIT_STATS } from './modules/seqkit'

// Define input parameters with defaults
params.reads = "$projectDir/test_data/reads/*_{1,2}.fastq.gz"
params.outdir = "results"
params.threads = 4

// Check if output directory exists and handle accordingly
if (file(params.outdir).exists() && !params.overwrite) {
    error "Output directory '${params.outdir}' already exists. Use '--overwrite true' to overwrite existing results."
}

// Log parameters
log.info """\
         GENOMICS WORKFLOW PIPELINE    
         ===========================
         reads        : ${params.reads}
         outdir       : ${params.outdir}
         threads      : ${params.threads}
         """
         .stripIndent()

// Define the workflow
workflow {
    // Create channel from input reads with metadata
    read_pairs_ch = Channel
        .fromFilePairs(params.reads, checkIfExists: true)
        .map { tuple -> [ [id: tuple[0]], tuple[1] ] }  // Add metadata with id
        .ifEmpty { error "Cannot find any reads matching: ${params.reads}" }
    
    // STEP 1: Run FASTP on input reads
    FASTP(read_pairs_ch)
    
    // STEP 2 & 3: Run SPAdes and SEQKIT in parallel on FASTP output
    SPADES(FASTP.out.reads)
    SEQKIT_STATS(FASTP.out.reads)
}
