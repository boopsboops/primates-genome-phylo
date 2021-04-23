#!/bin/bash


ARRAY=(Aotus_nancymaae Callithrix_jacchus Cercocebus_atys Chlorocebus_sabaeus Colobus_angolensis Gorilla_gorilla Homo_sapiens Macaca_fascicularis Macaca_mullata Macaca_nemestrina Mandrillus_leucophaeus Microcebus_murinus Nasalis_larvalus Nomascus_leucogenys Otolemur_garnettii Pan_paniscus Pan_troglodytes Papio_anubis Pongo_abelii Propithecus_coquereli Rhinopithecus_roxellana Saimiri_boliviensis Tarsius_syrichta)

#echo ${ARRAY[*]}

for i in ${ARRAY[*]}; do
	echo "********"
	echo "***creating blast database***"
	echo "*******$i********"
	cd ../temp/genomes/$i
	makeblastdb -in $i.fna -out ./blast/$i -dbtype nucl -title $i -parse_seqids
	cd ../..
done

