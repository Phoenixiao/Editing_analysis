#!/bin/bash

pwd
date

########
#Check data
echo -e "\nStarting MD5 check..."
if md5sum -c md5.md5; then
    echo "MD5 check passed."
else
    echo "MD5 check FAILED!" >&2
    exit 1
fi
date
echo -e "Finished MD5 checking.\n"

########
echo Starting calculate data size...
for fq in *.fq.gz
    do
        zcat ${fq} | awk -v name=${fq} 'BEGIN{OFS="\t"}{if(FNR%4==0) base+=length}END{printf "%s\t%.2f million reads\t%.2f G bases\n", name, FNR/4e6, base/1e9}'
done
echo -e "Finished checking data size.\n`date`\n"

########
mkdir -p hiQ
echo Starting fastq_quality_filter...
for fq in *.fq.gz
  do
    gzip -dc ${fq} | fastq_quality_filter -q 30 -p 90 -z -o hiQ/${fq:0:-6}.qc.fq.gz -Q 33
    date
done
echo Finished fastq_quality_filter processing.

echo -e "Finished all process steps.\n"
