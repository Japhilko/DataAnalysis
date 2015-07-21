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

scriptname <- "Regression_A_lineareR.R"
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

library(car)

data(Prestige)

#------------------------------------------------------------#
# Daten anschauen - Histogramme
#------------------------------------------------------------#

  # Ein erster Überblick über die Daten
head(Prestige)

hist(Prestige$income,main="",xlab="Income")

hist(Prestige$income,main="",xlab="Income",breaks=15,
     col="green")


  # Wenn die Dichtelinie noch dazu gezeichnet werden soll:
hist(Prestige$income,main="",xlab="Income",breaks=15,
     col="green",probability=T)
points(density(Prestige$income),type="l",col="red")

#------------------------------------------------------------#
# Daten anschauen - Boxplot
#------------------------------------------------------------#

boxplot(Prestige$income,ylab="Einkommen")


boxplot(Prestige$income~Prestige$type,ylab="Einkommen",
        col="lightblue")

#------------------------------------------------------------#
# Daten anschauen - pairs
#------------------------------------------------------------#

  # Gut um ZUsammenhänge zwischen allen Variablen zu überprüfen:
pairs(Prestige[,1:5])



setwd(graph.path)
png("npReg_pairspanels_Prestige.png")
pairs.panels(Prestige[1:5],
             bg=c("red","yellow","blue")[Prestige$type],
             pch=21,main="") 
dev.off()



#------------------------------------------------------------#
# Erste Beispiele
#------------------------------------------------------------#

data(roller)
?roller




#------------------------------------------------------------#
# Weitere Beispiele
#------------------------------------------------------------#

data(exa)
plot (y ~ x, exa,main="Example A",pch=".")
lines(m ~ x, exa)



data(exb)
plot(y ~ x, exb,main="Example B",pch=".")
lines(m ~ x, exb)
data(faithful)
plot(waiting ~ duration, faithful,main="old Faithful",pch=".")



#------------------------------------------------------------#
# Links
#------------------------------------------------------------#


# http://www.uni-giessen.de/cms/fbz/fb07/fachgebiete/mathematik/mathematik/arbeitsgruppen/stoch/stochpers/eichnerdateien/skriptenfiles/r1sum10.r4win11

# http://www.academia.edu/3282090/Regression_modeling_strategies_with_applications_to_linear_models_logistic_regression_and_survival_analysis