#!/usr/bin/env bash

./beast -beagle -beagle_SSE -threads n -instances n -beagle_double -beagle_scaling none -seed 1270716 -overwrite ddRAD_run1.xml
./beast -beagle -beagle_SSE -threads n -instances n -beagle_double -beagle_scaling none -seed 2270716 -overwrite ddRAD_run2.xml


./beast -beagle -beagle_SSE -threads n -instances n -beagle_double -beagle_scaling none -seed 1270716 -overwrite RAD_run1.xml
./beast -beagle -beagle_SSE -threads n -instances n -beagle_double -beagle_scaling none -seed 2270716 -overwrite RAD_run2.xml


./beast -beagle -beagle_SSE -threads n -instances n -beagle_double -beagle_scaling none -seed 1270716 -overwrite Exon_run1.xml
./beast -beagle -beagle_SSE -threads n -instances n -beagle_double -beagle_scaling none -seed 2270716 -overwrite Exon_run2.xml


./beast -beagle -beagle_SSE -threads n -instances n -beagle_double -beagle_scaling none -seed 1270716 -overwrite UCE_run1.xml
./beast -beagle -beagle_SSE -threads n -instances n -beagle_double -beagle_scaling none -seed 2270716 -overwrite UCE_run2.xml


./beast -beagle -beagle_SSE -threads n -instances n -beagle_double -beagle_scaling none -seed 1270716 -overwrite finstermeier_run1.xml
./beast -beagle -beagle_SSE -threads n -instances n -beagle_double -beagle_scaling none -seed 2270716 -overwrite finstermeier_run2.xml


./beast -beagle -beagle_SSE -threads n -instances n -beagle_double -beagle_scaling none -seed 1270716 -overwrite perelman_run1.xml
./beast -beagle -beagle_SSE -threads n -instances n -beagle_double -beagle_scaling none -seed 2270716 -overwrite perelman_run2.xml
