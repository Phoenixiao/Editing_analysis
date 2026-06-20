#!/bin/bash
# July 28, 2021

pwd
date

fastq1=$1
#fastq2=$2
crRNA=$3
refer=$4

result_path=$(dirname ${fastq1})
mkdir -p ${result_path}/result
Name=$(basename ${fastq1} .fq.gz)


#CRISPResso="/home/qqxiao/miniconda3/envs/crispresso2_env/bin/CRISPResso"
#${CRISPResso} --fastq_r1 ${fastq1}\
CRISPResso --fastq_r1 ${fastq1}\
	--amplicon_seq ${refer}\
	--guide_seq ${crRNA}\
	--name ${Name}\
	--output_folder ${result_path}/result\
	--write_cleaned_report\
	--place_report_in_output_folder\
	--amplicon_name ${Name}\
	--default_min_aln_score 50\
	-q 10\
	-s 10\
	--min_bp_quality_or_N 10\
	--exclude_bp_from_left 15\
	--exclude_bp_from_right 10\
	--base_editor_output \
	--plot_window_size 22\
	--quantification_window_center -18 \
	--quantification_window_size 22

##########
cp ${result_path}/result/CRISPResso_on_${Name}/*.Quantification_window_nucleotide_frequency_table.txt ${result_path}/result
cp ${result_path}/result/CRISPResso_on_${Name}/9.*.Alleles_frequency_table_around_sgRNA_*.pdf ${result_path}/result
cp ${result_path}/result/CRISPResso_on_${Name}/${Name}.Alleles_frequency_table_around_sgRNA_${crRNA}.txt ${result_path}/result

echo -e "Finished CRISPResso2 analysis!\n`date`\n\n"
