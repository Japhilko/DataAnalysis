##############################################################
# Nichtlineare Regression
# Jan-Philipp Kolb
# 21.03.2014
#
# Einführung - lineare Regression
#
##############################################################

#------------------------------------------------------------#
# Generelle Information
#------------------------------------------------------------#

options(scipen=10)

scriptname <- "Regression_B_lineareR.R"
author <- "Jan-Philipp Kolb"

#------------------------------------------------------------#
# Pfade angeben
#------------------------------------------------------------#

main.path <- "J:/Work/Statistik/Kolb/Workshops/2014/WorkshopRegression"

graph.path <- paste(main.path,"/Folien/figure",sep="")


#------------------------------------------------------------#
# Bibliotheken
#------------------------------------------------------------#

# DAAG package

library(DAAG)

#------------------------------------------------------------#
# Datensatz
#------------------------------------------------------------#

data(roller)
?roller

head(roller)

#------------------------------------------------------------#
# Erste Regressionsmodelle
#------------------------------------------------------------#

roller.lm <- lm(depression ~ weight, data = roller)


summary(roller.lm)

roller.lm2 <- lm(depression ~ -1 + weight, data = roller)

summary(roller.lm2)

#------------------------------------------------------------#
# Dummies 
#------------------------------------------------------------#

DumW <- rep(0,length(roller$weight))

DumW[roller$weight>6] <- 1

table(DumW)

#------------------------------------------------------------#
# Interaktionen
#------------------------------------------------------------#

data(Prestige)

head(Prestige)

  # keine Interaktionen
lm.mod1 <- lm(income~education + women,data=Prestige)
summary(lm.mod1)

lm.mod2 <- lm(income~education:women,data=Prestige)
summary(lm.mod2)

lm.mod3 <- lm(income~education*women,data=Prestige)
summary(lm.mod3)

lm.mod4 <- lm(income~education/women,data=Prestige)
summary(lm.mod4)

lm.mod5 <- lm(income~(education+women)^2,data=Prestige)
summary(lm.mod5)

lm.mod6 <- lm(income~education*women-
                education:women,data=Prestige)
summary(lm.mod6)


#------------------------------------------------------------#
# Links
#------------------------------------------------------------#


# http://www.uni-giessen.de/cms/fbz/fb07/fachgebiete/mathematik/mathematik/arbeitsgruppen/stoch/stochpers/eichnerdateien/skriptenfiles/r1sum10.r4win11

# http://www.academia.edu/3282090/Regression_modeling_strategies_with_applications_to_linear_models_logistic_regression_and_survival_analysis