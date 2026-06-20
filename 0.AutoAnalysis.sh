#!/bin/bash
# Author: Qingquan Xiao
# Date: 28th August, 2021

echo -e "Current time: $(date)"
echo -e "Current path: `pwd`\nNow, start analysis...\n\n"

##########
#Sample information
barcode_path="/home/qqxiao/data/qq_2026/wlq/260601-A00199A/test/barcode.txt"
infor="/home/qqxiao/data/qq_2026/wlq/260601-A00199A/test/10.infor-be.txt"
multiple_fq="/home/qqxiao/data/qq_2026/wlq/260601-A00199A/test/hiQ"
out_path="/home/qqxiao/data/qq_2026/wlq/260601-A00199A/test/hiQ/split"
fq_name="NW-2_L1_[12].qc.fq.gz"
prefix="wlq"

mkdir -p ${out_path}
result_path=${out_path}

##########
#Extract multiple fastq
echo -e "Start extract multiple fastq sequence...\n`date`"
Date=$(date "+%Y%m%d-%H%M%S")
bash 2.run_extractFq.sh ${barcode_path} ${multiple_fq} ${fq_name} ${out_path} > ${Date}_extract.log 2>&1
echo -e "Finished extract.\n\n" 

##########
#CRISPResso2 analysis
echo -e "Start CRISPResso2 analysis every samples...\n`date`"
Date=$(date "+%Y%m%d-%H%M%S")
bash 4.run_CRISPResso2.sh ${out_path} ${infor} > ${Date}_CRISPResso2.log 2>&1
echo -e "Finished CRISPResso2 analysis.\n\n"

##########
#Convert text results to excel format table
echo -e "Summary results...\n`date`"
bash 6.run_readOut.sh ${result_path} > ${Date}_Summary.log 2>&1
echo -e "Finished results summary.\n`date`\n\n"

##########
#
cd ${out_path}/result
tar -czf "${prefix}.results.tar.gz" *.xlsx *.pdf *Alleles_frequency_table_around*.txt

##########
echo Finished all analysis steps.
date
