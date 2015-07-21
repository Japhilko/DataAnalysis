##############################################################
# Nichtlineare Regression
# Jan-Philipp Kolb
# 21.03.2014
#
# Parametrische Verfahren
#
##############################################################

# Polynomiale Regression

#------------------------------------------------------------#
# Generelle Information
#------------------------------------------------------------#

options(scipen=10)

scriptname <- "Regression_C_Parametrisch.R"
author <- "Jan-Philipp Kolb"


#------------------------------------------------------------#
# Bibliotheken
#------------------------------------------------------------#

library(stargazer)

library(car) # für Datensätze


library(faraway)
library(MASS)

#------------------------------------------------------------#
# Pfade angeben
#------------------------------------------------------------#

main.path <- "J:/Work/Statistik/Kolb/Workshops/2014/WorkshopRegression"

graph.path <- paste(main.path,"/Folien/figure",sep="")


#------------------------------------------------------------#
# Variablentransformation
#------------------------------------------------------------#

# Variable kann zentriert werden



#------------------------------------------------------------#
# Log-Transformation
#------------------------------------------------------------#

  # http://ww2.coastal.edu/kingw/statistics/R-tutorials/simplenonlinear.html


  # Dampfdruck von Quecksilber als Funktion der Temperatur
data(pressure)
?pressure
str(pressure)
summary(pressure)


setwd(graph.path)
png("npReg_plot_Pressure1.png")
par(mai=c(1.2,1.2,0,0))
plot(pressure~temperature,data=pressure,type="b",pch=20,lwd=3,cex=2,
     col="darkorchid4",xlab=list("Temperatur",cex=3),
     ylab=list("Druck",cex=3),cex.axis=2)
dev.off()

  # Der Druck steigt mit zunehmender Temperatur

mod1 <- lm(pressure~temperature,data=pressure)


setwd(graph.path)
png("npReg_plot_PressurePred.png")
par(mai=c(1.2,1.2,0,0))
plot(pressure~temperature,data=pressure,type="b",pch=20,lwd=3,cex=2,
     col="darkorchid4",xlab=list("Temperatur",cex=3),
     ylab=list("Druck",cex=3),cex.axis=2)
abline(mod1,col="red", lwd=2)
dev.off()

  # Die eingezeichnete Regressionslinie zeigt keinen guten Fit

  # Der Zusammenhang scheint eher exponential zu sein

  # => Logarithmieren



pressure$temperature = pressure$temperature + 273.15
pressure$pressure = pressure$pressure * .1333
summary(pressure) 

pres = pressure$pressure
temp = pressure$temperature


#####
# Erste Gedanken zu Log-Transformationen

setwd(graph.path)
png("npReg_plot_Pressure.png")
par(mfrow=c(1,4))                    # vier Graphen nebeneinander
plot(pres ~ temp, main="Vapor Pressure\n of Mercury",
     xlab="Temperature (degrees Kelvin)",
     ylab="Pressure (kPascals)")
plot(pres ~ temp, main="Vapor Pressure\nof Mercury",
     xlab="Temperature (degrees Kelvin)",
     ylab="Pressure (kPascals)", log="y")
plot(pres ~ temp, main="Vapor Pressure\nof Mercury",
     xlab="Temperature (degrees Kelvin)",
     ylab="Pressure (kPascals)", log="xy")
plot(pres ~ temp, main="Vapor Pressure\nof Mercury",
     xlab="Temperature (degrees Kelvin)",
     ylab="Pressure (kPascals)", log="x")
dev.off()

par(mfrow=c(1,2))                    # one row of two graphs
lm.out1 = lm(log(pres) ~ temp)       # the exponential model
lm.out1

plot(lm.out1$fitted, lm.out1$resid)  # evaluated via a residual plot

lm.out2 = lm(log(pres) ~ log(temp))  # the power model
lm.out2

plot(lm.out2$fitted, lm.out2$resid)  # evaluated via a residual plot

#------------------------------------------------------------#
# Polynomiale Regression
#------------------------------------------------------------#

# Bevölkerung einer italienischen Stadt

Year <- c(1959, 1960, 1961, 1962, 1963, 1964, 1965, 1966, 1967, 1968, 1969)
Population <- c(4835, 4970, 5085, 5160, 5310, 5260, 5235, 5255, 5235, 5210, 5175)

sample1 <- data.frame(Year, Population)

sample1$Year <- sample1$Year - 1964


#####
# Erste Graphik


setwd(graph.path)

png("Regr_plot_JahrBev.png")
plot(sample1$Year, sample1$Population, type="b",
     xlab="Jahr",ylab="Bevölkerung")
dev.off()


#####
# Das lineare Modell

fit1 <- with(sample1,lm(Population ~ Year))

summary(fit1)

  # Die Variable Year ist auf einem Signifikanzniveau von 0.01 signifikant


setwd(graph.path)

png("npReg_plot_JahrBevFit.png")
  par(mai=c(1.2,1.2,0,0))
  plot(sample1$Year, sample1$Population, type="l", lwd=3,
     xlab="Jahr",ylab="Bevölkerung")
  points(sample1$Year, predict(fit1), type="l", col="chocolate1", lwd=2)
dev.off()




png("npReg_plot_JahrBevResid.png")
  par(mai=c(1.2,1.2,0,0))
  plot(fit1,which=1)
dev.off()


png("npReg_plot_JahrBevResid2.png")
  par(mai=c(1.2,1.2,0,0))
  plot(fit1,which=1,lwd=3,cex=3,pch=20,axes=F)
dev.off()

#####
# Weitere mögliche Modelle

fit2 <- with(sample1,lm(Population ~ Year + I(Year^2)))
fit3 <- with(sample1,lm(Population ~ Year + I(Year^2) + I(Year^3)))


fit2b <- lm(sample1$Population ~ poly(sample1$Year, 2, raw=TRUE))
fit3b <- lm(sample1$Population ~ poly(sample1$Year, 3, raw=TRUE))


#####
# Analyse der drei verschiedenen Modelle

summary(fit2)

stargazer(fit2)

## or summary(fit2b)

summary(fit3)

#####
# Warum überhaupt polynomiale Modelle

  # Bevölkerung einer chinesischen Stadt

Year2 <- c(1959, 1960, 1961, 1962, 1963, 1964, 1965, 1966, 1967, 1968, 1969)
Population2 <- c(4835, 4970, 5085, 5160, 5310, 5460, 5535, 5655, 5735, 5810, 5975)

sample2 <- data.frame(Year2, Population2)
sample2$Year <- sample2$Year2 - 1964


# Die Bevölkerung in der chinesischen Stadt steigt ständig an

plot(sample2$Year, sample2$Population2, type="b",
     xlab="Jahr",ylab="Bevölkerung",col="green")

fitB2 <- with(sample2,lm(Population2 ~ Year + I(Year^2)))


# zeichnet die Regressionsterme gegen die Prädiktoren


setwd(graph.path)

png("npReg_termplot_JahrBevFit.png")
termplot(fit2,partial=T,terms=2)
dev.off()

# Bei der chinesischen Stadt zeigt sich kein glockenförmiger Verlauf

# => Abweichung vom linearen Modell

# => BLUE-Annahme einer linearen Beziehung zwischen Variablen ist verletzt

# => hier muss man nicht mit polynomen arbeiten

termplot(fitB2,partial=T,terms=2)

# bei glockenförmigen Zusammenhang
# unabhängige Variable zweimal in Regressionsmodell aufnehmen


#####
# Modellvergleich mittels Anova



anova(fit2, fit3)




#####
# Graphik mit Fit



setwd(graph.path)

png("Regr_plot_JahrBevFit.png")
plot(sample1$Year, sample1$Population, type="l", lwd=3,
     xlab="Jahr",ylab="Bevölkerung")
points(sample1$Year, predict(fit2), type="l", col="red", lwd=2)

dev.off()


png("Regr_plot_JahrBevFit2.png")
plot(sample1$Year, sample1$Population, type="l", lwd=3,
     xlab="Jahr",ylab="Bevölkerung")
points(sample1$Year, predict(fit2), type="l", col="red", lwd=2)
points(sample1$Year, predict(fit3), type="l", col="blue", lwd=2)
dev.off()



pol2 <- function(x) fit2$coefficient[3]*x^2 + fit2$coefficient[2]*x + fit2$coefficient[1]


plot(sample1$Year, sample1$Population, type="p", lwd=3)
pol2 <- function(x) fit2$coefficient[3]*x^2 + fit2$coefficient[2]*x + fit2$coefficient[1]
curve(pol2, col="red", lwd=2)


points(sample1$Year, sample1$Population, type="p", lwd=3)


plot(sample1$Year, sample1$Population, type="p", lwd=3)
pol2 <- function(x) fit2$coefficient[3]*x^2 + fit2$coefficient[2]*x + fit2$coefficient[1]
curve(pol2, col="red", lwd=2)
points(sample1$Year, sample1$Population, type="p", lwd=3)


plot(sample1$Year, sample1$Population, type="p", lwd=3)
pol3 <- function(x) fit3$coefficient[4]*x^3 + fit3$coefficient[3]*x^2 + fit3$coefficient[2]*x + fit3$coefficient[1]
curve(pol3, col="red", lwd=2)
points(sample1$Year, sample1$Population, type="p", lwd=3)




#------------------------------------------------------------#
# Aufgabe - Polynomiale Regression
#------------------------------------------------------------#


  # Quelle: http://www.maths.bath.ac.uk/~jjf23/ELM/scripts/introlm.R

data(gavote)

 # Undercounted votes in Georgia in 2000 presidential election

?gavote

barplot(gavote$ballots-gavote$votes,col="royalblue")

gavote$undercount <- (gavote$ballots-gavote$votes)/gavote$ballots
gavote$pergore <- gavote$gore/gavote$votes
gavote$cpergore <- gavote$pergore - mean(gavote$pergore)
gavote$cperAA <- gavote$perAA - mean(gavote$perAA)

plmodi <- lm(undercount ~ poly(cperAA,4)+cpergore*rural+equip, gavote)

plot(pergore ~ perAA, gavote, xlab="Proportion African American",ylab="Proportion for Gore")

termplot(plmodi,partial=TRUE,terms=1)





#------------------------------------------------------------#
# Weiteres Beispiel
#------------------------------------------------------------#

  # http://www.r-bloggers.com/some-heuristics-about-local-regression-and-kernel-smoothing/


#####
# Beispieldaten


n <- 10
set.seed(1)
xr = seq(0,n,by=.1)
yr = sin(xr/2)+rnorm(length(xr))/2
db = data.frame(x=xr,y=yr)


setwd(graph.path)

png("npReg_plot_db.png")
  plot(db)
dev.off()

  # die Regressionslinie einzeichnen

png("npReg_plot_dbReg.png")
plot(db)
reg = lm(y ~ x,data=db)
abline(reg,col="red")
dev.off()

  # Im Vergleich dazu die polynomiale Regression
  # wenn der Grad hoch genug gewählt ist, kann jede Form der Daten angenähert werden


preg5=lm(y~poly(x,5),data=db)


png("npReg_plot_dbPReg.png")
plot(db)
reg = lm(y ~ x,data=db)
abline(reg,col="red")
lines(xr,predict(preg5),col="green")
dev.off()


plot(db)
lines(xr,predict(reg),col="red",lty=2)
yrm=yr
yrm[31]=yr[31]-2 
regm=lm(yrm~poly(xr,25)) 
lines(xr,predict(regm),col="red")

#####
# lokale Regression


reg=lm(yr~xr,subset=which(abs(xr-x0)<1))

#####
# Eine Funktion definieren


fitloc0 = function(x0){
  w=dnorm((xr-x0))
  reg=lm(y~1,data=db,weights=w)
  return(predict(reg,newdata=data.frame(x=x0)))
}

#####
# Die entsprechende Graphik dazu:


ul=seq(0,10,by=.01)
vl0=Vectorize(fitloc0)(ul)
u0=seq(-2,7,by=.01)
linearlocalconst=function(x0){
  w=dnorm((xr-x0))
  plot(db,cex=abs(w)*4)
  lines(ul,vl0,col="red")
  axis(3)
  axis(2)
  reg=lm(y~1,data=db,weights=w)
  u=seq(0,10,by=.02)
  v=predict(reg,newdata=data.frame(x=u))
  lines(u,v,col="red",lwd=2)
  abline(v=c(0,x0,10),lty=2)
}
linearlocalconst(2)
       
       
#------------------------------------------------------------#
# Weitere Beispiele
#------------------------------------------------------------#


# In R integrierter Beispieldatensatz
data("CPS1985")

head(CPS1985)


hist(CPS1985$wage)
hist(CPS1985$wage,breaks=100)
hist(CPS1985$wage,breaks=50,col="royalblue")

# Dichte plotten
plot(density(CPS1985$wage),col="red")

# Transformation der abhängigen Variable
plot(density(log(CPS1985$wage)),col="blue")


plot(wage,experience)


# das gleiche Ergebnis mit weniger Schreibarbeit:
with(CPS1985,plot(wage,experience))


l  <- lm( log(wage) ~ education + experience + I(experience^2), data=CPS1985)


# alternative Möglichkeit -  Alter kategorisieren
# Bildung von Dummy-Variablen 


#------------------------------------------------------------#
# Weitere Beispiele
#------------------------------------------------------------#


data(Prestige)
attach(Prestige)
plot(income, prestige, xlab="Average Income", ylab="Prestige")
lines(lowess(income, prestige, f=0.5, iter=0), lwd=2)


#------------------------------------------------------------#
# Links
#------------------------------------------------------------#

# http://www.maths.bath.ac.uk/~jjf23/ELM/scripts/introlm.R


# Folien polynomiales Modell

# http://www.r-bloggers.com/polynomial-regression-techniques/



# http://www.marlenemueller.de/nspm.html


# http://rtutorialseries.blogspot.de/2010/02/r-tutorial-series-basic-polynomial.html



#------------#
# r-project + regression centering variable

# http://en.wikipedia.org/wiki/Polynomial_regression



# http://personal.bgsu.edu/~mrizzo/M758/R/nonparreg.R

# http://www.phonetik.uni-muenchen.de/~jmh/lehre/sem/ss11/statfort/regpoly.pdf


