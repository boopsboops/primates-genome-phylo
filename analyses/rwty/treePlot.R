# load up libs and colours
source(file="../libs.R")
source(file="../colours.R")
# rm(list=ls())


## Plotting suppl trees with ggtree

# list the rooted trees - need to root with figtree first, because  ggtree messes up the root
lz <- list.files(path="../../results/trees", pattern="*_rooted.tre")

# read the trees in 
trlist <- lapply(lz, function(x) read.beast(file=paste0("../../results/trees/", x)))

# rename the trees
names(trlist) <- c("ddRADeco", "ddRAD", "Exon-cap", "Finstermeier-mtDNA", "Perelman-exon", "RAD", "UCE")

# correct the names and make pretty
for(i in seq_along(trlist)){
trlist[[i]]@phylo$tip.label <- gsub("larvalus", "larvatus", gsub("mullata", "mulatta", gsub("_", " ", unname(sapply(trlist[[i]]@phylo$tip.label, simpleCap)))))
}

# convert class
class(trlist) <- "multiPhylo"


# multiple trees using facet_wrap -- scaling does not work
#ggtree(trlist, ndigits=2, aes(color=.id)) + #
#    facet_wrap(~.id, scale="free", ncol=2) + theme(strip.background = element_blank()) +#
#    geom_tiplab(size=2, hjust=0) + #
#    geom_text2(aes(label=posterior, subset=!is.na(as.numeric(posterior)) & as.numeric(posterior) < 0.99), hjust=-.2) + #
#    geom_point2(aes(subset=!is.na(as.numeric(posterior)) & as.numeric(posterior) >= 0.99), size=2) + #
#    geom_treescale(x=0,y=25, color="grey35", fontsize=3) + 
#    scale_color_manual(values=brewtol) 


# better plots with ggtree multiplot
pdf(file="~/test.pdf",  width=12, height=24)
multiplot(
    ggtree(trlist[["ddRADeco"]],ndigits=2,color=brewtol["ddRADeco"],size=1.1)+
        geom_tiplab(label=paste0('italic("',trlist[["ddRADeco"]]@phylo$tip.label,'")'),parse=TRUE,hjust=-0.05)+
        geom_text2(aes(label=posterior, subset=!is.na(as.numeric(posterior)) & as.numeric(posterior) < 0.99), hjust=-.2)+
        geom_point2(aes(subset=!is.na(as.numeric(posterior)) & as.numeric(posterior) >= 0.99), size=2, color=brewtol["ddRADeco"])+
        xlim(NA,0.09)+
        geom_treescale(x=0,y=11, color=brewtol["ddRADeco"],fontsize=3), #
    ggtree(trlist[["ddRAD"]],ndigits=2,color=brewtol["ddRAD"],size=1.1)+
        geom_tiplab(label=paste0('italic("',trlist[["ddRAD"]]@phylo$tip.label,'")'),parse=TRUE,hjust=-0.05)+
        geom_text2(aes(label=posterior, subset=!is.na(as.numeric(posterior)) & as.numeric(posterior) < 0.99), hjust=-.2)+
        geom_point2(aes(subset=!is.na(as.numeric(posterior)) & as.numeric(posterior) >= 0.99), size=2, color=brewtol["ddRAD"])+
        xlim(NA,0.09)+
        geom_treescale(x=0,y=11, color=brewtol["ddRAD"], fontsize=3), #
    ggtree(trlist[["Exon-cap"]],ndigits=2,color=brewtol["Exon-cap"],size=1.1)+
        geom_tiplab(label=paste0('italic("',trlist[["Exon-cap"]]@phylo$tip.label,'")'),parse=TRUE,hjust=-0.05)+
        geom_text2(aes(label=posterior, subset=!is.na(as.numeric(posterior)) & as.numeric(posterior) < 0.99), hjust=-.2)+
        geom_point2(aes(subset=!is.na(as.numeric(posterior)) & as.numeric(posterior) >= 0.99), size=2, color=brewtol["Exon-cap"])+
        xlim(NA,0.07)+
        geom_treescale(x=0,y=11, color=brewtol["Exon-cap"], fontsize=3), #    
    ggtree(trlist[["Finstermeier-mtDNA"]],ndigits=2,color=brewtol["Finstermeier-mtDNA"],size=1.1)+
        geom_tiplab(label=paste0('italic("',trlist[["Finstermeier-mtDNA"]]@phylo$tip.label,'")'),parse=TRUE,hjust=-0.05)+
        geom_text2(aes(label=posterior, subset=!is.na(as.numeric(posterior)) & as.numeric(posterior) < 0.99), hjust=-.2)+
        geom_point2(aes(subset=!is.na(as.numeric(posterior)) & as.numeric(posterior) >= 0.99), size=2, color=brewtol["Finstermeier-mtDNA"])+
        xlim(NA,1)+
        geom_treescale(x=0,y=11, color=brewtol["Finstermeier-mtDNA"], fontsize=3), #    
    ggtree(trlist[["Perelman-exon"]],ndigits=2,color=brewtol["Perelman-exon"],size=1.1)+
        geom_tiplab(label=paste0('italic("',trlist[["Perelman-exon"]]@phylo$tip.label,'")'),parse=TRUE,hjust=-0.05)+
        geom_text2(aes(label=posterior, subset=!is.na(as.numeric(posterior)) & as.numeric(posterior) < 0.99), hjust=-.2)+
        geom_point2(aes(subset=!is.na(as.numeric(posterior)) & as.numeric(posterior) >= 0.99), size=2, color=brewtol["Perelman-exon"])+
        xlim(NA,0.1)+
        geom_treescale(x=0,y=11, color=brewtol["Perelman-exon"], fontsize=3), #    
    ggtree(trlist[["RAD"]],ndigits=2,color=brewtol["RAD"],size=1.1)+
        geom_tiplab(label=paste0('italic("',trlist[["RAD"]]@phylo$tip.label,'")'),parse=TRUE,hjust=-0.05)+
        geom_text2(aes(label=posterior, subset=!is.na(as.numeric(posterior)) & as.numeric(posterior) < 0.99), hjust=-.2)+
        geom_point2(aes(subset=!is.na(as.numeric(posterior)) & as.numeric(posterior) >= 0.99), size=2, color=brewtol["RAD"])+
        xlim(NA,0.1)+
        geom_treescale(x=0,y=11, color=brewtol["RAD"], fontsize=3), #      
    ggtree(trlist[["UCE"]],ndigits=2,color=brewtol["UCE"],size=1.1)+
        geom_tiplab(label=paste0('italic("',trlist[["UCE"]]@phylo$tip.label,'")'),parse=TRUE,hjust=-0.05)+
        geom_text2(aes(label=posterior, subset=!is.na(as.numeric(posterior)) & as.numeric(posterior) < 0.99), hjust=-.2)+
        geom_point2(aes(subset=!is.na(as.numeric(posterior)) & as.numeric(posterior) >= 0.99), size=2, color=brewtol["UCE"])+
        xlim(NA,0.04)+
        geom_treescale(x=0,y=11, color=brewtol["UCE"], fontsize=3), #            
    ncol=2, labels=names(trlist))
dev.off()



## OLD
 
# correct spelling mistake and caps in the taxon names (load function below first)
# function to make first letter capital
simpleCap <- function(x) {#
    s <- strsplit(x, " ")[[1]]
    paste(toupper(substring(s, 1, 1)), substring(s, 2),
          sep = "", collapse = " ")
}#

# read MCC trees
tr <- read.nexus(file="../../results/trees/Exon-runsCombined.tre")
tr <- read.nexus(file="../../results/trees/UCE-runsCombined.tre")
tr <- read.nexus(file="../../results/trees/RAD-runsCombined.tre")
tr <- read.nexus(file="../../results/trees/ddRAD-runsCombined.tre")
tr <- read.nexus(file="../../results/trees/Perelman-runsCombined.tre")
tr <- read.nexus(file="../../results/trees/Finstermeier-runsCombined.tre")
# read posterior sample
trs <- read.nexus(file="../../results/trees/Exon-runsCombined.trees")
trs <- read.nexus(file="../../results/trees/UCE-runsCombined.trees")
trs <- read.nexus(file="../../results/trees/RAD-runsCombined.trees")
trs <- read.nexus(file="../../results/trees/ddRAD-runsCombined.trees")
trs <- read.nexus(file="../../results/trees/Perelman-runsCombined.trees")
trs <- read.nexus(file="../../results/trees/Finstermeier-runsCombined.trees")

# reroot MCC tree
rtr <- reroot(tr, node.number=fastMRCA(tr, "otolemur_garnettii","propithecus_coquereli"), position=0.5*tr$edge.length[which(tr$edge[,2]==fastMRCA(tr, "otolemur_garnettii","propithecus_coquereli"))])
# reroot posterior sample
trs <- trs[1003:10002]# remove burnin
rtrs <- mclapply(trs, function(x) reroot(x, node.number=fastMRCA(x, "otolemur_garnettii","propithecus_coquereli"), position=0.5*x$edge.length[which(x$edge[,2]==fastMRCA(x, "otolemur_garnettii","propithecus_coquereli"))]))
# get posterior probs
pp <- prop.part(rtrs, check.labels=TRUE)
rtr$nodelabels <- round((prop.clades(rtr, part=pp, rooted=TRUE)/9000), digits=2)
# ladderize tree
ltr <- ladderize(rtr)

# rotate the bottom clade if required
#ltr <- rotate(ltr, node=fastMRCA(ltr, "Cercocebus_atys", "Macaca_nemestrina"))

# spellings
ltr$tip.label <- unlist(lapply(ltr$tip.label, simpleCap))
ltr$tip.label <- gsub("mullata", "mulatta", ltr$tip.label)
ltr$tip.label <- gsub("larvalus", "larvatus", ltr$tip.label)


# select col
ccol <- brew[names(brew) == "ddRAD"]

# create coloured node labels
bpp <- character(length(ltr$nodelabels))
bpp[ltr$nodelabels >= 0.99] <- ccol
bpp[ltr$nodelabels < 0.99] <- "white"

# create a text vector for 
txt <- as.character(ltr$nodelabels)
txt <- gsub("1|0.99", "", txt)

# plot
pdf(file="../../manuscript/ddRAD_tre.pdf", width=6, height=6, useDingbats=FALSE, useKerning=FALSE)
plot.phylo(ltr, no.margin=TRUE, font=3, edge.width=2.5, edge.color=ccol, label.offset=0.00025, cex=0.75, tip.color="gray20")# label.offset needs to be bigger for mtDNA
nodelabels(cex=1, pch=21, bg=bpp[-1], frame="none", col=ccol, node=unique(ltr$edge[,1])[2]:unique(ltr$edge[,1])[length(unique(ltr$edge[,1]))])# = nodes 25:45
nodelabels(text=txt[-1], frame="none", cex=0.7, adj=c(-0.25,0.5), col=ccol, node=unique(ltr$edge[,1])[2]:unique(ltr$edge[,1])[length(unique(ltr$edge[,1]))])
add.scale.bar(length=0.01, lcol=ccol, cex=0.7, lwd=2)
dev.off()
#


# to col by family
# load up families
#fams <- read.table("/home/rupert/families.csv", header=TRUE, stringsAsFactors=FALSE, sep=",")
#famcols <- character(length(fams$Species))
#for (i in 1:length(unique(fams$Family))){#
#    famcols[which(fams$Family == unique(fams$Family)[i])] <- brew[i]
#}

## plotting the time tree with nodes ##

# read the tree and ladderize
mcc <- read.beast(file="../../results/trees/dated_trees/Perelman_strict.tre")
lmcc <- ladderize(mcc)

# read in the calibration table
tab <- read.table(file="../../results/trees/calibrations.csv", header=TRUE, sep=",", stringsAsFactors=FALSE)

# get the node numbers for the nodes of interest
tax.rad <- c(#
    getMRCA(lmcc, c("tarsius_syrichta", "macaca_mullata")),# Haplorrhini
    getMRCA(lmcc, c("aotus_nancymaae", "callithrix_jacchus", "saimiri_boliviensis")),# Cebidae
    getMRCA(lmcc, c("nomascus_leucogenys", "pan_paniscus")),# Hominoidea
    getMRCA(lmcc, c("gorilla_gorilla", "pan_paniscus")),# Homininae
    getMRCA(lmcc, c("colobus_angolensis", "macaca_mullata")),# Cercopithecidae
    getMRCA(lmcc, c("colobus_angolensis", "rhinopithecus_roxellana")),# Colobinae
    getMRCA(lmcc, c("chlorocebus_sabaeus", "macaca_mullata")),# Cercopithecinae
    getMRCA(lmcc, c("macaca_nemestrina", "macaca_mullata"))# Macaca
)#

# name these nodes
gr <- c(#
    "Haplorrhini",
    "Cebidae",
    "Hominoidea",
    "Homininae",
    "Cercopithecidae",
    "Colobinae",
    "Cercopithecinae",
    "Macaca"
)#

# get the numbers of the calibrated nodes
cnod <- c(fastMRCA(lmcc, tab$tax1[1], tab$tax2[1]), fastMRCA(lmcc, tab$tax1[2], tab$tax2[2]), fastMRCA(lmcc, tab$tax1[3], tab$tax2[3]), fastMRCA(lmcc, tab$tax1[4], tab$tax2[4]), fastMRCA(lmcc, tab$tax1[5], tab$tax2[5]), fastMRCA(lmcc, tab$tax1[6], tab$tax2[6]))

# fix up the tree labels
lmcc$tip.label <- unlist(lapply(lmcc$tip.label, simpleCap))
lmcc$tip.label <- gsub("mullata", "mulatta", lmcc$tip.label)
lmcc$tip.label <- gsub("larvalus", "larvatus", lmcc$tip.label)

# to set plotting limits
plot(lmcc, edge.color=0, tip.color=0)
HPDbars(lmcc, col="skyblue", lwd=7)

# grab some nicer colours (I chose more than I needed to get the ones I wanted)
brewp <- brewer.pal(n=6, name="Set2")

# to plot the tree
pdf(file="../../temp/exemplar_tre.pdf", width=15, height=10, useDingbats=FALSE)
plot(lmcc, edge.color=0, tip.color=0, x.lim=c(-10.90649, 149.22679))
HPDbars(lmcc, col=brewp[5], lwd=12)
HPDbars(lmcc, col=brewp[2], lwd=12, nodes=cnod)
plot.phylo.upon(lmcc, cex=1.2, edge.width=2, no.margin=TRUE, font=3, label.offset=0.5, edge.col="gray30", tip.color="grey50")
nodelabels(pch=21, node=tax.rad, bg="white", cex=2, col="gray30")
nodelabels(text=gr, node=tax.rad, adj=c(1.05,-0.75), frame="none", col="gray30", cex=0.9)
data(strat2012)
axisGeo(GTS=strat2012, unit="epoch", col=brewp[6], texcol="gray30", ages=TRUE, cex=1, gridty=3, gridcol="gray50")
dev.off()
#