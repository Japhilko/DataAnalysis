# Outlier Detection
# Jan-Philipp Kolb
# Fri Oct 21 10:53:59 2016


# install.packages("extremevalues")


# https://cran.r-project.org/web/packages/extremevalues/extremevalues.pdf
library(extremevalues)

y <- rlnorm(100)
y <- c(0.1*min(y),y,10*max(y))
K <- getOutliers(y,method="I",distribution="lognormal")
L <- getOutliers(y,method="II",distribution="lognormal")
par(mfrow=c(1,2))
outlierPlot(y,K,mode="qq")
outlierPlot(y,L,mode="residual")

y1 <- rlnorm(100)
plot(density(y1))
