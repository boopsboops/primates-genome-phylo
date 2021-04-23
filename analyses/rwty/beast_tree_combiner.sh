#!/usr/bin/env bash
# needs to be bash and not dash!

# $0 = basename of program!
# $1 = name of run1 file
# $2 = name of run2 file
# $3 = name of  combined trees output file 
# $4 = burninTrees value
# $5 = output MCC tree file

#gets the taxon block from one of the files (in this case the first one) and makes a new file.
grep -v -e "tree STATE" ${1} > ${3}
# for species trees, need to remove the last 'End;'
sed -i '$ d' ${3}
#searches for the trees using the term 'tree STATE' in both tree files and dumps them into alternate lines in the combined file 
paste -d"\n" <(grep "tree STATE" ${1}) <(grep "tree STATE" ${2}) >> ${3}
#adds the closing nexus code
echo "End;" >> ${3}
# run tree annotator 
treeannotator -burninTrees ${4} -heights mean ${3} ${5}

# 20002 trees total, after 10% burnin @ 2002 = 18000 trees total
#./beast_tree_combiner.sh ../../results/trees/beast_runs/ddRAD_run1.trees ../../results/trees/beast_runs/ddRAD_run2.trees ../../results/trees/beast_runs/ddRAD_comb.trees 2002 ../../results/trees/beast_runs/ddRAD_comb.tre

#./beast_tree_combiner.sh ../../results/trees/beast_runs/Exon_run1.trees ../../results/trees/beast_runs/Exon_run2.trees ../../results/trees/beast_runs/Exon_comb.trees 2002 ../../results/trees/beast_runs/Exon_comb.tre

#./beast_tree_combiner.sh ../../results/trees/beast_runs/finstermeier_run1.trees ../../results/trees/beast_runs/finstermeier_run2.trees ../../results/trees/beast_runs/finstermeier_comb.trees 2002 ../../results/trees/beast_runs/finstermeier_comb.tre

#./beast_tree_combiner.sh ../../results/trees/beast_runs/perelman_run1.trees ../../results/trees/beast_runs/perelman_run2.trees ../../results/trees/beast_runs/perelman_comb.trees 2002 ../../results/trees/beast_runs/perelman_comb.tre


# different for uce - 8002 total, after 10% burnin @ 202 = 7200 total
#./beast_tree_combiner.sh ../../results/trees/beast_runs/UCE_run1.trees ../../results/trees/beast_runs/UCE_run2.trees ../../results/trees/beast_runs/UCE_comb.trees 802 ../../results/trees/beast_runs/UCE_comb.tre

# different for RAD - 2802 total, after 32% burnin @ 900 = 1902 total
#./beast_tree_combiner.sh ../../results/trees/beast_runs/RAD_run1.trees ../../results/trees/beast_runs/RAD_run2.trees ../../results/trees/beast_runs/RAD_comb.trees 900 ../../results/trees/beast_runs/RAD_comb.tre