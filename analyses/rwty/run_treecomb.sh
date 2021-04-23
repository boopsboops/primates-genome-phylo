#!/usr/bin/env bash
# set the dataset - must be same as folder and run names
dataset="finstermeier"

# cd
cd ../../temp/exabayes_runs/$dataset
# combine the files
../../../analyses/rwty/tree_combiner.sh ExaBayes_topologies.$dataset-run1.0 ExaBayes_topologies.$dataset-run2.0 ExaBayes_topologies.$dataset-runsCombined.trees 1002 ExaBayes_topologies.$dataset-runsCombined.tre
# check for convergence (assuming 5001 trees in each run)
sdsf -i 0.05 -b 501 -f ExaBayes_topologies.$dataset-run1.0 ExaBayes_topologies.$dataset-run2.0 > $dataset.converge
# to prep for rwty
mkdir rwty_input
# move all the exabayes output files
cp *.0 rwty_input
cd rwty_input
# to rename all the topology and parameter files
rename 's/0/p/' *parameters* ; rename 's/0/t/' *topologies*
# make filenames the same
rename 's/parameters\.//' *.p ; rename 's/topologies\.//' *.t
# fix up the tree files for RWTY to count the states
sed -i 's/\.{0}//g' *.t
