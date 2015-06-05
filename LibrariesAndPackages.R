## Libraries and Packages
# To use a library
library(twitteR)
# To see documentation for the library
library(help=twitteR)
# To see R documentation regarding a particular function
?getUser
# Some libraries that come supplied as part of base package of R
# lattice, spatial and survival

# To install a package
install.packages("akima")
install.packages("chron")
install.packages("lme4")
install.packages("mcmc")
install.packages("odesolve")
install.packages("spdep")
install.packages("spatstat")
install.packages("tree")
# To see variables that are presently created
objects()
# To see libraries and dataframes attached
search()
# To run a piece of script from the editor, just select it and press 'Ctrl-R'
# Good housekeeping
x<-3
rm(x)
# Remove everything
rm(list=ls())