#!/bin/bash
# Author: Qingquan XIAO
# Date: July 28th, 2021

pwd
date

fq_path=$1
infor=$2
# CRISPResso2 analysis

for info in `cat ${infor}`;
    do
        echo ${info}
        Sample=$(echo ${info} | awk -F "," '{print $1}')
        sgRNA=$(echo ${info} | awk -F "," '{print $2}')
        ref_fa=$(echo ${info} | awk -F "," '{print $3}')
        echo 'Sample="'${fq_path}/${Sample}'"'
        echo 'sgRNA="'${sgRNA}'"'
        echo 'ref_fa="'${ref_fa}'"'
        Date=$(date "+%Y%m%d-%H%M%S")
        bash 3.CRISPResso2.sh ${fq_path}/${Sample} fastq2 ${sgRNA} ${ref_fa} > ${Date}_CRISPResso2.log
        echo -e Finished CRISPResso2 analysis for $(basename ${Sample} fq.gz). \\n`date` \\n\\n\\n
done

echo -e Finished CRISPResso2 analysis. \\n$(date) \\n\\n
