process SEQKIT_STATS {
    tag "$meta"
    conda "bioconda::seqkit"
    
    publishDir "${params.outdir}/seqkit", mode: 'copy'
    
    input:
    tuple val(meta), path(reads)
    
    output:
    path "${meta}.stats.txt", emit: stats
    
    script:
    """
    seqkit stats \
        -a \
        -j ${task.cpus} \
        ${reads} > ${meta}.stats.txt
    """
}
