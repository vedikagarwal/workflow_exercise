process SEQKIT_STATS {
    tag "$meta.id"
    label 'process_low'
    
    conda "$projectDir/conda/seqkit.yml"
    
    input:
    tuple val(meta), path(reads)
    
    output:
    tuple val(meta), path("${prefix}_stats.txt"), emit: stats
    path "versions.yml", emit: versions
    
    script:
    def args = params.seqkit_args ?: ''
    prefix = task.ext.prefix ?: "${meta.id}"
    
    """
    seqkit stats \\
        -a \\
        -j $task.cpus \\
        ${reads[0]} ${reads[1]} \\
        $args > ${prefix}_stats.txt
    
    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        seqkit: \$(seqkit version | sed 's/seqkit v//')
    END_VERSIONS
    """
}
