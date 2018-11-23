################### steps to install base R commander ##############################

# !!!!! for MAC users !!!!
#

# go to this website and install the software

# xquartz.macosforge.org






install.packages("Rcmdr", dependencies=T)


install.packages(c("data.table","haven","readstata13"), dependencies=T)


install.packages("RcmdrMisc", repos="http://R-Forge.R-project.org", dependencies=T)



# steps to install all R commander plugins 


names.available.packages=rownames(available.packages())

Rcmdr.related.packages=names.available.packages[grep("Rcmdr",names.available.packages)]

install.packages(pkgs=Rcmdr.related.packages)







##### loading R commander



library(Rcmdr)
