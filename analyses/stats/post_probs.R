#!/usr/bin/env Rscript
source(file="../libs.R")

# read in the topology file
clades <- read.table(file="../../results/clades.csv", header=TRUE, sep=",", stringsAsFactors=FALSE)


# read in trees (change tree file name for others)
trs <- read.nexus(file="../../results/trees/ddRADeco-runsCombined.trees")
trs <- trs[1003:10002]# 9,000 trees for ExaBayes (variable burnin for SNAPP)

# reroot - don't need to run this for snapp
trs <- mclapply(trs, function(x) midpoint(x))
# drop tips - don't need to run this for snapp
trs2 <- mclapply(trs, function(x) drop.tip(x, tip=setdiff(trs[[1]]$tip.label, clades$tip_label)))


# make the dataframe for topo1 - change for other topos
df <- cbind.data.frame(clades$tip_label, clades$topo1)# Callithrix sister to rest
df <- cbind.data.frame(clades$tip_label, clades$topo2)# Saimiri sister to rest
df <- cbind.data.frame(clades$tip_label, clades$topo3)# Aotus sister to rest 
# change colnames
colnames(df) <- c("tip_label", "topology")

# tabulate the results for the taxa
group <- "Ao-Sa" # topo1 - Callithrix sister to rest
group <- "Ao-Ca" # topo2 - Saimiri sister to rest
group <- "Sa-Ca" # topo3 - Aotus sister to rest 

# run the monophyly function and sumarise the results
res <- mclapply(trs2, function(x) AssessMonophyly(x, taxonomy=df))
tt <- table(sapply(res, function(x) x$topology$result$Monophyly[which(rownames(res[[1]]$topology$result) == group)]))
round((tt / length(trs2)), digits=2)

