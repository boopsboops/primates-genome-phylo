#!/usr/bin/env python3

#######################################
# A simple script to extract UCEs and flanking regions for 
# phylogenetic analyses. Extractions come in two flavors, 
# 400 bp flanking regions (Faircloth lab), and 100 bp flanking 
# regions (Alfaro lab).
#
# UCE flanking tags
#
# Author:  Tomas Hrbek
# Email: hrbek@evoamazon.net
# Date: 26.06.2015
# Version: 1.0
#######################################

__author__ = 'legal'

import os
import sys
import argparse
from Bio import SeqIO

parser = argparse.ArgumentParser(description='Script to extract UCEs and their flanking regions from whole genomes')
parser.add_argument('sp', help='input species name')
parser.add_argument('uce', help='input UCE database name')
parser.add_argument('flank', help='input length of the flanking region')

args = parser.parse_args()

uce = []
uce_len = []
count_seq = 0
seq = ''

UCE1 = args.sp + '_uce'
UCE2 = args.sp + '_uce_1'
UCE3 = args.sp + '_uce_flank'


print ("********".format())
print ("Extracting UCEs from {0} genome".format(args.sp))
print ("Please wait till finished".format())

#system call to perform megablast using upto 3 CPU threads - extract position of UCEs in the subject genome
blastn = 'blastn -task megablast -query ../../../scripts/' + args.uce + ' -db ./blast/' + args.sp + ' -max_target_seqs 1 -outfmt "10 sgi sstart send sstrand qstart qend" -out ./' + UCE1 +' -num_threads 3'
os.system(blastn)

#create a catalog of UCE probe lengths
UCE = '../' + args.uce
fasta_sequences = SeqIO.parse(open(UCE),'fasta')
for fasta in fasta_sequences:
	sequence = str(fasta)
	uce_len.append(len(sequence))

#prepare new file used for extraction of UCEs and their flanking regions based their position within the subject genome 
UCE1_1 = './' + UCE1
input_handle = open(UCE1_1, "rU")
for line in input_handle :
	word = line.split(",")
	if word[1] > word[2] :
		w = word[1]
		word[1] = word[2]
		word[2] = w
	
	#Faircloth UCE
	#line = word[0] + ' '  + str(int(word[1])-int(word[4])-int(args.flank)) + '-' + str(int(word[2])+(uce_len[count_seq]-int(word[5]))+int(args.flank)) + ' ' + word[3] + '\n'
	line = word[0] + ' '  + str(int(word[1])-int(args.flank)) + '-' + str(int(word[2])+int(args.flank)) + ' ' + word[3] + '\n'
	uce.append(line)

input_handle.close()

#**********************
#Faircloth UCE
UCE2_1 = './' + UCE2 + '_Faircloth'
output_handle = open(UCE2_1, "w")
output_handle.write("".join(str(x) for x in uce))
output_handle.close()
UCE3_1 = './' + UCE3 + '_Faircloth'

#system call to perform extract exons from the subject genome based on their position
blastdbcmd = 'blastdbcmd -db ./blast/' + args.sp + ' -entry_batch ' + UCE2_1 + ' -outfmt "%f" -out ' +  UCE3_1
os.system(blastdbcmd)

#format fasta file for use in step 6 of pyRAD analysis
count_seq = 0
seq = ''

input_handle = open(UCE3_1, "r")
UCE4_1 = './' + args.sp + '_Faircloth.consens'
output_handle = open(UCE4_1, "w")

for line in input_handle :
	if line[0]  == '>' :
		count_seq += 1
		line = '>' + args.sp + '_' + str(count_seq) + '_c1\n'
		seq = seq + '\n'
		if count_seq > 1 :
			output_handle.write(seq)
		seq = ''
		output_handle.write(line)
	else :
		seq = seq + line[:-1]
output_handle.write(seq)

output_handle.close()
input_handle.close()

#system call to compress the pyRAD compatible fasta file
compress = 'gzip ' + UCE4_1
os.system(compress)
