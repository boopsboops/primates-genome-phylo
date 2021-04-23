#!/usr/bin/env Rscript

# load table of genome sizes and number of loci in phylogenetic analyses
tab <- read.table(file="../../results/genome_size.csv", header=TRUE, stringsAsFactors=FALSE, sep=",")#

# quick plot
plot(tab$Exon_4 ~ tab$genome_size)

# fit linear models
summary(lm(RAD_4 ~ genome_size, data=tab))
summary(lm(ddRAD_4 ~ genome_size, data=tab))
summary(lm(UCE_4 ~ genome_size, data=tab))
summary(lm(Exon_4 ~ genome_size, data=tab))

#------------------
#------------------
# load table of genome size and number of loci recovered
tab <- read.table(file="../../results/genome_size_loci.csv", header=TRUE, stringsAsFactors=FALSE, sep=",")#

# quick plot
plot(tab$RAD_SbfI ~ tab$genome_size)

# fit linear models
#------------------
# fit 75% GC 8-cutter to SbfI RE to genome size
summary(lm(RAD_SbfI ~ genome_size, data=tab))

# fit 50% GC 4-cutter RE to genome size
summary(lm(ddRAD_Csp6I ~ genome_size, data=tab))
summary(lm(ddRAD_NlaIII ~ genome_size, data=tab))
summary(lm(ddRAD_MboI ~ genome_size, data=tab))
summary(lm(ddRAD_TaqI ~ genome_size, data=tab))

# fit 0% GC 4-cutter RE to genome size
summary(lm(ddRAD_Tru1I ~ genome_size, data=tab))
summary(lm(ddRAD_MluCI ~ genome_size, data=tab))

# fit 100% GC 4-cutter RE to genome size
summary(lm(ddRAD_MspI ~ genome_size, data=tab))

#------------------
# fit 50% GC 4-cutter RE to SbfI data
summary(lm(ddRAD_Csp6I ~ RAD_SbfI, data=tab))
summary(lm(ddRAD_NlaIII ~ RAD_SbfI, data=tab))
summary(lm(ddRAD_MboI ~ RAD_SbfI, data=tab))
summary(lm(ddRAD_TaqI ~ RAD_SbfI, data=tab))

# fit 0% GC 4-cutter RE to SbfI data
summary(lm(ddRAD_Tru1I ~ RAD_SbfI, data=tab))
summary(lm(ddRAD_MluCI ~ RAD_SbfI, data=tab))

# fit 100% GC 4-cutter RE to SbfI data
summary(lm(ddRAD_MspI ~ RAD_SbfI, data=tab))
