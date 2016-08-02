# https://www.r-bloggers.com/intro-to-text-analysis-with-r/

install.packages("devtools")

require(devtools)
install_url("http://www.omegahat.org/Rstem/Rstem_0.4-1.tar.gz")
install_url("http://cran.r-project.org/src/contrib/Archive/sentiment/sentiment_0.1.tar.gz")
install_url("http://cran.r-project.org/src/contrib/Archive/sentiment/sentiment_0.2.tar.gz")

install.packages("plyr")
install.packages("ggplot2")
install.packages("wordcloud")
install.packages("RColorBrewer")
install.packages("tm")
install.packages("SnowballC")

library("plyr")
library("ggplot2")
library("wordcloud")
library("RColorBrewer")
library("tm")
library("SnowballC")

###Get the data

data <- readLines("https://www.r-bloggers.com/wp-content/uploads/2016/01/vent.txt") # from: http://www.wvgazettemail.com/

df <- data.frame(data)

textdata <- df[df$data, ]

textdata = gsub("[[:punct:]]", "", textdata)

textdata = gsub("[[:punct:]]", "", textdata)

textdata = gsub("[[:digit:]]", "", textdata)

textdata = gsub("http\\w+", "", textdata)

textdata = gsub("[ \t]{2,}", "", textdata)

textdata = gsub("^\\s+|\\s+$", "", textdata)

try.error = function(x)
  
{
  
  y = NA
  
  try_error = tryCatch(tolower(x), error=function(e) e)
  
  if (!inherits(try_error, "error"))
    
    y = tolower(x)
  
  return(y)
  
}

textdata = sapply(textdata, try.error)

textdata = textdata[!is.na(textdata)]

names(textdata) = NULL

class_emo = classify_emotion(textdata, algorithm="bayes", prior=1.0)

emotion = class_emo[,7]

emotion[is.na(emotion)] = "unknown"

class_pol = classify_polarity(textdata, algorithm="bayes")

polarity = class_pol[,4]



sent_df = data.frame(text=textdata, emotion=emotion,
                     
                     polarity=polarity, stringsAsFactors=FALSE)

sent_df = within(sent_df,
                 
                 emotion <- factor(emotion, levels=names(sort(table(emotion), decreasing=TRUE))))