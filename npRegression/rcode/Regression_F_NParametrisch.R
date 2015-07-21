##############################################################
# Nichtlineare Regression
# Jan-Philipp Kolb
# 21.03.2014
#
# Transformation der unabhängigen Variable
#
##############################################################

#------------------------------------------------------------#
# Generelle Information
#------------------------------------------------------------#

options(scipen=10)

scriptname <- "Regression_D_NParametrisch.R"
author <- "Jan-Philipp Kolb"



#------------------------------------------------------------#
# Bibliotheken einlesen
#------------------------------------------------------------#

library(car)
library(faraway)
library(MASS)
attach(geyser)

library(scatterplot3d)
library(AER)
library(KernSmooth)

library(splines)

#------------------------------------------------------------#
# Pfade angeben
#------------------------------------------------------------#

graph.path <- "J:/Work/Statistik/Kolb/Workshops/2014/WorkshopRegression/Folien/figure"

#------------------------------------------------------------#
# Beispieldaten erzeugen
#------------------------------------------------------------#

funky  <- function(x) sin(2*pi*x^2)^3  
x <- seq(0,1,0.01)
y <- funky(x)+0.1*rnorm(101)


#------------------------------------------------------------#
# Daten plotten
#------------------------------------------------------------#


setwd(graph.path)
png("npReg_matplot_splines.png")
# par(mfrow=c(2,2))
matplot(x,cbind(y,funky(x)),type="pl",ylab="y",pch=18,lty=1,main="True Model")
dev.off()


#------------------------------------------------------------#
# Polynomialregression 
#------------------------------------------------------------#


g4 <- lm(y~poly(x,4))
g12 <- lm(y~poly(x,12))


setwd(graph.path)
png("npReg_matplot_poly.png")
matplot(x,cbind(y,g4$fit,g12$fit),type="pll",ylab="y",pch=18,lty=c(1,2),main="Orthogonal Polynomials")
dev.off()

#------------------------------------------------------------#
# Spline regression 
#------------------------------------------------------------#


knots <- c(0,0,0,0,0.2,0.4,0.5,0.6,0.7,0.8,0.85,0.9,1,1,1,1)
bx <- splineDesign(knots,x)
gs <- lm(y~bx)




setwd(graph.path)
png("npReg_matplot_splinefit.png")
par(mfrow=c(2,2))
matplot(x,bx,type="l",main="B-spline basis functions")
matplot(x,cbind(y,gs$fit),type="pl",ylab="y",pch=18,lty=1,main="Spline fit")
dev.off()





#------------------------------------------------------------#
# Faraway - Extending the Linear Model with R Generalized Linear - Mixed Effects and Nonparametric
#------------------------------------------------------------#

# Quelle: http://personal.bgsu.edu/~mrizzo/M758/R/nonparreg.R

data(geyser)

png("npReg_plot_OldFaithful.png")
plot(duration ~ waiting, geyser, pch=16, cex=.25, col=4,
     main="Old Faithful")
dev.off()

# Nun wird die Nadaraya–Watson kernel regression verwendet

?ksmooth

a <- c(1,3,4,6,7,8,4)
b <- c(10,13,12,8,17,14,8)

ksmooth(b, a,"normal",bandwidth=1)

# Das Ergebnis sind mindestens 100 Werte, wenn mehr Beobachtungen da
# sind, dann entsprechend mehr


plot(a ~ b)
lines(ksmooth(b, a,"normal",bandwidth=1),col=2)
lines(ksmooth(b, a,"normal",bandwidth=2),col=3)



plot(duration ~ waiting, geyser, pch=16, cex=.25, col=4,
     main="Old Faithful (normal kernel)")
lines(ksmooth(waiting, duration, "normal", bandwidth=2), col=1)
lines(ksmooth(waiting, duration, "normal", bandwidth=8), col=2)
lines(ksmooth(waiting, duration, "normal", bandwidth=12), col=3)





# Es handelt sich um Beispieldaten aus dem Buch von Härdle (1991)


data(exa)
data(exb)

setwd(graph.path)
png("npReg_plot_BSPA.png")
plot( y ~ x, exa, main="Beispiel A", pch=16, cex=.5)
lines(m ~ x, lwd=2, data=exa)
dev.off()

png("npReg_plot_BSPB.png")
plot (y ~ x, exb, main="Beispiel B", pch=16, cex=.5)
lines(m ~ x, lwd=2, data=exb)
dev.off()




#------------------------------------------------------------#
# Links
#------------------------------------------------------------#


# http://www.marlenemueller.de/nspm.html


# http://www.r-bloggers.com/thats-smooth/

