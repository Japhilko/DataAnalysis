# http://shiny.rstudio.com/tutorial/lesson5/
main.path <- "C:/Users/kolbjp/Documents/GitHub/DataAnalysis/portfolio/R/"
setwd(main.path)


counties <- readRDS("shinyApps/data/counties.rds")

install.packages(c("maps", "mapproj"))

library(maps)
library(mapproj)
source("shinyApps/helpers.R")
counties <- readRDS("shinyApps/data/counties.rds")
percent_map(counties$white, "darkgreen", "% white")
