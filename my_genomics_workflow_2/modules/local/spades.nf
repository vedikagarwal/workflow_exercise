process SPADES {
    tag "$meta"
    conda "bioconda::spades"
    
    publishDir "${params.outdir}/spades", mode: 'copy'
    
    input:
    tuple val(meta), path(reads)
    
    output:
    tuple val(meta), path("${meta}_scaffolds.fasta"), emit: scaffolds
    path "${meta}_contigs.fasta", emit: contigs
    path "${meta}_spades.log", emit: log
    
    script:
    // Check if input is paired-end or single-end
    if (reads instanceof List && reads.size() == 2) {
        // Paired-end data
        """
        spades.py \
            --pe1-1 ${reads[0]} \
            --pe1-2 ${reads[1]} \
            -o ./spades_output \
            --careful \
            -t ${task.cpus}
            
        # Copy the output files with the sample name prefix
        cp spades_output/scaffolds.fasta ${meta}_scaffolds.fasta
        cp spades_output/contigs.fasta ${meta}_contigs.fasta
        cp spades_output/spades.log ${meta}_spades.log
        """
    } else {
        // Single-end data
        """
        spades.py \
            -s ${reads} \
            -o ./spades_output \
            --careful \
            -t ${task.cpus}
            
        # Copy the output files with the sample name prefix
        cp spades_output/scaffolds.fasta ${meta}_scaffolds.fasta
        cp spades_output/contigs.fasta ${meta}_contigs.fasta
        cp spades_output/spades.log ${meta}_spades.log
        """
    }
}
