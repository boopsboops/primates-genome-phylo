#!/usr/bin/env bash

# get pyrad and checkout stable release
#git clone https://github.com/dereneaton/pyrad.git
#git tag
#git checkout 3.0.5

# put into PATH 
#export PATH=/home/tomas/bin/pyrad:$PATH

# cd and run on ddRAD
cd ../../temp/pyrad_output/ddRAD
pyRAD -p params.txt -s 7

# cd and run on Exon
cd ../../temp/pyrad_output/Exon
pyRAD -p params.txt -s 7

# cd and run on RAD
cd ../../temp/pyrad_output/RAD
pyRAD -p params.txt -s 7

# cd and run on UCE_Faircloth
cd ../../temp/pyrad_output/UCE_Faircloth
pyRAD -p params.txt -s 7