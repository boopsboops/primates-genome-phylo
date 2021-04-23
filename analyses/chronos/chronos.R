# load up libs and colours
source(file="../libs.R")
source(file="../colours.R")
# rm(list=ls())

## to prep the trees and run chronos

# read posterior tree samples from ExaBayes analyses
trs <- read.nexus(file="../../results/trees/Exon-runsCombined.trees")
trs <- read.nexus(file="../../results/trees/UCE-runsCombined.trees")
trs <- read.nexus(file="../../results/trees/RAD-runsCombined.trees")
trs <- read.nexus(file="../../results/trees/ddRAD-runsCombined.trees")
trs <- read.nexus(file="../../results/trees/ddRADeco-runsCombined.trees")
trs <- read.nexus(file="../../results/trees/Perelman-runsCombined.trees")
trs <- read.nexus(file="../../results/trees/Finstermeier-runsCombined.trees")

# remove burnin  (or sample 1000 trees)
trsam <- trs[1003:10002]#sample(trs[1003:10002], 1000)

# read in the calibration table
tab <- read.table(file="../../results/trees/calibrations.csv", header=TRUE, sep=",", stringsAsFactors=FALSE)

# root all the trees
rtrsam <- mclapply(trsam, function(x) phytools::reroot(x, node.number=fastMRCA(x, "otolemur_garnettii","propithecus_coquereli"), position=0.5*x$edge.length[which(x$edge[,2]==fastMRCA(x, "otolemur_garnettii","propithecus_coquereli"))]))

# get node calibration data
cmin <- tab$min
cmax <- tab$max
cnod <- mclapply(rtrsam, function(x) c(fastMRCA(x, tab$tax1[1], tab$tax2[1]), fastMRCA(x, tab$tax1[2], tab$tax2[2]), fastMRCA(x, tab$tax1[3], tab$tax2[3]), fastMRCA(x, tab$tax1[4], tab$tax2[4]), fastMRCA(x, tab$tax1[5], tab$tax2[5]), fastMRCA(x, tab$tax1[6], tab$tax2[6])))


# loop to create the node calibration data frames for chrono
ccal <- list()
for (i in 1:length(rtrsam)){#
    ccal[[i]] <- makeChronosCalib(rtrsam[[i]], node=cnod[[i]], age.min=cmin, age.max=cmax, soft.bounds=TRUE)
}#


# loop to run chronos CORRELATED PL over the trees
#chr <- list()
#for (i in 1:length(rtrsam)){#
#    chr[[i]] <- chronos(rtrsam[[i]], model="correlated", calibration=ccal[[i]], lambda=100)
#}#

# loop to run chronos RELAXED over the trees
chr <- list()
for (i in 1:length(rtrsam)){#
    chr[[i]] <- chronos(rtrsam[[i]], model="relaxed", calibration=ccal[[i]])
}#

# loop to run chronos STRICT over the trees
chr <- list()
for (i in 1:length(rtrsam)){#
    chr[[i]] <- chronos(rtrsam[[i]], model="discrete", control=chronos.control(nb.rate.cat=1), calibration=ccal[[i]])
}#

# change list of trees to multiphylo and write out
class(chr) <- "multiPhylo"
writeNexus(tree=chr, file="../../temp/exon_relaxed.nex")
writeNexus(tree=chr, file="../../temp/exon_strict.nex")
#
writeNexus(tree=chr, file="../../temp/uce_relaxed.nex")
writeNexus(tree=chr, file="../../temp/uce_strict.nex")
#
writeNexus(tree=chr, file="../../temp/rad_relaxed.nex")
writeNexus(tree=chr, file="../../temp/rad_strict.nex")
#
writeNexus(tree=chr, file="../../temp/ddrad_relaxed.nex")
writeNexus(tree=chr, file="../../temp/ddrad_strict.nex")
#
writeNexus(tree=chr, file="../../temp/perelman_relaxed.nex")
writeNexus(tree=chr, file="../../temp/perelman_strict.nex")
#
writeNexus(tree=chr, file="../../temp/finstermeier_relaxed.nex")
writeNexus(tree=chr, file="../../temp/finstermeier_strict.nex")
#
writeNexus(tree=chr, file="../../temp/ddradeco_relaxed.nex")
writeNexus(tree=chr, file="../../temp/ddradeco_strict.nex")


## read the trees back in after summarising trees
# run 'treeannotator -burninTrees 0 -heights mean finstermeier_relaxed.nex finstermeier_relaxed.tre'
# relaxed clock trees
mcc.exon <- phyloch::read.beast(file="../../results/trees/chronos_dated_trees/Exon_relaxed.tre")
mcc.uce <- phyloch::read.beast(file="../../results/trees/chronos_dated_trees/UCE_relaxed.tre")
mcc.rad <- phyloch::read.beast(file="../../results/trees/chronos_dated_trees/RAD_relaxed.tre")
mcc.dd <- phyloch::read.beast(file="../../results/trees/chronos_dated_trees/ddRAD_relaxed.tre")
mcc.perel <- phyloch::read.beast(file="../../results/trees/chronos_dated_trees/Perelman_relaxed.tre")
mcc.finster <- phyloch::read.beast(file="../../results/trees/chronos_dated_trees/Finstermeier_relaxed.tre")
mcc.ddeco <- phyloch::read.beast(file="../../results/trees/chronos_dated_trees/ddRADeco_relaxed.tre")

# for strict trees
mcc.exon <- phyloch::read.beast(file="../../results/trees/chronos_dated_trees/Exon_strict.tre")
mcc.uce <- phyloch::read.beast(file="../../results/trees/chronos_dated_trees/UCE_strict.tre")
mcc.rad <- phyloch::read.beast(file="../../results/trees/chronos_dated_trees/RAD_strict.tre")
mcc.dd <- phyloch::read.beast(file="../../results/trees/chronos_dated_trees/ddRAD_strict.tre")
mcc.perel <- phyloch::read.beast(file="../../results/trees/chronos_dated_trees/Perelman_strict.tre")
mcc.finster <- phyloch::read.beast(file="../../results/trees/chronos_dated_trees/Finstermeier_strict.tre")
mcc.ddeco <- phyloch::read.beast(file="../../results/trees/chronos_dated_trees/ddRADeco_strict.tre")

# the beast ones
mcc.exon <- phyloch::read.beast(file="../../results/trees/beast_runs/Exon_comb.tre")
mcc.uce <- phyloch::read.beast(file="../../results/trees/beast_runs/UCE_comb.tre")
mcc.rad <- phyloch::read.beast(file="../../results/trees/beast_runs/RAD_comb.tre")
mcc.dd <- phyloch::read.beast(file="../../results/trees/beast_runs/ddRAD_comb.tre")
mcc.ddeco <- phyloch::read.beast(file="../../results/trees/beast_runs/ddRADeco_comb.tre")
mcc.perel <- phyloch::read.beast(file="../../results/trees/beast_runs/perelman_comb.tre")
mcc.finster <- phyloch::read.beast(file="../../results/trees/beast_runs/finstermeier_comb.tre")


# get MRCAs for node numbers
tax.exon <- c(#
    getMRCA(mcc.exon, c("tarsius_syrichta", "macaca_mullata")),# Haplorrhini
    getMRCA(mcc.exon, c("aotus_nancymaae", "callithrix_jacchus", "saimiri_boliviensis")),# Cebidae
    getMRCA(mcc.exon, c("nomascus_leucogenys", "pan_paniscus")),# Hominoidea
    getMRCA(mcc.exon, c("gorilla_gorilla", "pan_paniscus")),# Homininae
    getMRCA(mcc.exon, c("colobus_angolensis", "macaca_mullata")),# Cercopithecidae
    getMRCA(mcc.exon, c("colobus_angolensis", "rhinopithecus_roxellana")),# Colobinae
    getMRCA(mcc.exon, c("chlorocebus_sabaeus", "macaca_mullata")),# Cercopithecinae
    getMRCA(mcc.exon, c("macaca_nemestrina", "macaca_mullata"))# Macaca
)#

tax.uce <- c(#
    getMRCA(mcc.uce, c("tarsius_syrichta", "macaca_mullata")),# Haplorrhini
    getMRCA(mcc.uce, c("aotus_nancymaae", "callithrix_jacchus", "saimiri_boliviensis")),# Cebidae
    getMRCA(mcc.uce, c("nomascus_leucogenys", "pan_paniscus")),# Hominoidea
    getMRCA(mcc.uce, c("gorilla_gorilla", "pan_paniscus")),# Homininae
    getMRCA(mcc.uce, c("colobus_angolensis", "macaca_mullata")),# Cercopithecidae
    getMRCA(mcc.uce, c("colobus_angolensis", "rhinopithecus_roxellana")),# Colobinae
    getMRCA(mcc.uce, c("chlorocebus_sabaeus", "macaca_mullata")),# Cercopithecinae
    getMRCA(mcc.uce, c("macaca_nemestrina", "macaca_mullata"))# Macaca
)#

tax.rad <- c(#
    getMRCA(mcc.rad, c("tarsius_syrichta", "macaca_mullata")),# Haplorrhini
    getMRCA(mcc.rad, c("aotus_nancymaae", "callithrix_jacchus", "saimiri_boliviensis")),# Cebidae
    getMRCA(mcc.rad, c("nomascus_leucogenys", "pan_paniscus")),# Hominoidea
    getMRCA(mcc.rad, c("gorilla_gorilla", "pan_paniscus")),# Homininae
    getMRCA(mcc.rad, c("colobus_angolensis", "macaca_mullata")),# Cercopithecidae
    getMRCA(mcc.rad, c("colobus_angolensis", "rhinopithecus_roxellana")),# Colobinae
    getMRCA(mcc.rad, c("chlorocebus_sabaeus", "macaca_mullata")),# Cercopithecinae
    getMRCA(mcc.rad, c("macaca_nemestrina", "macaca_mullata"))# Macaca
)#

tax.dd <- c(#
    getMRCA(mcc.dd, c("tarsius_syrichta", "macaca_mullata")),# Haplorrhini
    getMRCA(mcc.dd, c("aotus_nancymaae", "callithrix_jacchus", "saimiri_boliviensis")),# Cebidae
    getMRCA(mcc.dd, c("nomascus_leucogenys", "pan_paniscus")),# Hominoidea
    getMRCA(mcc.dd, c("gorilla_gorilla", "pan_paniscus")),# Homininae
    getMRCA(mcc.dd, c("colobus_angolensis", "macaca_mullata")),# Cercopithecidae
    getMRCA(mcc.dd, c("colobus_angolensis", "rhinopithecus_roxellana")),# Colobinae
    getMRCA(mcc.dd, c("chlorocebus_sabaeus", "macaca_mullata")),# Cercopithecinae
    getMRCA(mcc.dd, c("macaca_nemestrina", "macaca_mullata"))# Macaca
)#

tax.ddeco <- c(#
    getMRCA(mcc.ddeco, c("tarsius_syrichta", "macaca_mullata")),# Haplorrhini
    getMRCA(mcc.ddeco, c("aotus_nancymaae", "callithrix_jacchus", "saimiri_boliviensis")),# Cebidae
    getMRCA(mcc.ddeco, c("nomascus_leucogenys", "pan_paniscus")),# Hominoidea
    getMRCA(mcc.ddeco, c("gorilla_gorilla", "pan_paniscus")),# Homininae
    getMRCA(mcc.ddeco, c("colobus_angolensis", "macaca_mullata")),# Cercopithecidae
    getMRCA(mcc.ddeco, c("colobus_angolensis", "rhinopithecus_roxellana")),# Colobinae
    getMRCA(mcc.ddeco, c("chlorocebus_sabaeus", "macaca_mullata")),# Cercopithecinae
    getMRCA(mcc.ddeco, c("macaca_nemestrina", "macaca_mullata"))# Macaca
)#

tax.perel <- c(#
    getMRCA(mcc.perel, c("tarsius_syrichta", "macaca_mullata")),# Haplorrhini
    getMRCA(mcc.perel, c("aotus_nancymaae", "callithrix_jacchus", "saimiri_boliviensis")),# Cebidae
    getMRCA(mcc.perel, c("nomascus_leucogenys", "pan_paniscus")),# Hominoidea
    getMRCA(mcc.perel, c("gorilla_gorilla", "pan_paniscus")),# Homininae
    getMRCA(mcc.perel, c("colobus_angolensis", "macaca_mullata")),# Cercopithecidae
    getMRCA(mcc.perel, c("colobus_angolensis", "rhinopithecus_roxellana")),# Colobinae
    getMRCA(mcc.perel, c("chlorocebus_sabaeus", "macaca_mullata")),# Cercopithecinae
    getMRCA(mcc.perel, c("macaca_nemestrina", "macaca_mullata"))# Macaca
)#

tax.finster <- c(#
    getMRCA(mcc.finster, c("tarsius_syrichta", "macaca_mullata")),# Haplorrhini
    getMRCA(mcc.finster, c("aotus_nancymaae", "callithrix_jacchus", "saimiri_boliviensis")),# Cebidae
    getMRCA(mcc.finster, c("nomascus_leucogenys", "pan_paniscus")),# Hominoidea
    getMRCA(mcc.finster, c("gorilla_gorilla", "pan_paniscus")),# Homininae
    getMRCA(mcc.finster, c("colobus_angolensis", "macaca_mullata")),# Cercopithecidae
    getMRCA(mcc.finster, c("colobus_angolensis", "rhinopithecus_roxellana")),# Colobinae
    getMRCA(mcc.finster, c("chlorocebus_sabaeus", "macaca_mullata")),# Cercopithecinae
    getMRCA(mcc.finster, c("macaca_nemestrina", "macaca_mullata"))# Macaca
)#

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

# create a dataframe for the exon data
df.exon <- data.frame(cbind(unique(mcc.exon$edge[,1]), round(mcc.exon$"height_95%_HPD_MIN", digits=2), round(mcc.exon$"height_95%_HPD_MAX", digits=2), round(mcc.exon$"height", digits=2)))
df.exon <- df.exon[match(tax.exon, df.exon$X1), ]
df.exon <- cbind(rep("Exon-cap", length(gr)), gr, df.exon)
names(df.exon) <- c("dataset", "clade", "node", "hpd_min", "hpd_max", "mean")

# create a dataframe for the perelman data
df.perel <- data.frame(cbind(unique(mcc.perel$edge[,1]), round(mcc.perel$"height_95%_HPD_MIN", digits=2), round(mcc.perel$"height_95%_HPD_MAX", digits=2), round(mcc.perel$"height", digits=2)))
df.perel <- df.perel[match(tax.perel, df.perel$X1), ]
df.perel <- cbind(rep("Perelman-exon", length(gr)), gr, df.perel)
names(df.perel) <- c("dataset", "clade", "node", "hpd_min", "hpd_max", "mean")

# create a dataframe for the uce data
df.uce <- data.frame(cbind(unique(mcc.uce$edge[,1]), round(mcc.uce$"height_95%_HPD_MIN", digits=2), round(mcc.uce$"height_95%_HPD_MAX", digits=2), round(mcc.uce$"height", digits=2)))
df.uce <- df.uce[match(tax.uce, df.uce$X1), ]
df.uce <- cbind(rep("UCE", length(gr)), gr, df.uce)
names(df.uce) <- c("dataset", "clade", "node", "hpd_min", "hpd_max", "mean")

# create a dataframe for the rad data
df.rad <- data.frame(cbind(unique(mcc.rad$edge[,1]), round(mcc.rad$"height_95%_HPD_MIN", digits=2), round(mcc.rad$"height_95%_HPD_MAX", digits=2), round(mcc.rad$"height", digits=2)))
df.rad <- df.rad[match(tax.rad, df.rad$X1), ]
df.rad <- cbind(rep("RAD", length(gr)), gr, df.rad)
names(df.rad) <- c("dataset", "clade", "node", "hpd_min", "hpd_max", "mean")

# create a dataframe for the ddrad data
df.dd <- data.frame(cbind(unique(mcc.dd$edge[,1]), round(mcc.dd$"height_95%_HPD_MIN", digits=2), round(mcc.dd$"height_95%_HPD_MAX", digits=2), round(mcc.dd$"height", digits=2)))
df.dd <- df.dd[match(tax.dd, df.dd$X1), ]
df.dd <- cbind(rep("ddRAD", length(gr)), gr, df.dd)
names(df.dd) <- c("dataset", "clade", "node", "hpd_min", "hpd_max", "mean")

# create a dataframe for the ddrad2 data
df.ddeco <- data.frame(cbind(unique(mcc.ddeco$edge[,1]), round(mcc.ddeco$"height_95%_HPD_MIN", digits=2), round(mcc.ddeco$"height_95%_HPD_MAX", digits=2), round(mcc.ddeco$"height", digits=2)))
df.ddeco <- df.ddeco[match(tax.ddeco, df.ddeco$X1), ]
df.ddeco <- cbind(rep("ddRADeco", length(gr)), gr, df.ddeco)
names(df.ddeco) <- c("dataset", "clade", "node", "hpd_min", "hpd_max", "mean")

# create a dataframe for the finstermeier data
df.finster <- data.frame(cbind(unique(mcc.finster$edge[,1]), round(mcc.finster$"height_95%_HPD_MIN", digits=2), round(mcc.finster$"height_95%_HPD_MAX", digits=2), round(mcc.finster$"height", digits=2)))
df.finster <- df.finster[match(tax.finster, df.finster$X1), ]
df.finster <- cbind(rep("Finstermeier-mtDNA", length(gr)), gr, df.finster)
names(df.finster) <- c("dataset", "clade", "node", "hpd_min", "hpd_max", "mean")

# make data frame
df <- rbind(df.perel, df.exon, df.uce, df.rad, df.dd, df.ddeco, df.finster)#, df.perel.rel, df.perel.str
df

# plot on same
df.beast <- df
df.strict <- df
rm(df)
#df.beast$method <- rep("beast", length(df.beast$dataset))
#df.strict$method <- rep("strict", length(df.strict$dataset))
#df.both <- rbind(df.beast, df.strict)


# plot
ggplot(data=df) + 
    geom_point(aes(x=reorder(clade, -mean), y=mean, color=dataset), size=3.9, position=position_dodge(width=0.8)) + #
    geom_linerange(data=df, aes(x=clade, ymin=hpd_min, ymax=hpd_max, color=dataset), size=2, position=position_dodge(width=0.8)) + #
    #scale_y_continuous(breaks=pretty_breaks(n=10), limits=c(0,110)) + #
    #scale_colour_ptol() +
    scale_color_manual(name="", breaks=names(brewtol), values=brewtol) + #
    labs(x="Clade of interest", y="Clade age (Ma)") + theme_bw()

    
ggplot() + 
    geom_point(data=df.beast, aes(x=reorder(clade, -mean), y=mean, color=dataset), size=3.9, position=position_dodge(width=0.8)) + #
    geom_linerange(data=df.beast, aes(x=clade, ymin=hpd_min, ymax=hpd_max, color=dataset), size=2, position=position_dodge(width=0.8)) + #
    geom_point(data=df.strict, aes(x=reorder(clade, -mean), y=mean, group=dataset), size=3, position=position_dodge(width=0.8), alpha=1, shape=18, color="grey30") + #
    geom_linerange(data=df.strict, aes(x=clade, ymin=hpd_min, ymax=hpd_max, group=dataset), size=0.75, position=position_dodge(width=0.8), alpha=1, color="grey30") + #
    scale_y_continuous(breaks=pretty_breaks(n=5), limits=c(0,120)) + #	
    scale_color_manual(name="", breaks=names(brewtol), values=brewtol) + #
    labs(x="Clade of interest", y="Clade age (Ma)") + theme_bw()
    
#
ggsave(filename="../../manuscript/figures_originals/combined_dates.svg", width=14, height=8)
ggsave(filename="../../manuscript/figures_originals/relaxed_dates.svg", width=14, height=8)
ggsave(filename="../../manuscript/figures_originals/strict_dates.svg", width=14, height=8)
ggsave(filename="../../manuscript/figures_originals/beast_dates.svg", width=14, height=8)


## compare clock models
# read MCC trees (with PHI-AIC results)
tr <- read.nexus(file="../../results/trees/Exon-runsCombined.tre")#[1] 137.5307 85.4353 134.6590 (delta 52.1) \\ rate = 0.27--0.28
tr <- read.nexus(file="../../results/trees/UCE-runsCombined.tre")#[1] 136.72374 84.33679 133.85849 (delta 52.4) \\ rate = 0.17--0.17
tr <- read.nexus(file="../../results/trees/RAD-runsCombined.tre")#[1] 138.78361  87.15799 135.94516 (delta 51.6) \\ rate = 0.42--0.43
tr <- read.nexus(file="../../results/trees/ddRAD-runsCombined.tre")#[1] 138.4980  86.7435 135.6492 (delta 51.8) \\ rate = 0.37--0.40
tr <- read.nexus(file="../../results/trees/ddRADeco-runsCombined.tre")# [1] 138.44202  86.69545 135.60609 (delta 51.7) \\ rate = 0.37--0.39
tr <- read.nexus(file="../../results/trees/Perelman-runsCombined.tre")#[1] 138.35021  86.53124 135.43313 (delta 51.8) \\ rate = 0.37--0.40
tr <- read.nexus(file="../../results/trees/Finstermeier-runsCombined.tre")# [1] 157.2551  118.0095 154.7411 (delta 39.2) \\ rate = 4.47--4.79

# get evol rate
ff <- as.numeric(unlist(lapply(rtrsam, function(x) sum(x$edge.length))))
class(ff) <- "mcmc"
round(HPDinterval(ff, prob=0.95), digits=2)
round(mean(ff), digits=3)

# root and make calibs
rtr <- phytools::reroot(tr, node.number=fastMRCA(tr, "otolemur_garnettii","propithecus_coquereli"), position=0.5*tr$edge.length[which(tr$edge[,2]==fastMRCA(tr, "otolemur_garnettii","propithecus_coquereli"))])
cmin <- tab$min
cmax <- tab$max
cnod <- c(fastMRCA(rtr, tab$tax1[1], tab$tax2[1]), fastMRCA(rtr, tab$tax1[2], tab$tax2[2]), fastMRCA(rtr, tab$tax1[3], tab$tax2[3]), fastMRCA(rtr, tab$tax1[4], tab$tax2[4]), fastMRCA(rtr, tab$tax1[5], tab$tax2[5]), fastMRCA(rtr, tab$tax1[6], tab$tax2[6]))
ccal <- makeChronosCalib(rtr, node=cnod, age.min=cmin, age.max=cmax, soft.bounds=TRUE)

# models
rel <- chronos(rtr, model="relaxed", calibration=ccal)
str <- chronos(rtr, model="discrete", chronos.control(nb.rate.cat=1), calibration=ccal)
corr <- chronos(rtr, model="correlated", lambda=100, calibration=ccal)
c((attr(rel, "PHIIC")$PHIIC), (attr(str, "PHIIC")$PHIIC), (attr(corr, "PHIIC")$PHIIC))

# get delta
(attr(rel, "PHIIC")$PHIIC) - (attr(str, "PHIIC")$PHIIC)

# get likelihood ratio of clock model
2*(attr(rel, "PHIIC")$logLik - attr(str, "PHIIC")$logLik)


### look at correlations between HPDs and dataset variables

# make the min max of the HPDs
df.beast$diffs <- df.beast$hpd_max - df.beast$hpd_min
subset(x=df.beast, clade=="Haplorrhini")

# read in the variables table
tab <-read.table(file="../../results/dating_correlation.csv",  header=TRUE, stringsAsFactors=FALSE, sep=",")

# run all the linear regressions
# on the HPD width
summary(lm(Age_diffs ~ Num_loci, data=tab))
summary(lm(Age_diffs ~ Num_sites, data=tab))
summary(lm(Age_diffs ~ Num_parsim, data=tab))
summary(lm(Age_diffs ~ Prop_parsim, data=tab))
summary(lm(Age_diffs ~ Prop_missing_data, data=tab))
summary(lm(Age_diffs ~ Peak_PI, data=tab))
summary(lm(Age_diffs ~ Alpha, data=tab))
summary(lm(Age_diffs ~ GC, data=tab))
summary(lm(Age_diffs ~ Clocklikeness, data=tab))
summary(lm(Age_diffs ~ Num_trees, data=tab))
summary(lm(Age_diffs ~ Rate_exa, data=tab))
summary(lm(Age_diffs ~ Rate_beast, data=tab))
summary(lm(Age_diffs ~ CoV_mean, data=tab))
# on the age
summary(lm(Age_means ~ Num_loci, data=tab))
summary(lm(Age_means ~ Num_sites, data=tab))
summary(lm(Age_means ~ Num_parsim, data=tab))
summary(lm(Age_means ~ Prop_parsim, data=tab))
summary(lm(Age_means ~ Prop_missing_data, data=tab))
summary(lm(Age_means ~ Peak_PI, data=tab))
summary(lm(Age_means ~ Alpha, data=tab))
summary(lm(Age_means ~ GC, data=tab))
summary(lm(Age_means ~ Clocklikeness, data=tab))
summary(lm(Age_means ~ Num_trees, data=tab))
summary(lm(Age_means ~ Rate_exa, data=tab))
summary(lm(Age_means ~ Rate_beast, data=tab))
summary(lm(Age_means ~ CoV_mean, data=tab))

# check normality etc
mod <- lm(Age_diffs ~ Peak_PI, data=tab)
par(mfrow = c(2, 2))
plot(mod)
plot(tab$Age_diffs ~ tab$Peak_PI)

