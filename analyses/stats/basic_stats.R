# load up libs and colours
source(file="../libs.R")
source(file="../colours.R")
# rm(list=ls())

# load up alignments as matrices
dd <- read.dna(file="../../results/alignments/ddRAD.gblocks.phy", format="sequential", as.matrix=TRUE)# was in '../../temp/pyrad_output/ddRAD/outfiles/ddRAD.gblocks.phy'
ddeco <- read.dna(file="../../results/alignments/ddRADeco.gblocks.phy", format="sequential", as.matrix=TRUE)#
exo <- read.dna(file="../../results/alignments/Exon.gblocks.phy", format="sequential", as.matrix=TRUE)
rad <- read.dna(file="../../results/alignments/RAD.gblocks.phy", format="sequential", as.matrix=TRUE)
uce <- read.dna(file="../../results/alignments/UCE.gblocks.phy", format="sequential", as.matrix=TRUE)
per <- read.dna(file="../../results/alignments/perelman_primates_renamed.gblocks.phy", format="sequential", as.matrix=TRUE)
fin <- read.dna(file="../../results/alignments/finstermeier_mtdnas_renamed.gblocks.phy", format="sequential", as.matrix=TRUE)

# run the basic stats command
bstats(data=dd)
bstats(data=ddeco)
bstats(data=exo)
bstats(data=rad)
bstats(data=uce)
bstats(data=per)
bstats(data=fin)

# load the function first
bstats <- function(data){#
    # alignment length
    ddat <- dim(data)[2]
    # num parsimony informative sites
    pisnum <- pis(data, abs=TRUE)
    # proportion parsimony informative sites
    pisprop <- round((pisnum / ddat), digits=3)
    # proportion of missing data (Ns)
    propn <- round((length(grep("n", data)) / length(data)), digits=3)
    # return results
    print(deparse(substitute(data)))
    names(ddat) <- "Alignment length"
    print(ddat)
    names(pisnum) <- "Number parsimony informative sites"
    print(pisnum)
    names(pisprop) <- "Proportion parsimony informative sites"
    print(pisprop)
    names(propn) <- "Proportion of missing data (Ns)"
    print(propn)
}#
