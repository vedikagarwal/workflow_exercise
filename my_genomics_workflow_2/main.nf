#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// Import modules
include { FASTP } from './modules/local/fastp'
include { SPADES } from './modules/local/spades'
include { SEQKIT_STATS } from './modules/local/seqkit'

// Define parameters
params.outdir = 'results'
params.reads = null
params.test = false

// Log information
log.info """\
         G E N O M I C S   W O R K F L O W
         ================================
         reads        : ${params.reads}
         outdir       : ${params.outdir}
         """
         .stripIndent()

// Define the workflow
workflow {
    if (params.test) {
        // Use the test data in the test_data directory
        log.info "Using test data from test_data directory"
        
        // Try to use paired-end patterns first
        paired_test_files = file("$projectDir/test_data/*_{1,2}.fastq.gz")
        
        if (paired_test_files.size() > 0) {
            log.info "Found paired-end test data"
            reads_ch = Channel.fromFilePairs("$projectDir/test_data/*_{1,2}.fastq.gz")
        } else {
            // Fall back to single-end reads
            single_test_files = file("$projectDir/test_data/*.fastq.gz")
            
            if (single_test_files.size() > 0) {
                log.info "Found single-end test data"
                reads_ch = Channel.fromPath("$projectDir/test_data/*.fastq.gz")
                            .map { file -> tuple(file.simpleName, file) }
            } else {
                error "No test data found in $projectDir/test_data/. Please ensure test data is available."
            }
        }
    } else if (params.reads) {
        // Use provided reads
        if (params.reads.contains('*')) {
            // Handle wildcard patterns for paired-end data
            reads_ch = Channel.fromFilePairs(params.reads)
        } else {
            // Handle direct file reference for single-end data
            reads_ch = Channel.fromPath(params.reads)
                            .map { file -> tuple(file.simpleName, file) }
        }
    } else {
        error "Please provide input reads with --reads or use -profile test"
    }
    
    // Log the files being processed
    reads_ch.view { meta, file -> "Processing: $meta, File: $file" }
    
    // Module 1: Run fastp on the input reads
    FASTP(reads_ch)
    
    // Module 2: Run SPAdes on fastp output (assembly)
    SPADES(FASTP.out.reads)
    
    // Module 3: Run SeqKit on fastp output (metrics)
    // This runs in parallel with Module 2
    SEQKIT_STATS(FASTP.out.reads)
}
