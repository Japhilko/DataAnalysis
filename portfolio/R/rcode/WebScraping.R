##############################################################
# Jan-Philipp Kolb
# Einlesen von Web-Informationen
# 
# 17.06.2013 - update XML am 04.02.2015
##############################################################

#------------------------#
# Libraries
#------------------------#

install.packages("scrapeR")
library(scrapeR)
library(XML)



doc4=  xmlParse("http://www.r-project.org/mail.html",isHTML=TRUE)

#------------------------#
# Wikipedia content
#------------------------#

Wiki <- paste("http://de.wikipedia.org/wiki/")

Staedte <- c("Mannheim","Ludwigshafen","Speyer")

ags1 <- vector()

for (i in 1:length(Staedte)){
  wiki.url <- paste(Wiki,Staedte[i],sep="")
  zz<-url(paste(wiki.url),'r',blocking=F)
  a<-readLines(zz) 
  close(zz)
  
  wo <- grep("Amtlicher Gemeindeschl",a)
  
  if(length(wo>0)){
    ags <- gsub("<td>","",a[wo+1])
    ags <- gsub("</td>","",ags)
    ags <- gsub(" ","",ags)
    ags1[i] <- ags
  }
  cat(Staedte[i],"\n")
}





#------------------------#
# Facebook Data
#------------------------#


# http://www.r-bloggers.com/analyze-facebook-with-r/
library(Rfacebook)

#------------------------#
# Links
#------------------------#

# http://www.columbia.edu/~cjd11/charles_dimaggio/DIRE/styled-4/styled-6/code-13/

# http://www.r-bloggers.com/web-scraping-in-r/

# http://www.r-bloggers.com/scrape-web-data-using-r/

# http://www.omegahat.org/RSXML/Overview.html

# http://www.omegahat.org/RSXML/shortIntro.pdf

# http://www.omegahat.org/RSXML/Tour.pdf

# http://www.rutgerhoekstra.com/publications/2010_Hoekstra-ten%20Bosch-Harteveld-Automated%20data%20collection.pdf

# https://raw.githubusercontent.com/fredheir/WebScraping/master/Lecture1/p1.Rpres

# http://www.r-bloggers.com/web-scraping-the-basics/

# https://pod.geraspora.de/posts/487cd8401db0013370b44860008dbc6c