# set gg cols
gg_color_hue <- function(n) {#
  hues = seq(15, 375, length=n+1)
  hcl(h=hues, l=65, c=100)[1:n]
}#

# ggplot2 cols
brew <- gg_color_hue(6)
names(brew) <- c("Exon-cap", "Perelman-exon", "UCE", "RAD", "ddRAD", "Finstermeier-mtDNA")

# brewpal cols
#brew <- brewer.pal(n=6, name="Set1")
#names(brew) <- c("Exon-cap", "Perelman-exon", "UCE", "RAD", "ddRAD", "Finstermeier-mtDNA")

# reduce to 4 cols (or just brew[1:4])
brew4 <- brew[names(brew) == "Exon-cap" | names(brew) == "UCE" | names(brew) == "RAD" | names(brew) == "ddRAD"]


# using the Paul Tol set of colour blind friendly colours
# https://personal.sron.nl/~pault/

brewtol <- c("#4477AA", "#66CCEE", "#228833", "#CCBB44", "#EE6677", "#AA3377", "#888888")

set.seed(11)
brewtol <- sample(brewtol)



names(brewtol) <- c("Perelman-exon", "Exon-cap", "UCE", "RAD", "ddRAD", "ddRADeco", "Finstermeier-mtDNA")

brewtol5 <- brewtol[names(brewtol) == "Exon-cap" | names(brewtol) == "UCE" | names(brewtol) == "RAD" | names(brewtol) == "ddRAD" | names(brewtol) == "ddRADeco"]

