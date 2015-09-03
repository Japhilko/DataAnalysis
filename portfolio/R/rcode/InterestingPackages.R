##############################################################
# Jan-Philipp Kolb
# install most interesting packages - my personal task view
# Thu Jul 30 15:17:25 2015
##############################################################

#------------------------#
# Fundamental things
#------------------------#

  # Packages for data import/export
install.packages("foreign")

  # devtools - for packages from github
install.packages("devtools")

install.packages("source.gist")

library(devtools)

install_github("rfigshare", "ropensci")

update.packages("Cairo")

install.packages("reshape2")


#------------------------#
# Lehren mit R
#------------------------#

install.packages("fBasics")
install.packages("TeachingSampling")
install.packages("datasets")
install.packages("faraway")

install.packages("LearnBayes")
install.packages("TeachingDemos")



#------------------------#
# Graphic Packages
#------------------------#

install.packages("lattice")
install.packages("ggplot2")
install.packages("vcd")        # Visualisation of categorical data
install.packages("beeswarm")   # Alternative for Boxplots
install.packages("plotrix")   # Various plotting functions
install.packages("vioplot")

library(devtools)
install_github('arcdiagram', username='gastonstat')

install.packages("corrgram")

install.packages("PerformanceAnalytics")

install.packages("beanplot")

install.packages("ggparallel")

install.packages("aplpack")

install.packages("gplots")

install.packages("shape")

install.packages("canvas")

install.packages("ggvis")

install.packages("colorRamps")

#------------------------#
# foreign data sets
#------------------------#

install.packages("xlsx")
install.packages("readxl")
install.packages("readstata13")

#------------------------#
# Editing data
#------------------------#

install.packages("dplyr")
install.packages("magrittr")

# dates and times
install.packages("lubridate")

#------------------------#
# Reproducible Research
#------------------------#

install.packages("knitr")

library(devtools)
install_github("cboettig/knitcitations")

install.packages("knitcitations")
install.packages("bibtex")

  # Create LaTeX tables
install.packages("stargazer")
install.packages("xtable")
install.packages("apsrtable")

install.packages("tables")

install.packages("DT")
install.packages("leaflet")

#------------------------#
# Graphical user interfaces (gui)
#------------------------#

install.packages("Rcmdr")
install.packages("JGR")

install.packages("rJava")
install.packages("Deducer")
install.packages("rgl")
install.packages("rattle", repos="http://rattle.togaware.com", type="source")

install.packages("Rz")

# install.packages("ReadImages")

#------------------------#
# Packages for Geography
#------------------------#

install.packages("sp")
install.packages("ggmap")
install.packages("spdep")
install.packages("maptools")
install.packages("rworldmap")
install.packages("rgeos")                 # Interface to Geometry Engine
install.packages("rasterVis")
install.packages("raster")
install.packages("spacetime")
install.packages("PBSmapping")
install.packages("PBSmodelling")
install.packages("GEOmap")
install.packages("geomapdata")
install.packages("geosphere")
install.packages("GeoXp")
install.packages("spcosa")
install.packages("spatstat")
install.packages("geonames")
install.packages("RgoogleMaps")
install.packages("OpenStreetMap")
install.packages("osmar")
install.packages("RPyGeo")
install.packages("MarkedPointProcess")
install.packages("spatgraphs")

install.packages("DCluster")   # spatial clusters of diseases

  # uas R as GIS
install.packages("gdistance")
install.packages("googleVis")


install.packages("shapefiles")

install.packages("rgdal")

install.packages("geoPlot")
install.packages("SoDA")

install.packages("proj4")

install.packages("geocodeHERE")

install.packages("geonames")

install.packages("RDSTK")

install.packages("spgrass6")
install.packages("RSAGA")
install.packages("RArcInfo")
install.packages("geoR")
install.packages("fields")

install.packages("mapdata")

install.packages("gpclib")

install.packages("micromap")
install.packages("micromapST")

install.packages("Grid2Polygons")

devtools::install_github("hrbrmstr/nominatim")

install.packages("rgrass7")

install.packages("choroplethrMaps")
install.packages("choroplethr")

install.packages("mapplots")
install.packages("intamap")

#------------------------#
# Data sources (geographical)
#------------------------#

install.packages("SmarterPoland")

install.packages("rWBclimate")
install.packages("rgbif")

install.packages("oce")

install.packages("Quandl") # https://www.quandl.com/help/r

install.packages("eurostat")

install.packages("GDELTtools")

install.packages("HistData")

#------------------------#
# Packages for samples estimation etc
#------------------------#

install.packages("survey")
install.packages("sampling")

install.packages("samplingVarEst")

install.packages("VGAM")
install.packages("fmsb") # Nagelkerke

  # Hierarchical Models, und Multilevel Models
install.packages("lme4")
install.packages("nlme")
install.packages("arm")
install.packages("hglm")   # Hierarchical Generalized Linear Models
install.packages("influence.ME")   # Tools for detecting influential data in mixed effects models

install.packages("MEMSS")

  # Raking
install.packages("rake")  # Raking
install.packages("anesrake")  #  Raking
install.packages("RankAggreg") # Raking

  # Cohen's D:
install.packages("compute.es")
install.packages("lsr")

#------------------------#
# Regression etc.
#------------------------#

install.packages("MASS")

install.packages("Zelig")
install.packages("phia")
install.packages("dummies")

install.packages("gmodels") # GREG with binary Data


#---------------------------#
# Machine Learning
#---------------------------#

install.packages("homals")
install.packages("lsbclust")

install.packages("SVMMaj")
install.packages("glmnet")

install.packages("smacof")

install.packages("munfold")


install.packages("pls")

install.packages("BiplotGUI")

install.packages("psy")

install.packages("homals")

#------------------------#
# Imputation
#------------------------#

install.packages("Amelia")


#------------------------#
# Use the web with R
#------------------------#

	# Packages fuer internet of things
install.packages("rjson")
install.packages("RCurl")
install.packages("googleVis")
install.packages("plotKML") # isualization of Spatial and Spatio-Temporal Objects in Google Earth
install.packages("lubridate")

install.packages("rplos")   #Interface to PLoS Journals API methods
install.packages("LaF")   # Fast access to large ASCII files
install.packages("rdryad")  # Dryad API interface
install.packages("RXKCD")   # Get XKCD comic from R
install.packages("rgbif") # A programmatic interface to the Web Service methods


install.packages("Rfacebook")

#------------------------#
# Text Mining
#------------------------#

install.packages("wordcloud")
install.packages("tm")    # Text Mining Package

#------------------------#
# Panel-Data
#------------------------#

install.packages("plm")

#------------------------#
# structural equation modelling
#------------------------#

install.packages("semGOF")
install.packages("sem")
# install.packages("OpenMx")

# network analysis

install.packages("igraph")
install.packages("Statnet")


#------------------------#
# Psychological Diagnostic
#------------------------#

install.packages("eRm")      # extended Rasch modeling


install.packages("pwr")

#------------------------#
# linear Algebra
#------------------------#

install.packages("orthopolynom")

 install.packages("pdist")

install.packages("rstiefel")

#------------------------#
# Optimisation Algorithms
#------------------------#

install.packages("DEoptim")
install.packages("GenSA")
install.packages("optimx")
install.packages("subselect")

#------------------------#
# Packages for Distributions
#------------------------#

install.packages("timeDate")
install.packages("lmomco")
install.packages("modeest")



#------------------------#
# Screen Scraping
#------------------------#
install.packages("XML")

install.packages("RSXML")

install.packages("scrapeR")
install.packages("RGoogleAnalytics")
install.packages("rga")

install.packages("grImport")
install.packages("grConvert")

install.packages("rvest")

#------------------------#
# Databases
#------------------------#

install.packages("RPostgreSQL")

install.packages("RMySQL")
install.packages("RSQLite")

install.packages("RNetCDF")
install.packages("DBI")
install.packages("RJDBC")


install.packages("SPARQL")

install.packages("sqldf")

#------------------------#
# Other interesting Packages
#------------------------#

install.packages("bindata")
install.packages("simba")
install.packages("proxy")
install.packages("gregmisc")

  # combinatorics
install.packages("combinat")

install.packages("animation")

install.packages("clusterSim")

install.packages("archivist")

install.packages("rj")

#------------------------#
# Packages for faster or better computation
#------------------------#

install.packages("plyr")
install.packages("reshape")

# Jobs distributed
install.packages("Rmpi")
install.packages("SNOW")
install.packages("nws")
install.packages("Rcpp")
#------------------------#
# image recognition
#------------------------#

install.packages("adimpro")

#------------------------#
# Interfaces
#------------------------#

install.packages("rggobi")  # Interface between R and GGobi

install.packages("translate2R")
install.packages("jsonlite")


install.packages("rJava")
# http://www.rforge.net/JRI/
install.packages("JRI")

  # http://www.r-statistics.com/2012/08/how-to-load-the-rjava-package-after-the-error-java_home-cannot-be-determined-from-the-registry/

Sys.setenv(JAVA_HOME='C:\\Windows.old\\Program Files\\Java\\jre7') # for 64-bit version
Sys.setenv(JAVA_HOME='C:\\Program Files (x86)\\Java\\jre7') # for 32-bit version
library(rJava)

# http://www.omegahat.org/RSPerl/

#------------------------#
# Misc
#------------------------#

install.packages("roxygen2")



#------------------------#
# Links
#------------------------#

   # must have packages für social sciences

# http://www.r-bloggers.com/must-have-r-packages-for-social-scientists/
