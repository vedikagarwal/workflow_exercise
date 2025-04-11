process SEQKIT_STATS {
    tag "$meta.id"
    conda "bioconda::seqkit"  // Using an older version that should be available
    
    publishDir "${params.outdir}/seqkit", mode: 'copy'
    
    input:
    tuple val(meta), path(reads)
    
    output:
    tuple val(meta), path("*.stats.txt"), emit: stats
    
    script:
    def meta_id = meta.id
    
    """
    seqkit stats -a ${reads[0]} > ${meta_id}_R1.stats.txt
    seqkit stats -a ${reads[1]} > ${meta_id}_R2.stats.txt
    cat ${meta_id}_R1.stats.txt ${meta_id}_R2.stats.txt > ${meta_id}_combined.stats.txt
    """
}
