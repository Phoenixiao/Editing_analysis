#!/bin/bash

date
pwd

result_path=$1
rts=${result_path}/result/*Quantification_window_nucleotide_frequency_table.txt

for txt in ${rts}
    do
        python 5.readOut.py ${txt}
        date
done

echo Finished!
