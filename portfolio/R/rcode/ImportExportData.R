#------------------------------------------------------------#
# How to import and export data
# Jan-Philipp Kolb
# 02.04.2012 - Update 31.01.2013
#------------------------------------------------------------#

#------------------------#
# Libraries
#------------------------#

library(foreign)

  # Fuer Datensaetze aus R
library(lmomco)

#------------------------#
# Define paths
#------------------------#

main <- "D:/consensusdaten/Data"

main.path <- "H:/Forschung/R lernen und lehren/data"

path1 <- "J:/Work/Statistik/Kolb"

#------------------------#
# In general
#------------------------#

setwd("C:/")


setwd(path1)

  # all files in the directory
Namen <- dir()

  # all files in workspace
ls()

#------------------------#
# .txt-files
#------------------------#

ab <- read.table("D:/consensusdaten/consensus.gesamt.txt",header=T,sep=" ")

ab <- read.table(paste(main,"consensus.gesamt.txt",sep=""),header=T,sep=" ")

#------------------------#
# .sav-files
#------------------------#

  # save SPSS files

Dat2 <- runif(100)

datafile<-tempfile()
SP_StrRS_2<-tempfile()

write.foreign(Dat2, datafile="SP_StrRS_2.sav", codefile=SP_StrRS_2, package = "SPSS")


setwd(main.path)
Dat <- read.spss("Dat2.sav")


Dat <- read.spss("Dat2.sav",to.data.frame=T)


#------------------------#
# read .dta-files
#------------------------#

  # Stata files

write.dta(Dat2, "Dat1.dta")


Dat <- read.dta("Dat1.dta")

  # http://is-r.tumblr.com/post/37181850668/reading-writing-stata-dta-files-with-foreign

#---------------------------------------------#
# save and read .RData 
#---------------------------------------------#

setwd(main.path)

save(Dat2,file="Dat2.RData")


load("Dat2.RData")

#---------------------------------------------#
# Datensaetze aus R
#---------------------------------------------#

data(amarilloprecip)
head(amarilloprecip)

#------------------------#
# Skripte aus dem Internet
#------------------------#

download.file("http://osmar.r-forge.r-project.org/fossgis2012.R","fossgis2012.R")

edit(file = "fossgis2012.R")

  # Das funktioniert auch mit .RData
download.file("http://osmar.r-forge.r-project.org/fossgis2012.RData","fossgis2012.RData")
load("fossgis2012.RData")


#------------------------#
# Datensaetze aus dem Internet
#------------------------#


link <- "http://www.gesis.org/"
zz <- url(link)
a<-readLines(zz) 
close(zz)

#------------------------#
# .zip Dateien
#------------------------#

  # so kann man gezipte Dateien entpacken:

setwd(main.path)

unzip("ks101ew_2011_ward.zip")


#------------------------#
# Datensaetze aus dem Internet
#------------------------#


setwd(path1)

ab <- readLines("HEALTHIN.DAT")

segnum    <- substr(ab,11,12)
psutype   <- substr(ab,185,185)
psupseud  <- substr(ab,187,189)
stratum   <- substr(ab,179,181)
subtype   <- substr(ab,178,178)
wtfa      <- substr(ab,219,227)
nacute    <- substr(ab,118,119)
weight    <- substr(ab,95,97)
height    <- substr(ab,93,94)
ncond     <- substr(ab,116,117)

nhis<- data.frame(segnum=as.numeric(as.character(segnum)),
                  psutype=as.numeric(as.character(psutype)),psupseud=as.numeric(as.character(psupseud)),stratum=as.numeric(as.character(stratum)),
                  subtype=as.numeric(as.character(subtype))   ,wtfa=as.numeric(as.character(wtfa)),weight=as.numeric(as.character(weight)),
                  height=as.numeric(as.character(height))    ,ncond=as.numeric(as.character(ncond)))

nhis$selfrep <- ifelse(nhis$psutype=="1",1,0)
nhis$zero <- rep(0,nrow(nhis))
twostage <- svydesign(id= ~psupseud + segnum,strata= ~stratum + subtype,weight= ~wtfa,data=nhis,fpc=~selfrep+zero)

nhis$cstratum <- nhis$psupseud %/% 10
nhis$cpsu <- nhis$psupseud%%10


save(nhis,file="nhis.RData")



#------------------------#
# S3 Binary oder data.dump File einladen
#------------------------#


read.S("__1")
data.restore("dumpdata", print = TRUE)

#------------------------#
# Google Dokumente lesen
#------------------------#



?readGoogleCSV

#------------------------#
# Weitere nuetzliche Befehle
#------------------------#



  # Wenn nur ein Teil dieser Dateien benoetigt wird, koennen folgende Befehle verwendet werden:

?split

  # Falls ein deutsches Excelfile vorliegt, in dem mit , getrennt wird kann folgendes angewendet werden:

pov05 <- c("0,7","0,5")    
pov05 <- gsub(",",".",pov05)
pov05 <- as.numeric(pov05)


#------------------------#
# Links
#------------------------#

  # http://cran.r-project.org/doc/manuals/r-devel/R-data.html

  # http://www.statmethods.net/input/exportingdata.html

