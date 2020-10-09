# Record Linkage with R
# Jan-Philipp Kolb
# Thu Oct 01 15:46:09 2020

  # a package to produce a synthetic dataset
library(randomNames)

library(fastLink)


n <- 1000

names1 <- randomNames(n)
names2 <- randomNames(n)
names2 <- c(names1[1:10],names2)


nam_split <- strsplit(names1,",")
df1 <- data.frame(name=unlist(lapply(nam_split,function(x)x[1])),
                  surname=unlist(lapply(nam_split,function(x)x[2])))

nam_split <- strsplit(names2,",")
df2 <- data.frame(name=unlist(lapply(nam_split,function(x)x[1])),
                  surname=unlist(lapply(nam_split,function(x)x[2])))

  # if fastLink does not find many matches - lower the threshold.match
res <- fastLink(df1,df2,varnames = c("name","surname"),
                threshold.match = .2)


summary(res)

# relativ wenige matches
# eigenen Datensatz erstellen



length(res$matches[[1]])
