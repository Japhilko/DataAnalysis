##############################################################
# Nichtlineare Regression
# Jan-Philipp Kolb
# 02.06.2014
#
# Visualisierung Regression
#
##############################################################

#------------------------------------------------------------#
# Generelle Information
#------------------------------------------------------------#

scriptname <- "Regression_C_Visualisierung.R"
author <- "Jan-Philipp Kolb"



#------------------------------------------------------------#
# Bibliotheken
#------------------------------------------------------------#

library(xtable)
library(R2wd)
library(stargazer)
library(texreg)


library(vioplot)

# https://github.com/taiyun/corrplot
library(corrplot)

library(effects)

library(lmtest)
library(faraway)


#------------------------------------------------------------#
# Pfade angeben
#------------------------------------------------------------#

graph.path <- "J:/Work/Statistik/Kolb/Workshops/2014/WorkshopRegression/Folien/figure"


#------------------------------------------------------------#
# Tabellen in LaTeX-Format
#------------------------------------------------------------#

N <- 1000

a <-sample(1:5,N,replace=T)
b <-sample(1:3,N,replace=T)

tabAB <- table(a,b)

xtable(tabAB)

?stargazer

stargazer(attitude)

linear.1 <- lm(rating ~ complaints + privileges + learning 
               + raises + critical, data=attitude)

linear.2 <- lm(rating ~ complaints + privileges + learning, data=attitude)

stargazer(linear.1, linear.2, title="Regression Results")


#------------------------------------------------------------#
# Daten anschauen - Histogramme
#------------------------------------------------------------#

# Ein erster Überblick über die Daten
head(Prestige)

hist(Prestige$income)

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
# Analyse des Zusammenhangs
#------------------------------------------------------------#

data(iris)

head(iris)


# Blütenblatt Länge und Breite

plot(iris$Sepal.Length,iris$Sepal.Width,xlab="Blütenblatt Länge",
     ylab="Blütenblatt Breite",pch=15,col="royalblue")

setwd(graph.path)

png("npReg_plot_iris.png")
plot(iris$Sepal.Length,iris$Sepal.Width,xlab='Blattlaenge',
     ylab='Blattbreite',pch=15,col='royalblue')
dev.off()

cor(iris$Sepal.Length,iris$Petal.Length)

pairs(iris[,1:4])

pairs.panels(iris[1:4],bg=c("red","yellow","blue")
             [iris$Species],pch=21,main="Iris Datensatz")



#------------------------------------------------------------#
# corrplot
#------------------------------------------------------------#


M <- cor(mtcars)


setwd(graph.path)

png("npReg_corrplot_mtcars.png")
corrplot(M)
dev.off()

  # corrplot mit iris daten

M <- cor(iris[,1:4])

setwd(graph.path)
png("npReg_corrplot_iris.png")
corrplot(M)
dev.off()


#----------------------------------------------------------------------------#
# Daten erzeugen
#----------------------------------------------------------------------------#

N <- 10
y<-c(1:N)
x1<-c(1:N)*runif(N,min=0,max=2)
x2<-(c(1:N)*runif(N,min=0,max=2))^2
x3<-log(c(1:N)*runif(N,min=0,max=2))


#----------------------------------------------------------------------------#
# Regressionsmodell rechnen
#----------------------------------------------------------------------------#

mod1 <- lm(y~x1)

plot(x1,y)
abline(mod1)



#------------------------------------------------------------#
# Regressionslinie
#------------------------------------------------------------#

# http://www.r-bloggers.com/how-to-plot-points-regression-line-and-residuals/

  # Residuen herausfinden
res <- signif(residuals(mod1), 5)

  # Vorhersage machen
pre <- predict(mod1)

plot(x1,y)
abline(mod1)

  # Abstände zur Regressionslinie rot einzeichnen
segments(x1, y, x1, pre, col="red")
textxy(x1,y, res, cx=0.7)

setwd(graph.path)
png("npReg_segments_mod1.png")
plot(x1,y)
abline(mod1)
segments(x1, y, x1, pre, col="red")
textxy(x1,y, res, cx=0.7)
dev.off()


#------------------------------------------------------------#
# Überprüfung der Annahmen
#------------------------------------------------------------#


#++++++++++++++++++++++++++++++#
# Nichtkonstante Varianz

data(savings)
g <- lm(sr ~ pop15+pop75+dpi+ddpi,savings)


setwd(graph.path)

png("npReg_nonconstant_lm_savings.png")
par(mfrow=c(1,2))
plot(fitted(g),residuals(g),xlab="Fitted",
     ylab="Residuen")
abline(h=0)
plot(fitted(g),abs(residuals(g)),xlab="Fitted",ylab="|Residuen|")
dev.off()

# Folgende Regression bietet eine einfache Möglichkeit zu testen:

summary(lm(abs(residuals(g)) ~ fitted(g)))


  # Konstante Varianz
plot(1:50,rnorm(50))

  # Starke nichtkonstante Varianz
plot(1:50,(1:50)*rnorm(50))

  # leichte nichtkonstante Varianz
plot(1:50,sqrt((1:50))*rnorm(50)) 

  # Nichtlinearität
plot(1:50,cos((1:50)*pi/25)+rnorm(50))

#++++++++++++++++++++++++++++++#
# Normalität

png("npReg_qqnorm_lm_savings.png")
  qqnorm(residuals(g),ylab="Residuals")
  qqline(residuals(g))
dev.off()



rnormZ <- rnorm(50)
qqnorm(rnormZ)
qqline(rnormZ)



rexpZ <- exp(rnorm(50))
qqnorm(rexpZ) 
qqline(rexpZ)


png("npReg_dreiVerteilungen.png")
par(mfrow=c(2,2))
qqnorm(rnormZ,main="Normal")
qqnorm(rexpZ,main="Exponential") 
qqnorm(rcauchy(50),main="Cauchy")
qqnorm(runif(50),main="Gleich")
dev.off()



#++++++++++++++++++++++++++++++#
# Daten erzeugen

set.seed(10)
y<-c(1:1000)
x1<-c(1:1000)*runif(1000,min=0,max=2)
x2<-(c(1:1000)*runif(1000,min=0,max=2))^2
x3<-log(c(1:1000)*runif(1000,min=0,max=2))

# Modell rechnen

lm_fit<-lm(y~x1+x2+x3)

#++++++++++++++++++++++++++++++#
# Effekte plotten

# http://socserv.socsci.mcmaster.ca/jfox/Courses/Brazil-2009/nonlinearity-etc.R

plot(allEffects(lm_fit), ask=FALSE)


png("npReg_allEffects_lm_fit.png")
plot(allEffects(lm_fit), ask=FALSE)
dev.off()

#++++++++++++++++++++++++++++++#
# linearer Zusammenhang ?


crPlots(lm_fit)

?crPlots

setwd(graph.path)
png("npReg_crPlots_lm_fit.png")
crPlots(lm_fit,layout=c(1,3))
dev.off()

  # Component residual plots, sind eine Erweiterung von
  # partial residual plots

  #  Die Residuen eines Prädiktors werden gegen die abhängige Variable modelliert


#++++++++++++++++++++++++++++++#
# Residuen normalverteilt?

# http://www.unc.edu/courses/2006spring/ecol/145/001/docs/lectures/lecture3.htm

setwd(graph.path)
png("npReg_qqPlot_lm_fit.png")
qqPlot(residuals(lm_fit))
dev.off()

#------------------------------------------------------------#
# Tests zur Überprüfung der Annahmen
#------------------------------------------------------------#

# http://www.r-bloggers.com/veterinary-epidemiologic-research-linear-regression-part-2-checking-assumptions/


ncvTest(lm_fit)

bptest(lm_fit)

  # Normalität der Residuen
shapiro.test(resid(lm_fit))


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
