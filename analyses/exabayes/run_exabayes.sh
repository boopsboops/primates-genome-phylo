#!/usr/bin/env bash

# download
#wget http://sco.h-its.org/exelixis/material/exabayes/1.4.1/exabayes-1.4.1-src.tar.gz
# manual: http://sco.h-its.org/exelixis/web/software/exabayes/manual/index.html

# to compile the non-MPI multithreaded version of exabayes 
# dumps exes in bin folder
#./configure --bindir=/home/rupert/Software/exabayes-1.4.1/bin && make install
#make clean

# CD
#cd /home/tomas/Documents/exabayes_runs

# export PATH
export PATH=/home/tomas/bin/exabayes-1.4.1/bin:$PATH

# cd
cd ../../temp/exabayes_runs

# run finstermeier
yggdrasil -T 4 -f finstermeier_mtdnas_renamed.gblocks.phy -c exabayes.config -w . -m DNA -n finstermeier-run1 -s 10280715 -M 0
yggdrasil -T 4 -f finstermeier_mtdnas_renamed.gblocks.phy -c exabayes.config -w . -m DNA -n finstermeier-run2 -s 90280715 -M 0

# run perelman
yggdrasil -T 8 -f perelman_primates_renamed.phy -c exabayes.config -w . -m DNA -n perelman-run1 -s 10280715 -M 0
yggdrasil -T 8 -f perelman_primates_renamed.phy -c exabayes.config -w . -m DNA -n perelman-run2 -s 90280715 -M 0

# run ddRAD
yggdrasil -T 8 -f ../pyrad_output/ddRAD/outfiles/ddRAD.gblocks.phy -c ../../analyses/exabayes/exabayes.config -w ddRAD/ -m DNA -n ddRAD-run1 -s 10280715 -M 0
yggdrasil -T 8 -f ../pyrad_output/ddRAD/outfiles/ddRAD.gblocks.phy -c ../../analyses/exabayes/exabayes.config -w ddRAD/ -m DNA -n ddRAD-run2 -s 90280715 -M 0

# run Exon
yggdrasil -T 8 -f ../pyrad_output/Exon/outfiles/Exon.gblocks.phy -c ../../analyses/exabayes/exabayes.config -w Exon/ -m DNA -n Exon-run1 -s 10280715 -M 0
yggdrasil -T 8 -f ../pyrad_output/Exon/outfiles/Exon.gblocks.phy -c ../../analyses/exabayes/exabayes.config -w Exon/ -m DNA -n Exon-run2 -s 90280715 -M 0

# run UCEs
yggdrasil -T 8 -f ../pyrad_output/UCE_Faircloth/outfiles/UCE_Faircloth.gblocks.phy -c ../../analyses/exabayes/exabayes.config -w UCE/ -m DNA -n UCE-run1 -s 10280715 -M 0
yggdrasil -T 8 -f ../pyrad_output/UCE_Faircloth/outfiles/UCE_Faircloth.gblocks.phy -c ../../analyses/exabayes/exabayes.config -w UCE/ -m DNA -n UCE-run2 -s 90280715 -M 0

# run RAD
yggdrasil -T 8 -f ../pyrad_output/RAD/outfiles/RAD.gblocks.phy -c ../../analyses/exabayes/exabayes.config -w RAD/ -m DNA -n RAD-run1 -s 10280715 -M 0
yggdrasil -T 8 -f ../pyrad_output/RAD/outfiles/RAD.gblocks.phy -c ../../analyses/exabayes/exabayes.config -w RAD/ -m DNA -n RAD-run2 -s 90280715 -M 0