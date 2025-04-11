process FASTP {
    tag "$meta"
    conda "bioconda::fastp=0.23.4"
    
    publishDir "${params.outdir}/fastp", mode: 'copy'
    
    input:
    tuple val(meta), path(reads)
    
    output:
    tuple val(meta), path("*trimmed*.fastq.gz"), emit: reads
    path "*.json", emit: json
    path "*.html", emit: html
    
    script:
    def prefix = "${meta}"
    
    // Check if input is paired-end or single-end
    if (reads instanceof List && reads.size() == 2) {
        // Paired-end data
        """
        fastp \
            --in1 ${reads[0]} \
            --in2 ${reads[1]} \
            --out1 ${prefix}_1.trimmed.fastq.gz \
            --out2 ${prefix}_2.trimmed.fastq.gz \
            --json ${prefix}.fastp.json \
            --html ${prefix}.fastp.html \
            --thread ${task.cpus}
        """
    } else {
        // Single-end data
        """
        fastp \
            --in1 ${reads} \
            --out1 ${prefix}.trimmed.fastq.gz \
            --json ${prefix}.fastp.json \
            --html ${prefix}.fastp.html \
            --thread ${task.cpus}
        """
    }
}
