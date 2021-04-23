#!/usr/bin/env bash

# download
wget http://molevol.cmima.csic.es/castresana/Gblocks/Gblocks_Linux64_0.91b.tar.Z
# add to path
export PATH=/home/tomas/bin/Gblocks_0.91b:$PATH

# download seq manipulation scripts from 
# http://indra.mullins.microbiol.washington.edu/perlscript/docs/Sequence.html
export PATH=/home/tomas/bin/seqconvert:$PATH


# convert and run ddRAD
cd ../../temp/pyrad_output/ddRAD/outfiles
Phylip2Fasta.pl ddRAD.phy ddRAD.fas
gblocks ddRAD.fas -t=d -b1=12 -b2=12 -b3=8 -b4=10 -b5=n -e=.gbl -p=s
sed -i 's/ //g' ddRAD.fas.gbl
Fasta2Phylip.pl ddRAD.fas.gbl ddRAD.gblocks.phy


# convert and run RAD
cd ../../temp/pyrad_output/RAD/outfiles
Phylip2Fasta.pl RAD.phy RAD.fas
gblocks RAD.fas -t=d -b1=12 -b2=12 -b3=8 -b4=10 -b5=n -e=.gbl -p=s
sed -i 's/ //g' RAD.fas.gbl
Fasta2Phylip.pl RAD.fas.gbl RAD.gblocks.phy


# convert and run Exons
cd ../../temp/pyrad_output/Exon/outfiles
Phylip2Fasta.pl Exon.phy Exon.fas
gblocks Exon.fas -t=d -b1=12 -b2=12 -b3=8 -b4=10 -b5=n -e=.gbl -p=s
sed -i 's/ //g' Exon.fas.gbl
Fasta2Phylip.pl Exon.fas.gbl Exon.gblocks.phy


# convert and run UCEs
cd ../../temp/pyrad_output/UCE_Faircloth/outfiles
Phylip2Fasta.pl UCE_Faircloth.phy UCE_Faircloth.fas
gblocks UCE_Faircloth.fas -t=d -b1=12 -b2=12 -b3=8 -b4=10 -b5=n -e=.gbl -p=s
sed -i 's/ //g' UCE_Faircloth.fas.gbl
Fasta2Phylip.pl UCE_Faircloth.fas.gbl UCE_Faircloth.gblocks.phy


# convert and run Perelman
cd ../../temp
Phylip2Fasta.pl perelman_primates_renamed.phy perelman_primates_renamed.fas
Gblocks perelman_primates_renamed.fas -t=d -b1=12 -b2=12 -b3=8 -b4=10 -b5=n -e=.gbl -p=s
sed -i 's/ //g' perelman_primates_renamed.fas.gbl
Fasta2Phylip.pl perelman_primates_renamed.fas.gbl perelman_primates_renamed.gblocks.phy
sed -i 's/?/N/g' perelman_primates_renamed.gblocks.phy


# convert and run Finstermeier
cd ../../temp
Phylip2Fasta.pl finstermeier_mtdnas_renamed.phy finstermeier_mtdnas_renamed.fas
Gblocks finstermeier_mtdnas_renamed.fas -t=d -b1=12 -b2=12 -b3=8 -b4=10 -b5=n -e=.gbl -p=s
sed -i 's/ //g' finstermeier_mtdnas_renamed.fas.gbl
Fasta2Phylip.pl finstermeier_mtdnas_renamed.fas.gbl finstermeier_mtdnas_renamed.gblocks.phy
sed -i 's/?/N/g' finstermeier_mtdnas_renamed.gblocks.phy


