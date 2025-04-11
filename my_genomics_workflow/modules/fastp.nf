process FASTP {
    tag "$meta.id"
    label 'process_medium'
    
    conda "$projectDir/conda/fastp.yml"
    
    input:
    tuple val(meta), path(reads)
    
    output:
    tuple val(meta), path("*_trimmed_R{1,2}.fastq.gz"), emit: reads
    path "*.html", emit: html
    path "*.json", emit: json
    path "versions.yml", emit: versions
    
    script:
    def args = params.fastp_args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    
    """
    fastp \\
        --in1 ${reads[0]} \\
        --in2 ${reads[1]} \\
        --out1 ${prefix}_trimmed_R1.fastq.gz \\
        --out2 ${prefix}_trimmed_R2.fastq.gz \\
        --json ${prefix}.fastp.json \\
        --html ${prefix}.fastp.html \\
        --thread $task.cpus \\
        $args
        
    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        fastp: \$(fastp --version 2>&1 | sed -e "s/fastp //g")
    END_VERSIONS
    """
}
