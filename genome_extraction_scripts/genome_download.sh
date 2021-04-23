#!/usr/bin/env bash
# script to download all primate genomes used in this study
# summary can be found at: http://www.ncbi.nlm.nih.gov/genome/[insert GenBank No.]

# 451 Otolemur garnettii (small-eared galago)
mkdir -p ../temp/genomes/Otolemur_garnettii
wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF_000181295.1_OtoGar3/GCF_000181295.1_OtoGar3_genomic.fna.gz" -O ../temp/genomes/Otolemur_garnettii/Otolemur_garnettii.fna.gz
gzip -d ../temp/genomes/Otolemur_garnettii/Otolemur_garnettii.fna.gz

# 24390 Propithecus coquereli (Coquerel's sifaka)
mkdir -p ../temp/genomes/Propithecus_coquereli
wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF_000956105.1_Pcoq_1.0/GCF_000956105.1_Pcoq_1.0_genomic.fna.gz" -O ../temp/genomes/Propithecus_coquereli/Propithecus_coquereli.fna.gz
gzip -d ../temp/genomes/Propithecus_coquereli/Propithecus_coquereli.fna.gz

# 777 Microcebus murinus (gray mouse lemur)
mkdir -p ../temp/genomes/Microcebus_murinus
wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF_000165445.1_Mmur_2.0/GCF_000165445.1_Mmur_2.0_genomic.fna.gz" -O ../temp/genomes/Microcebus_murinus/Microcebus_murinus.fna.gz
gzip -d ../temp/genomes/Microcebus_murinus/Microcebus_murinus.fna.gz

# 766 Tarsius syrichta (Philippine tarsier)
mkdir -p ../temp/genomes/Tarsius_syrichta
wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF_000164805.1_Tarsius_syrichta-2.0.1/GCF_000164805.1_Tarsius_syrichta-2.0.1_genomic.fna.gz" -O ../temp/genomes/Tarsius_syrichta/Tarsius_syrichta.fna.gz
gzip -d ../temp/genomes/Tarsius_syrichta/Tarsius_syrichta.fna.gz

# 14430 Aotus nancymaae (Ma's night monkey)
mkdir -p ../temp/genomes/Aotus_nancymaae
wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF_000952055.1_Anan_1.0/GCF_000952055.1_Anan_1.0_genomic.fna.gz" -O ../temp/genomes/Aotus_nancymaae/Aotus_nancymaae.fna.gz
gzip -d ../temp/genomes/Aotus_nancymaae/Aotus_nancymaae.fna.gz

# 442 Callithrix jacchus (white-tufted-ear marmoset)
mkdir -p ../temp/genomes/Callithrix_jacchus
wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF_000004665.1_Callithrix_jacchus-3.2/GCF_000004665.1_Callithrix_jacchus-3.2_genomic.fna.gz" -O ../temp/genomes/Callithrix_jacchus/Callithrix_jacchus.fna.gz
gzip -d ../temp/genomes/Callithrix_jacchus/Callithrix_jacchus.fna.gz

# 6907 Saimiri boliviensis boliviensis (Bolivian squirrel monkey)
mkdir -p ../temp/genomes/Saimiri_boliviensis
wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF_000235385.1_SaiBol1.0/GCF_000235385.1_SaiBol1.0_genomic.fna.gz" -O ../temp/genomes/Saimiri_boliviensis/Saimiri_boliviensis.fna.gz
gzip -d ../temp/genomes/Saimiri_boliviensis/Saimiri_boliviensis.fna.gz

# 480 Nomascus leucogenys (northern white-cheeked gibbon)
mkdir -p ../temp/genomes/Nomascus_leucogenys
wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF_000146795.2_Nleu_3.0/GCF_000146795.2_Nleu_3.0_genomic.fna.gz" -O ../temp/genomes/Nomascus_leucogenys/Nomascus_leucogenys.fna.gz
gzip -d ../temp/genomes/Nomascus_leucogenys/Nomascus_leucogenys.fna.gz

# 325 Pongo abelii (Sumatran orangutan)
mkdir -p ../temp/genomes/Pongo_abelii
wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF_000001545.4_P_pygmaeus_2.0.2/GCF_000001545.4_P_pygmaeus_2.0.2_genomic.fna.gz" -O ../temp/genomes/Pongo_abelii/Pongo_abelii.fna.gz
gzip -d ../temp/genomes/Pongo_abelii/Pongo_abelii.fna.gz

# 2156 Gorilla gorilla (western gorilla)
mkdir -p ../temp/genomes/Gorilla_gorilla
wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF_000151905.1_gorGor3.1/GCF_000151905.1_gorGor3.1_genomic.fna.gz" -O ../temp/genomes/Gorilla_gorilla/Gorilla_gorilla.fna.gz
gzip -d ../temp/genomes/Gorilla_gorilla/Gorilla_gorilla.fna.gz

# 51 Homo sapiens (human)
mkdir -p ../temp/genomes/Homo_sapiens
wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF_000001405.31_GRCh38.p5/GCF_000001405.31_GRCh38.p5_genomic.fna.gz" -O ../temp/genomes/Homo_sapiens/Homo_sapiens.fna.gz
gzip -d ../temp/genomes/Homo_sapiens/Homo_sapiens.fna.gz

# 202 Pan troglodytes (chimpanzee)
mkdir -p ../temp/genomes/Pan_troglodytes
wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF_000001515.6_Pan_troglodytes-2.1.4/GCF_000001515.6_Pan_troglodytes-2.1.4_genomic.fna.gz" -O ../temp/genomes/Pan_troglodytes/Pan_troglodytes.fna.gz
gzip -d ../temp/genomes/Pan_troglodytes/Pan_troglodytes.fna.gz

# 10729 Pan paniscus (pygmy chimpanzee)
mkdir -p ../temp/genomes/Pan_paniscus
wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF_000258655.2_panpan1.1/GCF_000258655.2_panpan1.1_genomic.fna.gz" -O ../temp/genomes/Pan_paniscus/Pan_paniscus.fna.gz
gzip -d ../temp/genomes/Pan_paniscus/Pan_paniscus.fna.gz

# 36539 Colobus angolensis (Angolan colobus)
mkdir -p ../temp/genomes/Colobus_angolensis
wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF_000951035.1_Cang.pa_1.0/GCF_000951035.1_Cang.pa_1.0_genomic.fna.gz" -O ../temp/genomes/Colobus_angolensis/Colobus_angolensis.fna.gz
gzip -d ../temp/genomes/Colobus_angolensis/Colobus_angolensis.fna.gz

# 7996 Rhinopithecus roxellana (golden snub-nosed monkey)
mkdir -p ../temp/genomes/Rhinopithecus_roxellana
wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF_000769185.1_Rrox_v1/GCF_000769185.1_Rrox_v1_genomic.fna.gz" -O ../temp/genomes/Rhinopithecus_roxellana/Rhinopithecus_roxellana.fna.gz
gzip -d ../temp/genomes/Rhinopithecus_roxellana/Rhinopithecus_roxellana.fna.gz

# 7994 Nasalis larvatus (proboscis monkey)
mkdir -p ../temp/genomes/Nasalis_larvatus
wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA_000772465.1_Charlie1.0/GCA_000772465.1_Charlie1.0_genomic.fna.gz" -O ../temp/genomes/Nasalis_larvatus/Nasalis_larvatus.fna.gz
gzip -d ../temp/genomes/Nasalis_larvatus/Nasalis_larvatus.fna.gz

# 13136 Chlorocebus sabaeus (green monkey)
mkdir -p ../temp/genomes/Chlorocebus_sabaeus
wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF_000409795.2_Chlorocebus_sabeus_1.1/GCF_000409795.2_Chlorocebus_sabeus_1.1_genomic.fna.gz" -O ../temp/genomes/Chlorocebus_sabaeus/Chlorocebus_sabaeus.fna.gz
gzip -d ../temp/genomes/Chlorocebus_sabaeus/Chlorocebus_sabaeus.fna.gz

# 394 Papio anubis (olive baboon)
mkdir -p ../temp/genomes/Papio_anubis
wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF_000264685.2_Panu_2.0/GCF_000264685.2_Panu_2.0_genomic.fna.gz" -O ../temp/genomes/Papio_anubis/Papio_anubis.fna.gz
gzip -d ../temp/genomes/Papio_anubis/Papio_anubis.fna.gz

# 13303 Cercocebus atys (sooty mangabey)
mkdir -p ../temp/genomes/Cercocebus_atys
wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF_000955945.1_Caty_1.0/GCF_000955945.1_Caty_1.0_genomic.fna.gz" -O ../temp/genomes/Cercocebus_atys/Cercocebus_atys.fna.gz
gzip -d ../temp/genomes/Cercocebus_atys/Cercocebus_atys.fna.gz

# 36538 Mandrillus leucophaeus (drill)
mkdir -p ../temp/genomes/Mandrillus_leucophaeus
wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF_000951045.1_Mleu.le_1.0/GCF_000951045.1_Mleu.le_1.0_genomic.fna.gz" -O ../temp/genomes/Mandrillus_leucophaeus/Mandrillus_leucophaeus.fna.gz
gzip -d ../temp/genomes/Mandrillus_leucophaeus/Mandrillus_leucophaeus.fna.gz

# 13267 Macaca nemestrina (pig-tailed macaque)
mkdir -p ../temp/genomes/Macaca_nemestrina
wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF_000956065.1_Mnem_1.0/GCF_000956065.1_Mnem_1.0_genomic.fna.gz" -O ../temp/genomes/Macaca_nemestrina/Macaca_nemestrina.fna.gz
gzip -d ../temp/genomes/Macaca_nemestrina/Macaca_nemestrina.fna.gz

# 215 Macaca mulatta (Rhesus monkey)
mkdir -p ../temp/genomes/Macaca_mulatta
wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF_000002255.3_Mmul_051212/GCF_000002255.3_Mmul_051212_genomic.fna.gz" -O ../temp/genomes/Macaca_mulatta/Macaca_mulatta.fna.gz
gzip -d ../temp/genomes/Macaca_mulatta/Macaca_mulatta.fna.gz

# 776 Macaca fascicularis (crab-eating macaque)
mkdir -p ../temp/genomes/Macaca_fascicularis
wget "ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF_000364345.1_Macaca_fascicularis_5.0/GCF_000364345.1_Macaca_fascicularis_5.0_genomic.fna.gz" -O ../temp/genomes/Macaca_fascicularis/Macaca_fascicularis.fna.gz
gzip -d ../temp/genomes/Macaca_fascicularis/Macaca_fascicularis.fna.gz
