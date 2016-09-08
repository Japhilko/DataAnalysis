# Regression
Jan-Philipp Kolb  
26 Juli 2016  



## [Linear Model](https://www.youtube.com/watch?v=5ONFqIk3RFg)

The following is based on course by Trevor Hastie and Rob Tibshirani on statistical learning.  


```r
install.packages("ISLR")
```


```r
library("MASS")
library("ISLR")
```


```r
names(Boston)
```

```
##  [1] "crim"    "zn"      "indus"   "chas"    "nox"     "rm"      "age"    
##  [8] "dis"     "rad"     "tax"     "ptratio" "black"   "lstat"   "medv"
```

```r
# ?Boston
```


```r
plot(medv~lstat,Boston)
```

![](SimpleLinearRegression_files/figure-html/fitlinearmodel-1.png)<!-- -->

```r
fit1 <- lm(medv~lstat,Boston)
summary(fit1)
```

```
## 
## Call:
## lm(formula = medv ~ lstat, data = Boston)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -15.168  -3.990  -1.318   2.034  24.500 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 34.55384    0.56263   61.41   <2e-16 ***
## lstat       -0.95005    0.03873  -24.53   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 6.216 on 504 degrees of freedom
## Multiple R-squared:  0.5441,	Adjusted R-squared:  0.5432 
## F-statistic: 601.6 on 1 and 504 DF,  p-value: < 2.2e-16
```

[Picture - Simple Linear Regression](http://i0.wp.com/3.bp.blogspot.com/-M-eh1oV6NT0/Vn4nPWRl-LI/AAAAAAAAAbA/qiLz64Ky2Zw/s320/regression.png?resize=350%2C200)



```r
plot(medv~lstat,Boston)
abline(fit1,col=c("#8B008B"))
```

![](SimpleLinearRegression_files/figure-html/unnamed-chunk-4-1.png)<!-- -->


```r
confint(fit1)
```

```
##                 2.5 %     97.5 %
## (Intercept) 33.448457 35.6592247
## lstat       -1.026148 -0.8739505
```

```r
predict(fit1,data.frame(lstat=c(5,10,15)),interval="confidence")
```

```
##        fit      lwr      upr
## 1 29.80359 29.00741 30.59978
## 2 25.05335 24.47413 25.63256
## 3 20.30310 19.73159 20.87461
```


```r
fit2 <- lm(medv~lstat+age,Boston)
summary(fit2)
```

```
## 
## Call:
## lm(formula = medv ~ lstat + age, data = Boston)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -15.981  -3.978  -1.283   1.968  23.158 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 33.22276    0.73085  45.458  < 2e-16 ***
## lstat       -1.03207    0.04819 -21.416  < 2e-16 ***
## age          0.03454    0.01223   2.826  0.00491 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 6.173 on 503 degrees of freedom
## Multiple R-squared:  0.5513,	Adjusted R-squared:  0.5495 
## F-statistic:   309 on 2 and 503 DF,  p-value: < 2.2e-16
```

```r
fit3 <- lm(medv~.,Boston)
summary(fit3)
```

```
## 
## Call:
## lm(formula = medv ~ ., data = Boston)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -15.595  -2.730  -0.518   1.777  26.199 
## 
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  3.646e+01  5.103e+00   7.144 3.28e-12 ***
## crim        -1.080e-01  3.286e-02  -3.287 0.001087 ** 
## zn           4.642e-02  1.373e-02   3.382 0.000778 ***
## indus        2.056e-02  6.150e-02   0.334 0.738288    
## chas         2.687e+00  8.616e-01   3.118 0.001925 ** 
## nox         -1.777e+01  3.820e+00  -4.651 4.25e-06 ***
## rm           3.810e+00  4.179e-01   9.116  < 2e-16 ***
## age          6.922e-04  1.321e-02   0.052 0.958229    
## dis         -1.476e+00  1.995e-01  -7.398 6.01e-13 ***
## rad          3.060e-01  6.635e-02   4.613 5.07e-06 ***
## tax         -1.233e-02  3.760e-03  -3.280 0.001112 ** 
## ptratio     -9.527e-01  1.308e-01  -7.283 1.31e-12 ***
## black        9.312e-03  2.686e-03   3.467 0.000573 ***
## lstat       -5.248e-01  5.072e-02 -10.347  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 4.745 on 492 degrees of freedom
## Multiple R-squared:  0.7406,	Adjusted R-squared:  0.7338 
## F-statistic: 108.1 on 13 and 492 DF,  p-value: < 2.2e-16
```


```r
par(mfrow=c(2,2))
plot(fit3)
```

![](SimpleLinearRegression_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

First plot: residuals vs fitted

is there some non-linearity - or straight line

Third plot: Scale Location

is the variance changing with the mean


```r
fit4 <- update(fit3,~.-age-indus)
summary(fit4)
```

```
## 
## Call:
## lm(formula = medv ~ crim + zn + chas + nox + rm + dis + rad + 
##     tax + ptratio + black + lstat, data = Boston)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -15.5984  -2.7386  -0.5046   1.7273  26.2373 
## 
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  36.341145   5.067492   7.171 2.73e-12 ***
## crim         -0.108413   0.032779  -3.307 0.001010 ** 
## zn            0.045845   0.013523   3.390 0.000754 ***
## chas          2.718716   0.854240   3.183 0.001551 ** 
## nox         -17.376023   3.535243  -4.915 1.21e-06 ***
## rm            3.801579   0.406316   9.356  < 2e-16 ***
## dis          -1.492711   0.185731  -8.037 6.84e-15 ***
## rad           0.299608   0.063402   4.726 3.00e-06 ***
## tax          -0.011778   0.003372  -3.493 0.000521 ***
## ptratio      -0.946525   0.129066  -7.334 9.24e-13 ***
## black         0.009291   0.002674   3.475 0.000557 ***
## lstat        -0.522553   0.047424 -11.019  < 2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 4.736 on 494 degrees of freedom
## Multiple R-squared:  0.7406,	Adjusted R-squared:  0.7348 
## F-statistic: 128.2 on 11 and 494 DF,  p-value: < 2.2e-16
```

## Model Selection

[Quick R - Multiple Regression](http://www.statmethods.net/stats/regression.html)


```r
library(MASS)
fit <- lm(medv~.,data=Boston)
step <- stepAIC(fit, direction="both")
```

```
## Start:  AIC=1589.64
## medv ~ crim + zn + indus + chas + nox + rm + age + dis + rad + 
##     tax + ptratio + black + lstat
## 
##           Df Sum of Sq   RSS    AIC
## - age      1      0.06 11079 1587.7
## - indus    1      2.52 11081 1587.8
## <none>                 11079 1589.6
## - chas     1    218.97 11298 1597.5
## - tax      1    242.26 11321 1598.6
## - crim     1    243.22 11322 1598.6
## - zn       1    257.49 11336 1599.3
## - black    1    270.63 11349 1599.8
## - rad      1    479.15 11558 1609.1
## - nox      1    487.16 11566 1609.4
## - ptratio  1   1194.23 12273 1639.4
## - dis      1   1232.41 12311 1641.0
## - rm       1   1871.32 12950 1666.6
## - lstat    1   2410.84 13490 1687.3
## 
## Step:  AIC=1587.65
## medv ~ crim + zn + indus + chas + nox + rm + dis + rad + tax + 
##     ptratio + black + lstat
## 
##           Df Sum of Sq   RSS    AIC
## - indus    1      2.52 11081 1585.8
## <none>                 11079 1587.7
## + age      1      0.06 11079 1589.6
## - chas     1    219.91 11299 1595.6
## - tax      1    242.24 11321 1596.6
## - crim     1    243.20 11322 1596.6
## - zn       1    260.32 11339 1597.4
## - black    1    272.26 11351 1597.9
## - rad      1    481.09 11560 1607.2
## - nox      1    520.87 11600 1608.9
## - ptratio  1   1200.23 12279 1637.7
## - dis      1   1352.26 12431 1643.9
## - rm       1   1959.55 13038 1668.0
## - lstat    1   2718.88 13798 1696.7
## 
## Step:  AIC=1585.76
## medv ~ crim + zn + chas + nox + rm + dis + rad + tax + ptratio + 
##     black + lstat
## 
##           Df Sum of Sq   RSS    AIC
## <none>                 11081 1585.8
## + indus    1      2.52 11079 1587.7
## + age      1      0.06 11081 1587.8
## - chas     1    227.21 11309 1594.0
## - crim     1    245.37 11327 1594.8
## - zn       1    257.82 11339 1595.4
## - black    1    270.82 11352 1596.0
## - tax      1    273.62 11355 1596.1
## - rad      1    500.92 11582 1606.1
## - nox      1    541.91 11623 1607.9
## - ptratio  1   1206.45 12288 1636.0
## - dis      1   1448.94 12530 1645.9
## - rm       1   1963.66 13045 1666.3
## - lstat    1   2723.48 13805 1695.0
```

```r
step$anova # display results 
```

```
## Stepwise Model Path 
## Analysis of Deviance Table
## 
## Initial Model:
## medv ~ crim + zn + indus + chas + nox + rm + age + dis + rad + 
##     tax + ptratio + black + lstat
## 
## Final Model:
## medv ~ crim + zn + chas + nox + rm + dis + rad + tax + ptratio + 
##     black + lstat
## 
## 
##      Step Df   Deviance Resid. Df Resid. Dev      AIC
## 1                             492   11078.78 1589.643
## 2   - age  1 0.06183435       493   11078.85 1587.646
## 3 - indus  1 2.51754013       494   11081.36 1585.761
```


```r
library(relaimpo)
calc.relimp(fit,type=c("lmg","last","first","pratt"),
   rela=TRUE)
```

```
## Response variable: medv 
## Total response variance: 84.58672 
## Analysis based on 506 observations 
## 
## 13 Regressors: 
## crim zn indus chas nox rm age dis rad tax ptratio black lstat 
## Proportion of variance explained by model: 74.06%
## Metrics are normalized to sum to 100% (rela=TRUE). 
## 
## Relative importance metrics: 
## 
##                lmg         last      first        pratt
## crim    0.03669197 2.729655e-02 0.05595966  0.052961297
## zn      0.03349910 2.889844e-02 0.04821796  0.057287945
## indus   0.05101231 2.824457e-04 0.08684150 -0.010015656
## chas    0.02139033 2.457505e-02 0.01139978  0.017557860
## nox     0.04511571 5.467349e-02 0.06777008  0.129151232
## rm      0.25259867 2.100187e-01 0.17945242  0.273261342
## age     0.02975151 6.939671e-06 0.05273610 -0.001078294
## dis     0.04087946 1.383137e-01 0.02318261 -0.114002359
## rad     0.03190385 5.377546e-02 0.05405133 -0.149297150
## tax     0.04967225 2.718856e-02 0.08147339  0.142989284
## ptratio 0.10602348 1.340289e-01 0.09569574  0.153760984
## black   0.03093651 3.037329e-02 0.04126859  0.041615923
## lstat   0.27052485 2.705685e-01 0.20195084  0.405807591
## 
## Average coefficients for different model sizes: 
## 
##                   1X          2Xs          3Xs           4Xs          5Xs
## crim     -0.41519028  -0.27876734  -0.21102769  -0.172845863  -0.14899982
## zn        0.14213999   0.09177589   0.06926785   0.058187805   0.05208479
## indus    -0.64849005  -0.49907219  -0.39245035  -0.312711078  -0.25044986
## chas      6.34615711   6.13625177   5.79137684   5.378363951   4.96039109
## nox     -33.91605501 -23.64184669 -17.74630522 -14.537764121 -12.99734886
## rm        9.10210898   8.07541798   7.46905711   7.011233964   6.61054979
## age      -0.12316272  -0.07450317  -0.04834524  -0.033245015  -0.02390811
## dis       1.09161302   0.10952005  -0.47255267  -0.833695790  -1.06499158
## rad      -0.40309540  -0.20593927  -0.08194586   0.001678813   0.06198805
## tax      -0.02556810  -0.02017034  -0.01665270  -0.014304609  -0.01271040
## ptratio  -2.15717530  -1.74062066  -1.52445277  -1.389315454  -1.29154159
## black     0.03359306   0.02243776   0.01743324   0.014808955   0.01324295
## lstat    -0.95004935  -0.90871002  -0.86922333  -0.830576846  -0.79243771
##                  6Xs          7Xs          8Xs           9Xs          10Xs
## crim     -0.13318972  -0.12244878  -0.11518841  -0.110479262  -0.107740227
## zn        0.04841098   0.04611642   0.04473486   0.044039341   0.043909618
## indus    -0.19989046  -0.15740182  -0.12065007  -0.088070978  -0.058531713
## chas      4.56663532   4.20812708   3.88683375   3.600046913   3.342756614
## nox     -12.49075417 -12.61748098 -13.12577086 -13.860628817 -14.730291533
## rm        6.23447431   5.87015426   5.51253464   5.160160375   4.813205720
## age      -0.01774178  -0.01339689  -0.01012959  -0.007506479  -0.005261198
## dis      -1.21554565  -1.31379414  -1.37739662  -1.417937166  -1.443287731
## rad       0.10808364   0.14515543   0.17645934   0.204220581   0.230033618
## tax      -0.01163317  -0.01094108  -0.01056128  -0.010452258  -0.010588444
## ptratio  -1.21468054  -1.15187362  -1.09982518  -1.056675250  -1.021201281
## black     0.01221866   0.01149901   0.01096173   0.010537971   0.010185605
## lstat    -0.75484432  -0.71798862  -0.68210391  -0.647421018  -0.614154947
##                  11Xs          12Xs          13Xs
## crim     -0.106584888  -0.106741334 -1.080114e-01
## zn        0.044279575   0.045117684  4.642046e-02
## indus    -0.031119628  -0.005017834  2.055863e-02
## chas      3.108982366   2.892438686  2.686734e+00
## nox     -15.684182425 -16.698441350 -1.776661e+01
## rm        4.472316347   4.137922082  3.809865e+00
## age      -0.003220995  -0.001266585  6.922246e-04
## dis      -1.458920162  -1.468724058 -1.475567e+00
## rad       0.255062878   0.280176177  3.060495e-01
## tax      -0.010953167  -0.011536415 -1.233459e-02
## ptratio  -0.992503316  -0.969873098 -9.527472e-01
## black     0.009876605   0.009590626  9.311683e-03
## lstat    -0.582502652  -0.552645344 -5.247584e-01
```



## Interactions

[with * the coefficients are used and also the interaction between them](http://www.gardenersown.co.uk/education/lectures/r/regression.htm)



```r
fit5 <- lm(medv~lstat*age,Boston)
summary(fit5)
```

```
## 
## Call:
## lm(formula = medv ~ lstat * age, data = Boston)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -15.806  -4.045  -1.333   2.085  27.552 
## 
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 36.0885359  1.4698355  24.553  < 2e-16 ***
## lstat       -1.3921168  0.1674555  -8.313 8.78e-16 ***
## age         -0.0007209  0.0198792  -0.036   0.9711    
## lstat:age    0.0041560  0.0018518   2.244   0.0252 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 6.149 on 502 degrees of freedom
## Multiple R-squared:  0.5557,	Adjusted R-squared:  0.5531 
## F-statistic: 209.3 on 3 and 502 DF,  p-value: < 2.2e-16
```


```r
fit6 <- lm(medv ~ lstat +I(lstat^2),Boston)
summary(fit6)
```

```
## 
## Call:
## lm(formula = medv ~ lstat + I(lstat^2), data = Boston)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -15.2834  -3.8313  -0.5295   2.3095  25.4148 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 42.862007   0.872084   49.15   <2e-16 ***
## lstat       -2.332821   0.123803  -18.84   <2e-16 ***
## I(lstat^2)   0.043547   0.003745   11.63   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 5.524 on 503 degrees of freedom
## Multiple R-squared:  0.6407,	Adjusted R-squared:  0.6393 
## F-statistic: 448.5 on 2 and 503 DF,  p-value: < 2.2e-16
```

```r
attach(Boston)

plot(medv~lstat)
points(lstat,fitted(fit6),col="red",pch=20)
```

![](SimpleLinearRegression_files/figure-html/unnamed-chunk-12-1.png)<!-- -->

## Fitting Polynomials


```r
fit7 <- lm(medv ~ lstat +poly(lstat,4),Boston)
plot(medv~lstat)
points(lstat,fitted(fit7),col="blue",pch=20)
```

![](SimpleLinearRegression_files/figure-html/unnamed-chunk-13-1.png)<!-- -->

tends to overfit


```r
kable(head(Carseats))
```



 Sales   CompPrice   Income   Advertising   Population   Price  ShelveLoc    Age   Education  Urban   US  
------  ----------  -------  ------------  -----------  ------  ----------  ----  ----------  ------  ----
  9.50         138       73            11          276     120  Bad           42          17  Yes     Yes 
 11.22         111       48            16          260      83  Good          65          10  Yes     Yes 
 10.06         113       35            10          269      80  Medium        59          12  Yes     Yes 
  7.40         117      100             4          466      97  Medium        55          14  Yes     Yes 
  4.15         141       64             3          340     128  Bad           38          13  Yes     No  
 10.81         124      113            13          501      72  Bad           78          16  No      Yes 


```r
attach(Carseats)
mod1 <- lm(Sales~.+Income:Advertising,Carseats)
contrasts(ShelveLoc)
```

```
##        Good Medium
## Bad       0      0
## Good      1      0
## Medium    0      1
```

## Resources

- Faraway - [Practical Regression and Anova using R](https://cran.r-project.org/doc/contrib/Faraway-PRA.pdf)

- Breheny/Burchett - [Visualization of Regression Models Using visreg](http://myweb.uiowa.edu/pbreheny/publications/visreg.pdf)

- Wheeler - [Visualizing and Diagnosing Output from 
Geographically Weighted Regression Models](https://www.sph.emory.edu/departments/bios/documents/techdocs/2008/Tech_Report_08-02.pdf)
