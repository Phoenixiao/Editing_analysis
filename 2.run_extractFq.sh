#!/bin/bash

date
pwd

##########
barcode_path=$1
multiple_fq=$2
fq_name=$3
out_path=$4

for fastq in ${multiple_fq}/${fq_name}
    do
        echo -e "Start decompressing ${fastq}...\n`date`\n"
        echo "Decompressed ${fastq}."
        Date=$(date "+%Y%m%d-%H%M%S")
        echo "Start extracting ${fastq}..."
        bash 1.extractFq_v1.0.sh ${barcode_path} ${fastq} ${out_path} > ${Date}_extractFq.log 2>&1
        echo -e "Finished ${fastq} extract.\n`date`\n"
done

##########
mkdir -p ${out_path}/fastq
sub_path=${out_path}/fastq

for fq in ${out_path}/*-F.fq.gz;
    do
        prefix=$(basename $fq "-F.fq.gz")
        F=${prefix}-F.fq.gz
        R=${prefix}-R.fq.gz
        echo $F $R
        zcat ${out_path}/$F ${out_path}/$R | gzip > ${out_path}/${prefix}.fq.gz
        mv ${out_path}/$F ${sub_path}/$F
        mv ${out_path}/$R ${sub_path}/$R
        date
done

echo -e "Finished all Samples extract.\n`date`\n"

