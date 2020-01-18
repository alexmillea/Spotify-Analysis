###############################
#                             #
#     Merge Data Analysis     #
#     + mapReduce Analysis    #
#                             #
###############################

#selects columsn from spotifyAR and creates new dataframe
#dataframe then is merged using cbind with spotifyscraped
#creating duplicated but we want to run some anlysis on both so this is perfect
#it will later be transformed and cleaned again to combine the columns 
mergedSpotify <- spotifyAR %>% select(Track, Artist, Streams, Date) 
mergedSpotify <- cbind(mergedSpotify, spotifyScraped)

#check columns and change names 
ncol(mergedSpotify)
colnames(mergedSpotify)[6] <- "TrackScraped"
colnames(mergedSpotify)[7] <- "ArtistScraped"
colnames(mergedSpotify)[8] <- "StreamScraped"
colnames(mergedSpotify)[9] <- "DateScraped"

mergedSpotify <- mergedSpotify[,-5] 
head(mergedSpotify)


#####################
#                   #
#    Analysis       #
#                   #
#####################

mean1 <- mean(mergedSpotify$Streams)
mean2 <- mean(mergedSpotify$StreamScraped)

median1 <- median(spotifyScraped$Streams)
median2 <- median(spotifyAR$Streams)

max1 <- max(spotifyScraped$Streams)
max2 <- max(spotifyAR$Streams)
min1 <- min(spotifyScraped$Streams)
min2 <- min(spotifyAR$Streams)

plot(spotifyAR)
ggplot() + 
  geom_point(aes(x=max1, y=min1),colour="red") + 
  geom_point(aes(x=max2,y=min2),colour="blue") +
  ylab("Num.of Streams") +
  theme_bw()

plot(spotifyScraped$Streams)
plot(spotifyAR$Streams)

#scatter plot - basic
qplot(x = Artist, y = Streams, data = spotifyScraped, geom = "point")
qplot(x = Artist, y = Streams, data = spotifyAR, geom = "point")


#histograms

library(dplyr)
library(ggplot2)
#top ten artists based on streams - ggplot
top_n(spotifyScraped, n=10, Streams) %>%
  ggplot(., aes(x = Artist, y = Streams))+
  geom_bar(stat='identity')

top_n(spotifyAR, n=10, Streams) %>%
  ggplot(., aes(x = Artist, y = Streams))+
  geom_bar(stat='identity')

#needs to be fixed
library("reshape2")
library("ggplot2")
top_n(spotifyScraped, n=10, Streams) %>%
ggplot(., aes(x=Streams, y=Artist)) +
  geom_line(stat=)

#barplot
barplot(spotifyScraped$Streams)

#line chart
plot(spotifyScraped$Streams, type = "o", col = "blue", xlab = "Artist", ylab = "Streams") 
lines(spotifyAR$Streams, type = "o", col = "red")

ggplot(data=spotifyScraped, aes(x=Artist, y=Streams, colour = "green")) +
  geom_line() +
  geom_point( size=4, shape=21, fill="white")

plot(spotifyScraped$Streams, factor(spotifyScraped$Artist), type = "b", frame = FALSE, pch = 19, 
     col = "red", xlab = "x", ylab = "y") 
lines(spotifyAR$Streams, factor(spotifyAR$Artist), pch = 18, col = "red", type = "b", lty = 2)

plot(spotifyAR$Streams, factor(spotifyAR$Artist), type = "b", frame = FALSE, pch = 19, 
     col = "blue", xlab = "x", ylab = "y")

################
#  word cloud  #
################

library(tm)
library(SnowballC)
library(RColorBrewer)
library(wordcloud)

mergedSpotify.Corpus<-Corpus(VectorSource(mergedSpotify$Artist))
mergedSpotify.Clean<-tm_map(mergedSpotify.Corpus, PlainTextDocument)
mergedSpotify.Clean<-tm_map(mergedSpotify.Corpus,tolower)
mergedSpotify.Clean<-tm_map(mergedSpotify.Corpus,removeNumbers)
mergedSpotify.Clean<-tm_map(mergedSpotify.Corpus,removeWords,stopwords("english"))
mergedSpotify.Clean<-tm_map(mergedSpotify.Corpus,removePunctuation)
mergedSpotify.Clean<-tm_map(mergedSpotify.Corpus,stemDocument)
wordcloud(mergedSpotify.Clean,max.words = 200,random.color = TRUE,random.order=FALSE)
wordcloud(words = mergedSpotify.Clean, min.freq = 3,
          max.words=50, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(100, "Dark2"))


#########################
#                       #
#  map reduce analysis  #
#                       #
#########################

setwd("C:/Users/Alexander/OneDrive - National College of Ireland/4th Year/DataAppDev/Project/mapreduce/topFive")
spotifyMR <- read.delim("topFiveOutput.txt", header=FALSE)
spotifyMR <- (t(spotifyMR))
print(spotifyMR)

 



