# Work with the data.table package
# Jan-Philipp Kolb
# 18.03.2021

library(data.table)

# Coerce lists and data.frames to data.table by reference
?setDT

X = data.frame(A=sample(3, 10, TRUE),
               B=sample(letters[1:3], 10, TRUE),
               C=sample(10), stringsAsFactors=FALSE)

# Convert X to data.table by reference and
# get the frequency of each "A,B" combination
setDT(X)[, .N, by=.(A,B)]
