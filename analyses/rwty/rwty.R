# load up libs and colours
source(file="../libs.R")
source(file="../colours.R")
# rm(list=ls())

## load up the tree and log files for the beast runs
# need to place a copy or symlink of all the .trees and .log files into 'primates-genome-phylo/temp'
ttrs <- load.multi(path="../../results/trees/exabayes_output", ext.tree="t", ext.p="p")
ttrs <- load.multi(path="../../results/trees/exabayes_output", format="mb")# new rwty
# take just the first run for each dataset
ttrs1 <- ttrs[grep("run1", names(ttrs))]

## plot
# treespace plot with no branch length info (RF symmetric distance; Robinson & Foulds, 1981)
p <- makeplot.treespace(ttrs1, n.points=500, burnin=501, likelihood="LnL")
p <- makeplot.treespace(ttrs1, n.points=500, burnin=501)# new rwty

p$points.plot

ggsave(filename="../../manuscript/figures_originals/treespace.svg", width=9, height=10)
# need to edit colours in inkscape

# treespace plot with branch length info (branch score distance; Kuhner & Felsenstein, 1994)  --- not used
# load up Rphylip
#require("Rphylip")
# need to first install phylip with 'sudo apt-get install phylip'
# load up the modified RWTY script
#source("treespace_brlens.R")

#p <- makeplot.treespace.brlens(ttrs, n.points=500, burnin=501, likelihood="LnL")
#p$points.plot
