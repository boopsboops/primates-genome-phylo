## Calculate uniform distributions from the normal distributions given in Perelman et al. (2011)


# Perelman calibration ROOT (primates)
y <- rnorm(100000, mean=90, sd=6)
plot(density(y))
round(quantile(y, probs = c(0.025, 0.975)), digits=1)
# 78.2,101.8


# Perelman calibration B (Simiiformes)
# MRCA: mandrillus_leucophaeus,callithrix_jacchus
y <- rnorm(100000, mean=43, sd=4.5)
plot(density(y))
round(quantile(y, probs = c(0.025, 0.975)), digits=1)
# 34.2,51.8


# Perelman calibration C (Catarrhini)
# MRCA: homo_sapiens,mandrillus_leucophaeus
y <- rnorm(100000, mean=29, sd=6)
plot(density(y))
round(quantile(y, probs = c(0.025, 0.975)), digits=1)
# 17.2,40.7


# Perelman calibration E (Papionini) *not used by Tomas
# MRCA: macaca_nemestrina,mandrillus_leucophaeus
y <- rnorm(100000, mean=7, sd=1)
plot(density(y))
round(quantile(y, probs = c(0.025, 0.975)), digits=1)
# 5.0,8.9


# Perelman calibration G (Hominidae) *not used by Tomas
# MRCA: pongo_abelii,pan_troglodytes
y <- rnorm(100000, mean=15.5, sd=2.5)
plot(density(y))
round(quantile(y, probs = c(0.025, 0.975)), digits=1)
# 10.6,20.4


# Perelman calibration H (Homo-Pan)
# MRCA: homo_sapiens,pan_troglodytes
y <- rnorm(100000, mean=6.5, sd=0.8)
plot(density(y))
round(quantile(y, probs = c(0.025, 0.975)), digits=1)
# 4.9,8.1
