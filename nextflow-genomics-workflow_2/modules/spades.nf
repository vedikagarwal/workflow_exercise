process SPADES {
    tag "$meta.id"
    conda "bioconda::spades"  // Using a version known to work with ARM Macs
    
    publishDir "${params.outdir}/spades", mode: 'copy'
    
    input:
    tuple val(meta), path(reads)
    
    output:
    tuple val(meta), path("${meta.id}_assembly"), emit: assembly_dir
    tuple val(meta), path("${meta.id}_contigs.fasta"), emit: contigs
    tuple val(meta), path("${meta.id}_scaffolds.fasta"), emit: scaffolds
    
    script:
    def meta_id = meta.id
    
    """
    spades.py \
        -1 ${reads[0]} \
        -2 ${reads[1]} \
        -o ${meta_id}_assembly \
        -t ${params.threads}
    
    # Copy final contigs and scaffolds to output directory
    cp ${meta_id}_assembly/contigs.fasta ${meta_id}_contigs.fasta
    cp ${meta_id}_assembly/scaffolds.fasta ${meta_id}_scaffolds.fasta
    """
}
