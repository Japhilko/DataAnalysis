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

scriptname <- "Regression_B_Transformation.R"
author <- "Jan-Philipp Kolb"


#------------------------------------------------------------#
# Pfade angeben
#------------------------------------------------------------#

graph.path <- "J:/Work/Statistik/Kolb/Workshops/2014/WorkshopRegression/Folien/figure"


#------------------------------------------------------------#
# Bibliotheken
#------------------------------------------------------------#

library(car)


# DAAG package

data(Prestige)

library(MASS)

library(faraway)

#------------------------------------------------------------#
# Datensätze erzeugen/anschauen
#------------------------------------------------------------#



set.seed(10)
y<-c(1:1000)
x1<-c(1:1000)*runif(1000,min=0,max=2)
x2<-(c(1:1000)*runif(1000,min=0,max=2))^2
x3<-log(c(1:1000)*runif(1000,min=0,max=2))


data(savings) # Bibliothek faraway


#------------------------------------------------------------#
# Transformieren durch Logarithmieren
#------------------------------------------------------------#

hist(x2,breaks=15,col="royalblue",main="")

hist(log(x2),breaks=15,col="chocolate1",main="")

setwd(graph.path)
png("npReg_hist_x2.png")
  hist(x2,breaks=15,col="royalblue",main="")
dev.off()

png("npReg_hist_logx2.png")
  hist(log(x2),breaks=15,col="chocolate1",main="")
dev.off()

#------------------------------------------------------------#
# Box-Cox Transformation
#------------------------------------------------------------#
g <- lm(sr ~ pop15+pop75+dpi+ddpi,savings)

boxcox(g,plotit=T)

setwd(graph.path)
png("npReg_boxcox_savings.png")
  boxcox(g,plotit=T)
dev.off()

boxcox(g,plotit=T,lambda=seq(0.5,1.5,by=0.1))
data(gala)
g <- lm(Species ~ Area + Elevation + Nearest + Scruz + Adjacent,gala)
boxcox(g,plotit=T)
boxcox(g,lambda=seq(0.0,1.0,by=0.05),plotit=T)




g1 <- lm(sr ~ pop15, savings, subset=(pop15 < 35))
g2 <- lm(sr ~ pop15, savings, subset=(pop15 > 35))
plot(sr ~ pop15,savings,xlab="Pop'n under 15",ylab="Savings Rate")

abline(v=35,lty=5)
segments(20,g1$coef[1]+g1$coef[2]*20,35,g1$coef[1]+g1$coef[2]*35)
segments(48,g2$coef[1]+g2$coef[2]*48,35,g2$coef[1]+g2$coef[2]*35)

  # Den plot abspeichern:

setwd(graph.path)
png("npReg_segmentedReg_savings.png")
plot(sr ~ pop15,savings,xlab="Pop'n under 15",ylab="Savings Rate")
abline(v=35,lty=5)
segments(20,g1$coef[1]+g1$coef[2]*20,35,g1$coef[1]+g1$coef[2]*35)
segments(48,g2$coef[1]+g2$coef[2]*48,35,g2$coef[1]+g2$coef[2]*35)
dev.off()

  # Segmented regression in einem Modell:

lhs <- function(x) ifelse(x < 35,35-x,0)
rhs <- function(x) ifelse(x < 35,0,x-35)
gb <- lm(sr ~ lhs(pop15) + rhs(pop15), savings)

x <- seq(20,48,by=1)
py <- gb$coef[1]+gb$coef[2]*lhs(x)+gb$coef[3]*rhs(x)
lines(x,py,lty=2)
summary(lm(sr ~ ddpi,savings))
summary(lm(sr ~ ddpi+I(ddpi^2),savings))
summary(lm(sr ~ ddpi+I(ddpi^2)+I(ddpi^3),savings))
savings <- data.frame(savings,mddpi=savings$ddpi-10)
summary(lm(sr ~ mddpi+I(mddpi^2),savings))
g <- lm(sr ~ poly(ddpi,4),savings)
summary(g)
g <- lm(sr ~ polym(pop15,ddpi,degree=2),savings)
funky <- function(x) sin(2*pi*x^3)^3
x <- seq(0,1,by=0.01)
y <- funky(x) + 0.1*rnorm(101)
matplot(x,cbind(y,funky(x)),type="pl",ylab="y",pch=18,lty=1)
g4 <- lm(y ~ poly(x,4))
g12 <- lm(y ~ poly(x,12))
matplot(x,cbind(y,g4$fit,g12$fit),type="pll",ylab="y",pch=18,lty=c(1,2))
library(splines)
knots <- c(0,0,0,0,0.2,0.4,0.5,0.6,0.7,0.8,0.85,0.9,1,1,1,1)
bx <- splineDesign(knots,x)
gs <- lm(y ~ bx)
matplot(x,bx,type="l")
matplot(x,cbind(y,gs$fit),type="pl",ylab="y",pch=18,lty=1)


#------------------------------------------------------------#
# Beispiel aus der Visualisierung - wieder aufgegriffen
#------------------------------------------------------------#

# http://www.r-bloggers.com/r-regression-diagnostics-part-1/

set.seed(10)
y<-c(1:1000)
x1<-c(1:1000)*runif(1000,min=0,max=2)
x2<-(c(1:1000)*runif(1000,min=0,max=2))^2
x3<-log(c(1:1000)*runif(1000,min=0,max=2))


lm_fit<-lm(y~x1+x2+x3)
crPlots(lm_fit)

lm_fit2<-lm(y~x1+sqrt(x2)+exp(x3))
crPlots(lm_fit2)


# Transformationen können manchmal sowohl das Problem der Heteroskedastizität als auch das der mangelnden Normalität lösen. 



#------------------------------------------------------------#
# Box-Cox regression
#------------------------------------------------------------#

# http://www.r-bloggers.com/veterinary-epidemiologic-research-linear-regression-part-3-box-cox-and-matrix-representation/

lm_mod1 <- lm(y ~ x1 + x2 + x3)
boxcox(lm_mod1, plotit = TRUE)


# Box-Tidwell regression
  # http://socserv.socsci.mcmaster.ca/jfox/Courses/Brazil-2009/nonlinearity-etc.R