#!/usr/bin/env python3

#######################################
# A simple script to extract orthologous exons for phylogenetic 
# analyses. Blasted exons are from human and used in the 
# Lemmon lab at UFL.
#
# anchored sequence tags
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

parser = argparse.ArgumentParser(description='Script to extract exons and their flanking regions from whole genomes')
parser.add_argument('sp', help='input species name')
parser.add_argument('exon', help='input EXON database name')
parser.add_argument('flank', help='input length of the flanking region')

args = parser.parse_args()

exon = []
exon_len = []
count_seq = 0
seq = ''

EXON1 = args.sp + '_exon'
EXON2 = args.sp + '_exon_1'
EXON3 = args.sp + '_exon_flank'


print ("********".format())
print ("Extracting EXONs from {0} genome".format(args.sp))
print ("Please wait till finished".format())

#system call to perform megablast using upto 3 CPU threads - extract position of exons in the subject genome
blastn = 'blastn -task megablast -query ../../../scripts/' + args.exon + ' -db ./blast/' + args.sp + ' -max_target_seqs 1 -outfmt "10 sgi sstart send sstrand qstart qend" -out ./' + EXON1 +' -num_threads 3'
os.system(blastn)

#create a catalog of exon probe lengths
EXON = '../' + args.exon
fasta_sequences = SeqIO.parse(open(EXON),'fasta')
for fasta in fasta_sequences:
	sequence = str(fasta)
	exon_len.append(len(sequence))
	
#prepare new file used for extraction of exons and their flanking regions based their position within the subject genome 
EXON1_1 = './' + EXON1
input_handle = open(EXON1_1, "rU")
for line in input_handle :
	word = line.split(",")
	if word[1] > word[2] :
		w = word[1]
		word[1] = word[2]
		word[2] = w
	
	#extract exons and their flanking regions
	#line = word[0] + ' '  + str(int(word[1])-int(word[4])-int(args.flank)) + '-' + str(int(word[2])+(exon_len[count_seq]-int(word[5]))+int(args.flank)) + ' ' + word[3] + '\n'
	line = word[0] + ' '  + str(int(word[1])-int(args.flank)) + '-' + str(int(word[2])+int(args.flank)) + ' ' + word[3] + '\n'
	exon.append(line)
	
input_handle.close()

EXON2_1 = './' + EXON2 + '_Lemmon'
output_handle = open(EXON2_1, "w")
output_handle.write("".join(str(x) for x in exon))
output_handle.close()
EXON3_1 = './' + EXON3 + '_Lemmon'

#system call to perform extract exons from the subject genome based on their position
blastdbcmd = 'blastdbcmd -db ./blast/' + args.sp + ' -entry_batch ' + EXON2_1 + ' -outfmt "%f" -out ' +  EXON3_1
os.system(blastdbcmd)

#format fasta file for use in step 6 of pyRAD analysis
count_seq = 0
seq = ''

input_handle = open(EXON3_1, "r")
EXON4_1 = './' + args.sp + '_Lemmon.consens'
output_handle = open(EXON4_1, "w")

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
compress = 'gzip ' + EXON4_1
os.system(compress)

