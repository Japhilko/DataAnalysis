# Webscraping

# install.packages("pollstR")

## Wikipedia

library(wikipediatrend)
library(lattice)

page_views_SG <- wp_trend("Influenza-A-Virus_H1N1",
                          lang="de",from="2008-08-10",
                          to="2015-11-27")
