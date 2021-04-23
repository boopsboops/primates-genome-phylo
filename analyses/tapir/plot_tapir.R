# load up libs and colours
source(file="../libs.R")
source(file="../colours.R")

# plot the tapir results
# https://github.com/faircloth-lab/tapir/wiki/getting-data-from-the-database%28s%29

# to prep, first save the Perelman tree as nwk for tapir
write.tree(ladderize(read.nexus(file="../../results/trees/dated_trees/Perelman_strict.tre")), file="../../results/trees/dated_trees/Perelman_strict.nwk")

# next save the alignments as nex for tapir
write.nexus.data(read.dna(file="../../results/alignments/Exon.gblocks.phy", format="sequential"), file="../../results/alignments/Exon.gblocks.nex", format="dna", interleaved=FALSE, gap="-", missing="n")
write.nexus.data(read.dna(file="../../results/alignments/UCE.gblocks.phy", format="sequential"), file="../../results/alignments/UCE.gblocks.nex", format="dna", interleaved=FALSE, gap="-", missing="n")
write.nexus.data(read.dna(file="../../results/alignments/RAD.gblocks.phy", format="sequential"), file="../../results/alignments/RAD.gblocks.nex", format="dna", interleaved=FALSE, gap="-", missing="n")
write.nexus.data(read.dna(file="../../results/alignments/ddRAD.gblocks.phy", format="sequential"), file="../../results/alignments/ddRAD.gblocks.nex", format="dna", interleaved=FALSE, gap="-", missing="n")
write.nexus.data(read.dna(file="../../results/alignments/perelman_primates_renamed.gblocks.phy", format="sequential"), file="../../results/alignments/perelman_primates_renamed.gblocks.nex", format="dna", interleaved=FALSE, gap="-", missing="n")
write.nexus.data(read.dna(file="../../results/alignments/finstermeier_mtdnas_renamed.gblocks.phy", format="sequential"), file="../../results/alignments/finstermeier_mtdnas_renamed.gblocks.nex", format="dna", interleaved=FALSE, gap="-", missing="n")

# connect to db
drv <- dbDriver("SQLite")
con <- dbConnect(drv, dbname = "../../results/phylogenetic-informativeness.sqlite")# original in '../../temp/tapir_wed'


# create dataframe
pidb <- dbGetQuery(con, "SELECT loci.locus, time, pi FROM loci, net WHERE loci.id = net.id")# AND locus = 'Exon.gblocks'

# rescale the PI to per site rates (make sure to get the order correct in pidb if you remake the sqlite db!)
pi.scaled <- c(    
    (pidb$pi[pidb$locus == "UCE.gblocks.nex"] / 629793), #
    (pidb$pi[pidb$locus == "ddRAD.gblocks.nex"] / 123768), #
    (pidb$pi[pidb$locus == "perelman_primates_renamed.gblocks.nex"] / 31317), #
    (pidb$pi[pidb$locus == "Exon.gblocks.nex"] / 168682), #
    (pidb$pi[pidb$locus == "finstermeier_mtdnas_renamed.gblocks.nex"] / 15059), #
    (pidb$pi[pidb$locus == "RAD.gblocks.nex"] / 1299570), #
    (pidb$pi[pidb$locus == "ddRADeco.gblocks.nex"] / 421037)
)#
pidb2 <- cbind(pidb, pi.scaled)

# rename the datasets to match colours
pidb2$locus <- gsub("RAD.gblocks.nex", "RAD", pidb2$locus)
pidb2$locus <- gsub("Exon.gblocks.nex", "Exon-cap", pidb2$locus)
pidb2$locus <- gsub("UCE.gblocks.nex", "UCE", pidb2$locus)
pidb2$locus <- gsub("ddRAD.gblocks.nex", "ddRAD", pidb2$locus)
pidb2$locus <- gsub("ddRADeco.gblocks.nex", "ddRADeco", pidb2$locus)
pidb2$locus <- gsub("perelman_primates_renamed.gblocks.nex", "Perelman-exon", pidb2$locus)
pidb2$locus <- gsub("finstermeier_mtdnas_renamed.gblocks.nex", "Finstermeier-mtDNA", pidb2$locus)

# plot the data ON A LOG SCALE (using this one in the paper)
ggplot() + #
    geom_point(data=pidb2, aes(x=time, y=log(pi), color=locus), size=3, shape=16, alpha=1) + #
    scale_color_manual(name="", breaks=names(brewtol), values=brewtol) + #
    scale_x_reverse(breaks=pretty_breaks(n=5)) + #
    theme(legend.justification=c(0,0), legend.position=c(0,0)) + #
    labs(x="Time before present (Ma)", y="Log phylogenetic informativeness") + # 
    theme_bw()
#
ggsave(filename="../../manuscript/figures_originals/tapir_log.svg", width=6, height=7)


# plot with rescaled PI
ggplot() + #
    geom_point(data=pidb2, aes(x=time, y=pi.scaled, color=locus), size=3, shape=16, alpha=1) + #
    scale_color_manual(name="", breaks=names(brewtol), values=brewtol) + #
    scale_x_reverse(breaks=pretty_breaks(n=5)) + #
    scale_y_continuous(limits=c(0, 0.0025)) + #
    theme(legend.justification=c(1,1), legend.position=c(1,1)) + #
labs(x="Time before present (Ma)", y="Per site phylogenetic informativeness")
#
ggsave(filename="../../manuscript/figures_originals/tapir_rescale.svg", width=6, height=7)

 
# plot standard (NOT LOG) PI + restrict y axis to see diffs in the similar datasets
ggplot() + #
    geom_point(data=pidb2, aes(x=time, y=pi, color=locus), size=3, shape=16, alpha=1) + #
    scale_color_manual(name="", breaks=names(brewtol), values=brewtol) + #
    scale_x_reverse(breaks=pretty_breaks(n=5)) + #
    theme(legend.justification=c(0,1), legend.position=c(0,1)) + #
    labs(x="Time before present (Ma)", y="Phylogenetic informativeness")
#scale_y_continuous(limits=c(0, 270))
ggsave(filename="../../manuscript/figures_originals/tapir_norm.svg", width=6, height=7)

# multipanel plot
ggplot(pidb2) + #
    geom_point(aes(x=time, y=pi, color=locus), size=3, shape=16, alpha=0.9) + #
    scale_color_manual(name="", breaks=names(brewtol), values=brewtol) + #
    scale_x_reverse(breaks=pretty_breaks(n=5)) + #
    facet_wrap(~locus, scales="free", ncol=2) +
    theme(legend.justification=c(0,0), legend.position=c(0,0)) + #
    labs(x="Time before present (Ma)", y="Log phylogenetic informativeness") + # 
    theme_bw()
ggsave(filename="../../manuscript/figures_originals/tapir_panel.svg", width=12, height=9)



## messing around with the PI profiles
tr <- read.nexus(file="../../results/trees/dated_trees/Perelman_strict.tre")

finmax <- subset(pidb2, locus=="Finstermeier-mtDNA")$time[which(subset(pidb2, locus=="Finstermeier-mtDNA")$pi == max(subset(pidb2, locus=="Finstermeier-mtDNA")$pi))]
permax <- subset(pidb2, locus=="Perelman-exon")$time[which(subset(pidb2, locus=="Perelman-exon")$pi == max(subset(pidb2, locus=="Perelman-exon")$pi))]
radmax <- subset(pidb2, locus=="RAD")$time[which(subset(pidb2, locus=="RAD")$pi == max(subset(pidb2, locus=="RAD")$pi))]
ddmax <- subset(pidb2, locus=="ddRAD")$time[which(subset(pidb2, locus=="ddRAD")$pi == max(subset(pidb2, locus=="ddRAD")$pi))]
ddecomax <- subset(pidb2, locus=="ddRADeco")$time[which(subset(pidb2, locus=="ddRADeco")$pi == max(subset(pidb2, locus=="ddRADeco")$pi))]
ucemax <- subset(pidb2, locus=="UCE")$time[which(subset(pidb2, locus=="UCE")$pi == max(subset(pidb2, locus=="UCE")$pi))]
exonmax <- subset(pidb2, locus=="Exon-cap")$time[which(subset(pidb2, locus=="Exon-cap")$pi == max(subset(pidb2, locus=="Exon-cap")$pi))]

ltt.plot(tr, backward=TRUE, log="y")#
abline(v=(finmax-(2*finmax)), lwd=4, col=brew[which(names(brew)=="Finstermeier-mtDNA")])
abline(v=(permax-(2*permax)), lwd=4, col=brew[which(names(brew)=="Perelman-exon")])
abline(v=(radmax-(2*radmax)), lwd=4, col=brew[which(names(brew)=="RAD")])
abline(v=(ddmax-(2*ddmax)), lwd=4, col=brew[which(names(brew)=="ddRAD")])
abline(v=(ucemax-(2*ucemax)), lwd=4, col=brew[which(names(brew)=="UCE")])
abline(v=(exonmax-(2*exonmax)), lwd=4, col=brew[which(names(brew)=="Exon-cap")])

# difference between root age PI and max PI
pi.decline <- function(db, loc, age) {#
    1 - ((subset(db, locus==loc)$pi[age]) / (max(subset(db, locus==loc)$pi)))
}#
sapply(unique(pidb2$locus), function(x) pi.decline(db=pidb2, loc=x, age=90))
