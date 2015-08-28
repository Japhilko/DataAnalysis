##############################################################
# Datensaetze
# Jan-Philipp Kolb
#
# Schlagwoerter: r-project, 
#
# 07.02.2013
##############################################################

  # In diesem Skript sollen Quellen fuer Datensaetze aufgefuehrt werden


#-----------------------------------------------------------#
# Bibliotheken einladen
#-----------------------------------------------------------##

library(datasets)
library(bindata)

#-----------------------------------------------------------#
# Pfade angeben
#-----------------------------------------------------------##

main.path <- "H:/Forschung/R lernen und lehren/data"

# Quelle 1: http://www.nomisweb.co.uk/census/2011/bulk/r2_2

source.path1 <- paste(main.path,"/ks101ew_2011_oa/KS101EW_2011STATH_NAT_OA_REL_1.1.1",sep="")


#-----------------------------------------------------------#
# Census Open Atlas
#-----------------------------------------------------------##

  # Artikel bei r-bloggers:
  
    # http://www.r-bloggers.com/2011-census-open-atlas-project/


  # Die Grenzen dafuer gibt es unter folgendem Link

    # http://www.ons.gov.uk/ons/guide-method/census/2011/census-data/2011-census-prospectus/new-developments-for-2011-census-results/2011-census-geography/2011-census-geography-prospectus/index.html

setwd(source.path1)

Liste <- dir()
Liste2 <- gsub(".CSV","",Liste)

for (i in 1:length(Liste)){
  eval(parse(text=paste(Liste2[i],"<-read.csv('",Liste[i],"')",sep="")))
}

#-----------------------------------------------------------#
# Daten aus dem Internet laden
#-----------------------------------------------------------##

  # http://www.r-bloggers.com/measuring-user-retention-using-cohort-analysis-with-r/

con = gzcon(url('http://www.systematicportfolio.com/sit.gz', 'rb'))

#-----------------------------------------------------------#
# Daten selbst erzeugen
#-----------------------------------------------------------##

m <- cbind(c(1/2,1/5,1/6),c(1/5,1/2,1/6),c(1/6,1/6,1/2))
rmvbin(10,commonprob=m)



#-----------------------------------------------------------#
# Quellen für Geodaten
#-----------------------------------------------------------##


# http://fa-technik.adfc.de/code/opengeodb/DE.tab

#-----------------------------------------------------------#
# Links
#-----------------------------------------------------------##



  # Ein Panel und wie es verarbeitet wird:

# http://www.r-bloggers.com/psid-data-set-builder-for-r/
