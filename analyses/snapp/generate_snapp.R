library(phrynomics)
data(fakeData)
snpdata <- ReadSNP(fakeData)

snps <- ReadSNP("monkey.unlinked_snps.phy")
snps <- RemoveNonBinary(snps)
snps <- RemoveInvariantSites(snps)
snps <- TakeSingleSNPfromEachLocus(snps)$snpdata
snps <- TranslateBases(snps, translateMissingChar="?", ordered=TRUE)
WriteSNP(snps, file="snps.nex", format="nexus", missing="?")
