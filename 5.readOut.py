#!/usr/bin/env python
# -*- coding:utf-8 -*-
# Date: July 28, 2021

#import os
import sys
import numpy as np
import pandas as pd
#source = "E45-1F.Quantification_window_nucleotide_frequency_table.txt"
source = sys.argv[1]
#outpath = sys.argv[2] + os.sep
outFile = "%s.xlsx" % source.split(".")[0]
sheetName = "%s_summary" % source.split(".")[0].split(r"/")[-1]
with open(source, mode="r") as text:
    for line in text:
        line = line.strip("\n")
        if line.startswith("\t"):
            sg=line.replace("\t", "")
            columnsLabel=list("%s%s" % (j, i+1) for i, j in enumerate(sg))
            rowslabels = ["A", "C", "G", "T", "N", "-","total", "A%", "C%", "G%", "T%", "N%", "-%"]
            refTable = pd.DataFrame(columns=columnsLabel, index = rowslabels)
            #print(sg)
        elif line.startswith("A"):
            _A_list = list(line[2 : ].split("\t"))
            A_list = [int(float(i)) for i in _A_list]
            refTable.loc["A"] = A_list
            #print(A_list)
        elif line.startswith("C"):
            _C_list = list(line[2 : ].split("\t"))
            C_list = [int(float(i)) for i in _C_list]
            refTable.loc["C"] = C_list
            #print(C_list)
        elif line.startswith("G"):
            _G_list = list(line[2 : ].split("\t"))
            G_list = [int(float(i)) for i in _G_list]
            refTable.loc["G"] = G_list
            #print(G_list)
        elif line.startswith("T"):
            _T_list = list(line[2 : ].split("\t"))
            T_list = [int(float(i)) for i in _T_list]
            refTable.loc["T"] = T_list
            #print(T_list)
        elif line.startswith("N"):
            _N_list = list(line[2 : ].split("\t"))
            N_list = [int(float(i)) for i in _N_list]
            refTable.loc["N"] = N_list
            #print(N_list)
        elif line.startswith("-"):
            _XX_list = list(line[2 : ].split("\t"))
            XX_list = [int(float(i)) for i in _XX_list]
            refTable.loc["-"] = XX_list
            #print(XX_list)
            refTable.loc["total"] = refTable.apply(lambda x : x.sum())
            refTable.loc["A%"] = refTable.loc["A"] * 100 / refTable.loc["total"]
            refTable.loc["C%"] = refTable.loc["C"] * 100 / refTable.loc["total"]
            refTable.loc["G%"] = refTable.loc["G"] * 100 / refTable.loc["total"]
            refTable.loc["T%"] = refTable.loc["T"] * 100 / refTable.loc["total"]
            refTable.loc["N%"] = refTable.loc["N"] * 100 / refTable.loc["total"]
            refTable.loc["-%"] = refTable.loc["-"] * 100 / refTable.loc["total"]
            refTable.to_excel(outFile, header=True, index=True, sheet_name=sheetName)
         
text.close()

print("Finished!")

