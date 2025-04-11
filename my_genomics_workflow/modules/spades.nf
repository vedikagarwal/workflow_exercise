process SPADES {
    tag "$meta.id"
    label 'process_high'
    
    conda "$projectDir/conda/spades.yml"
    
    input:
    tuple val(meta), path(reads)
    
    output:
    tuple val(meta), path("${prefix}_scaffolds.fasta"), emit: scaffolds
    tuple val(meta), path("${prefix}_contigs.fasta"), emit: contigs
    path "versions.yml", emit: versions
    
    script:
    def args = params.spades_args ?: ''
    prefix = task.ext.prefix ?: "${meta.id}"
    
    """
    spades.py \\
        -1 ${reads[0]} \\
        -2 ${reads[1]} \\
        -o ./spades_output \\
        --threads $task.cpus \\
        $args
    
    cp spades_output/scaffolds.fasta ${prefix}_scaffolds.fasta
    cp spades_output/contigs.fasta ${prefix}_contigs.fasta
    
    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        spades: \$(spades.py --version 2>&1 | sed 's/^.*SPAdes genome assembler v//; s/ .*\$//')
    END_VERSIONS
    """
}
