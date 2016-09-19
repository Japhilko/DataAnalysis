# Multilevel models
Jan-Philipp Kolb  
Tue Mar 08 08:15:28 2016  

## Intro Regression

- [Multivariate statistics](http://www.statistics4u.info/fundstat_germ/cc_multivar_stat.html)

![cartoon](http://www.statistics4u.info/fundstat_germ/img/gm_bivarstat_tusche.png)


## Multilevel models ([Bates](http://www.unil.ch/webdav/site/ee/shared/WorkshopD.pdf))

- Starts with slide 56
- Dyestuff-Data are explained in the book: "Statistical Methods in Research and Production"


```r
library(lme4)
```

```
## Warning: package 'lme4' was built under R version 3.2.5
```

```
## Loading required package: Matrix
```

```
## Warning: package 'Matrix' was built under R version 3.2.5
```

```r
fm1 <- lmer(Yield ~ 1 + (1 | Batch), Dyestuff)
```

fm1 is an objekt of class `mer` (mixed-effects representation).


```r
print(fm1)
```

```
## Linear mixed model fit by REML ['lmerMod']
## Formula: Yield ~ 1 + (1 | Batch)
##    Data: Dyestuff
## REML criterion at convergence: 319.6543
## Random effects:
##  Groups   Name        Std.Dev.
##  Batch    (Intercept) 42.00   
##  Residual             49.51   
## Number of obs: 30, groups:  Batch, 6
## Fixed Effects:
## (Intercept)  
##        1528
```


## Function to apply on fm1

There are some functions to get information about Object fm1


```r
fixef(fm1)
```

```
## (Intercept) 
##      1527.5
```

```r
ranef(fm1, drop = TRUE)
```

```
## $Batch
##           A           B           C           D           E           F 
## -17.6068514   0.3912634  28.5622255 -23.0845384  56.7331877 -44.9952868
```

```r
fitted(fm1)
```

```
##        1        2        3        4        5        6        7        8 
## 1509.893 1509.893 1509.893 1509.893 1509.893 1527.891 1527.891 1527.891 
##        9       10       11       12       13       14       15       16 
## 1527.891 1527.891 1556.062 1556.062 1556.062 1556.062 1556.062 1504.415 
##       17       18       19       20       21       22       23       24 
## 1504.415 1504.415 1504.415 1504.415 1584.233 1584.233 1584.233 1584.233 
##       25       26       27       28       29       30 
## 1584.233 1482.505 1482.505 1482.505 1482.505 1482.505
```

## More information


```r
with(Dyestuff, as(Batch, "sparseMatrix"))
```

```
## 6 x 30 sparse Matrix of class "dgCMatrix"
##                                                              
## A 1 1 1 1 1 . . . . . . . . . . . . . . . . . . . . . . . . .
## B . . . . . 1 1 1 1 1 . . . . . . . . . . . . . . . . . . . .
## C . . . . . . . . . . 1 1 1 1 1 . . . . . . . . . . . . . . .
## D . . . . . . . . . . . . . . . 1 1 1 1 1 . . . . . . . . . .
## E . . . . . . . . . . . . . . . . . . . . 1 1 1 1 1 . . . . .
## F . . . . . . . . . . . . . . . . . . . . . . . . . 1 1 1 1 1
```

```r
invisible(update(fm1, verbose = TRUE))
```

```
## start par. =  0.9787605 fn =  319.7587 
## At return
## eval:  17 fn:      319.65428 par: 0.848324
```

```r
# (efm1 <- expand(fm1))$S

# (fm1S <- tcrossprod(efm1$T %*% efm1$S))

# (fm1M <- update(fm1, REML = FALSE))
```

## Resources

- Workshop - [Intro lme4 package](http://www.unil.ch/webdav/site/ee/shared/WorkshopD.pdf)
 

 - [Changes lme4 package](lme4.R-forge.R-project.org)
 

- [How to find influence points](http://www.r-bloggers.com/influence-me-tools-for-detecting-influential-data-in-multilevel-regression-models/) 


 - [Generalized hierarchical models](http://journal.r-project.org/archive/2010-2/RJournal_2010-2_Roennegaard~et~al.pdf)
 
- [ML growth models](http://www.r-bloggers.com/analysing-longitudinal-data-multilevel-growth-models-i/)

- [ML workflow](http://www.r-bloggers.com/linear-mixed-effect-model-workflow/)

- [Intro ML](http://www.bristol.ac.uk/media-library/sites/cmm/migrated/documents/5-r-sample.pdf)

## More Resources

- Getting started with [multilevel models in R ](http://www.r-bloggers.com/getting-started-with-mixed-effect-models-in-r/)


- Bliese [Multilevel](https://cran.r-project.org/doc/contrib/Bliese_Multilevel.pdf)

- [Longitudinal Models](http://www.r-bloggers.com/using-r-and-lmelmer-to-fit-different-two-and-three-level-longitudinal-models/)

