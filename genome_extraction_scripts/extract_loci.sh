#!/bin/bash


ARRAY=(Aotus_nancymaae Callithrix_jacchus Cercocebus_atys Chlorocebus_sabaeus Colobus_angolensis Gorilla_gorilla Homo_sapiens Macaca_fascicularis Macaca_mulatta Macaca_nemestrina Mandrillus_leucophaeus Microcebus_murinus Nasalis_larvalus Nomascus_leucogenys Otolemur_garnettii Pan_paniscus Pan_troglodytes Papio_anubis Pongo_abelii Propithecus_coquereli Rhinopithecus_roxellana Saimiri_boliviensis Tarsius_syrichta)

#echo ${ARRAY[*]}

for i in ${ARRAY[*]}; do
	echo "********"
	echo "********"
	echo "*******$i********"
	cd ../temp/genomes/$i
	../../../scripts/extract_RAD $i 320 400
	../../../scripts/extract_UCE $i uce.fasta 240
	../../../scripts/extract_EXON $i exon.fasta 180
	cd ../..
done

