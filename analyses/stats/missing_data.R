# load up libs and colours
source(file="../libs.R")
source(file="../colours.R")
# rm(list=ls())

## Missing taxa per locus (from PyRAD logs)
# load
tab <- read.table(file="../../results/loci.tsv", header=TRUE, sep="\t", stringsAsFactors=TRUE)

# plot
ggplot() + 
    geom_line(data=tab, aes(x=ntaxa, y=log(ntotal), color=dataset), size=1.5) + #
    geom_point(data=tab, aes(x=ntaxa, y=log(ntotal), color=dataset), size=2.5, fill="white", shape=21) + #
    scale_color_manual(name="", breaks=names(brewtol5), values=brewtol5) + #
    labs(x="Number taxa", y="Log number loci") + 
    theme_bw()
#
ggsave(filename="../../manuscript/figures_originals/loci.svg", width=9, height=7)


## Missing data per pairwise taxon set
#  first, need to run these lines in the terminal to format the structure files
# sort -u ddRAD.str > ddRADuniq.str
# sed -i 's/[ ]\+[\t]\+/\t/g' ddRADuniq.str
 
# read structure files (NOTE THE UNDERSCORE FOR THE OLDER, ORIGINAL PYRAD OUTPUTS)
tab <- read.table(file="../../results/pyrad_logs/ddRADecouniq.str", sep="\t", stringsAsFactors=FALSE, row.names=1)
tab <- read.table(file="../../results/pyrad_logs/ddRADuniq.str", sep="\t", stringsAsFactors=FALSE, row.names=1)
tab <- read.table(file="../../results/pyrad_logs/ExonUniq.str", sep="\t", stringsAsFactors=FALSE, row.names=1)
tab <- read.table(file="../../results/pyrad_logs/RADuniq.str", sep="\t", stringsAsFactors=FALSE, row.names=1)
tab <- read.table(file="../../results/pyrad_logs/UCEuniq.str", sep="\t", stringsAsFactors=FALSE, row.names=1)

# check table size
dim(tab)

# read a tree
tr <- read.nexus(file="../../results/trees/chronos_dated_trees/Perelman_strict.tre")

# get patristic distances
pd <- cophenetic(tr)

# get taxa present in each locus
pres <- apply(tab, 2, function(x) row.names(tab)[which(x != -9)])

# get all pairwise combinations of taxa
tt <- combn(row.names(tab), 2, simplify=FALSE)
a <- sapply(tt, function(x) x[[1]])
b <- sapply(tt, function(x) x[[2]])

# run loop to get proportions of missing data for each taxon pair
pm <- list()
for(i in 1:length(tt)){
    tu <- table(sapply(pres, function(x) (a[i] %in% x) & (b[i] %in% x)))
    pm[i] <- as.numeric(tu[names(tu) == FALSE]) / (as.numeric(tu[names(tu) == TRUE]) + as.numeric(tu[names(tu) == FALSE]))
}

# make df
df <- data.frame(cbind(a, b, unlist(pm)), stringsAsFactors=FALSE)
names(df) <- c("tta", "ttb", "prop")
head(df)

# convert matrix of patristic distances  
pdm <- melt(pd)
head(pdm)
# divide by 2 to get age to MRCA
pdm$value <- (pdm$value / 2)

# create concatenated vectors to match
catdf <- paste(df$tta, df$ttb)
catpd <- paste(pdm$Var1, pdm$Var2)

# match the two sets of taxon comparisons
pdmred <- pdm[match(catdf, catpd), ]

# join the two datasets
jdf <- data.frame(cbind(rep("ddRADeco", length(df$prop)), df$prop, pdmred$value), stringsAsFactors=FALSE)
names(jdf) <- c("dataset", "propm", "clage")
head(jdf)

# write out, remembering to change the colnames
write.table(jdf, file="../../results/pairwise_loci.csv", append=TRUE, sep=",", col.names=FALSE, row.names=FALSE)


## plot the data

# open the saved table of pairwise comparisons
tab <- read.table(file="../../results/pairwise_loci.csv", header=TRUE, sep=",", stringsAsFactors=FALSE)

# subset the data for ggplot2 because ggplot because cannot support different linear models for each dataset
exon <- subset(tab, dataset=="Exon-cap")
ddRAD <- subset(tab, dataset=="ddRAD")
ddRADeco <- subset(tab, dataset=="ddRADeco")
RAD <- subset(tab, dataset=="RAD")
UCE <- subset(tab, dataset=="UCE")


# make a manual ggplot because cannot support different linear models for each dataset
ggplot() +
    geom_point(data=exon, aes(y=propm, x=clage, color="Exon-cap"), size=4, shape=16, alpha=0.5) + geom_line(data=exon, aes(y=propm, x=clage, color="Exon-cap"), size=1, se=FALSE, stat="smooth", formula=y~x, method=lm, alpha=1) + #
    geom_point(data=ddRAD, aes(y=propm, x=clage, color="ddRAD"), size=4, shape=16, alpha=0.5) + geom_line(data=ddRAD, aes(y=propm, x=clage, color="ddRAD"), size=1, se=FALSE, stat="smooth", formula=y~log(x), method=lm, alpha=1) + #
    geom_point(data=RAD, aes(y=propm, x=clage, color="RAD"), size=4, shape=16, alpha=0.5) + geom_line(data=RAD, aes(y=propm, x=clage, color="RAD"), size=1, se=FALSE, stat="smooth", formula=y~log(x), method=lm, alpha=1) + #
    geom_point(data=UCE, aes(y=propm, x=clage, color="UCE"), size=4, shape=16, alpha=0.5) + geom_line(data=UCE, aes(y=propm, x=clage, color="UCE"), size=1, se=FALSE, stat="smooth", formula=y~log(x), method=lm, alpha=1) + #
    geom_point(data=ddRADeco, aes(y=propm, x=clage, color="ddRADeco"), size=4, shape=16, alpha=0.5) + geom_line(data=ddRADeco, aes(y=propm, x=clage, color="ddRADeco"), size=1, se=FALSE, stat="smooth", formula=y~log(x), method=lm, alpha=1) + #
    scale_colour_manual(name="", values=brewtol5, breaks=names(brewtol5)) + #
    labs(x="Divergence time (Ma)", y="Proportion missing pairwise loci") + #
    theme_bw()

# save
ggsave(filename="../../manuscript/figures_originals/missing_loci.svg", , width=9, height=9)


## fit models 
# http://blog.yhathq.com/posts/r-lm-summary.html
# AICmin = best model
# delta = AICi - AICmin

# EXON favours linear model (delta = 131.3786, R2 = 0.8858)
exonlm <- lm(propm ~ clage, data=exon)
summary(exonlm)
exonexp <- lm(propm ~ log(clage), data=exon)
summary(exonexp)
extractAIC(exonexp)[2]
extractAIC(exonlm)[2]
min(c(extractAIC(exonexp)[2], extractAIC(exonlm)[2]))#AICmin
extractAIC(exonexp)[2] - extractAIC(exonlm)[2]#delta


# ddRAD favours exp model (delta = 203.2628, R2 = 0.8194)
ddlm <- lm(propm ~ clage, data=ddRAD)
summary(ddlm)
ddexp <- lm(propm ~ log(clage), data=ddRAD)
summary(ddexp)
extractAIC(ddexp)[2]
extractAIC(ddlm)[2]
min(c(extractAIC(ddexp)[2], extractAIC(ddlm)[2]))#AICmin
extractAIC(ddlm)[2] - extractAIC(ddexp)[2]#delta


# RAD favours exp model (delta = 110.5721, R2 = 0.8137)
radlm <- lm(propm ~ clage, data=RAD)
summary(radlm)
radexp <- lm(propm ~ log(clage), data=RAD)
summary(radexp)
extractAIC(radexp)[2]
extractAIC(radlm)[2]
min(c(extractAIC(radexp)[2], extractAIC(radlm)[2]))#AICmin
extractAIC(radlm)[2] - extractAIC(radexp)[2]#delta


# UCE favours exp model (delta = 299.7695, R2 = 0.9452)
ucelm <- lm(propm ~ clage, data=UCE)
summary(ucelm)
uceexp <- lm(propm ~ log(clage), data=UCE)
summary(uceexp)
extractAIC(uceexp)[2]
extractAIC(ucelm)[2]
min(c(extractAIC(uceexp)[2], extractAIC(ucelm)[2]))#AICmin
extractAIC(ucelm)[2] - extractAIC(uceexp)[2]#delta



