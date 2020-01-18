####################################################
#                                                  #
# data cleaning - if loading the data in from csv  #
#                                                  #
####################################################

#set directory 
setwd("C:/Users/Alexander/OneDrive - National College of Ireland/4th Year/DataAppDev/Project")
spotifyScraped <- read.csv("spotifyScraped.csv", stringsAsFactors = FALSE, headers = TRUE)
print(spotifyScraped)

######################################################
#if using the data straight away after being scraped #
######################################################

spotifyScraped <- spotify
print(spotifyScraped)

#Identify NA's
sapply(spotifyScraped,function(x) sum(is.na(x)))

#Delete NA's/Columns or Rows not needed
ncol(spotifyScraped); nrow(spotifyScraped)

#check class of columns
class(spotifyScraped$Rank)
class(spotifyScraped$Track)
class(spotifyScraped$Artist)
class(spotifyScraped$Streams)
class(spotifyScraped$Date)

#rank as int 
spotifyScraped$Rank <- as.integer(spotifyScraped$Rank)

#track as character 
spotifyScraped$Track <- as.character(spotifyScraped$Track)

#artist as character
spotifyScraped$Artist <- as.character(spotifyScraped$Artist)
spotifyScraped$Artist <- spotifyScraped$Artist(gsub("by ", "", spotifyScraped$Artist))

#remove 'by', commas, format year and replace white space
spotifyScraped %<>% 
  mutate(Artist = gsub("by ", "", Artist), 
         Streams = gsub(",", "", Streams), 
         Streams = as.numeric(Streams), 
         Date = as.Date(spotifyScraped$Date, "%m/%d/%Y"))
#if above code doesnt work use:
#library(magrittr)
#then re-run the code 

#display data
print(spotifyScraped)
head(spotifyScraped)


#save to new csv
write.csv(spotifyScraped, 'spotifyScrapedCleaned.csv')
write.csv(spotify, 'spotifyWebScrape.csv')
