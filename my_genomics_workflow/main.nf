#!/usr/bin/env nextflow

// Enable DSL2
nextflow.enable.dsl = 2

// Import modules
include { FASTP } from './modules/fastp'
include { SPADES } from './modules/spades'
include { SEQKIT_STATS } from './modules/seqkit'

// Log info
log.info """
==================================================
 GENOMICS WORKFLOW - BIOL7210
==================================================
 Input reads   : ${params.reads}
 Output dir    : ${params.outdir}
--------------------------------------------------
"""

// Main workflow
workflow {
    // Define input channel
    input_ch = Channel
        .fromFilePairs(params.reads, checkIfExists: true)
        .map { tuple([id: it[0]], it[1]) }
    
    // Module 1: Run fastp on input reads
    FASTP(input_ch)
    
    // Module 2: Run SPAdes on fastp output (sequential)
    SPADES(FASTP.out.reads)
    
    // Module 3: Run SeqKit on fastp output (parallel with SPAdes)
    SEQKIT_STATS(FASTP.out.reads)
}

// When workflow is completed
workflow.onComplete {
    log.info """
    =================================================
    Workflow execution completed!
    --------------------------------------------------
    Results are in : ${params.outdir}
    Runtime: ${workflow.duration}
    Success: ${workflow.success}
    Exit status: ${workflow.exitStatus}
    =================================================
    """
}
