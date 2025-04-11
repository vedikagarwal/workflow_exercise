process FASTP {
    tag "$meta.id"
    conda "bioconda::fastp=0.23.4"
    
    publishDir "${params.outdir}/fastp", mode: 'copy'
    
    input:
    tuple val(meta), path(reads)
    
    output:
    tuple val(meta), path("*.trimmed.fastq.gz"), emit: reads
    path "*.html", emit: html
    path "*.json", emit: json
    
    script:
    def meta_id = meta.id
    def input_reads = reads.join(" ")
    
    """
    fastp \
        --in1 ${reads[0]} \
        --in2 ${reads[1]} \
        --out1 ${meta_id}_R1.trimmed.fastq.gz \
        --out2 ${meta_id}_R2.trimmed.fastq.gz \
        --detect_adapter_for_pe \
        --thread ${params.threads} \
        --html ${meta_id}_fastp.html \
        --json ${meta_id}_fastp.json
    """
}
