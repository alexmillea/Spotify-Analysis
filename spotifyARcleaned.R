#########################################################
#                                                       #
#    Kaggle Dataset Cleaning - loaded into project.     #  
#                                                       #
#########################################################
#set directory 
setwd("C:/Users/Alexander/OneDrive - National College of Ireland/4th Year/DataAppDev/Project")

spotifyAR <- read.csv("kaggleNew.csv", stringsAsFactors = FALSE, header = TRUE)
print(spotifyAR)

#load libraries
library(dplyr)
library(tidyverse) #general data wrangling
library(purrr)
library(scales)
library(lubridate) #date and time manipulation
library(tibble)
library(magrittr)

#print head & tail
head(spotifyAR)
tail(spotifyAR)

#Identify NA's
sapply(spotifyAR,function(x) sum(is.na(x)))

#remove columns and rows not needed (url & region)
ncol(spotifyAR)
spotifyAR <- spotifyAR[,-5] 
spotifyAR <- spotifyAR[,-6] 

#changing column names to match spotifyScraped datset
names(spotifyAR)[names(spotifyAR) == "ï..Position"] <- "Rank"
names(spotifyAR)[names(spotifyAR) == "Track.Name"] <- "Track"

#check class of columns
class(spotifyAR$Rank)
class(spotifyAR$Track)
class(spotifyAR$Artist)
class(spotifyAR$Streams)
class(spotifyAR$Date)

spotifyAR %<>% 
  mutate(Artist = gsub("by ", "", Artist), 
         Streams = gsub(",", "", Streams), 
         Streams = as.numeric(Streams), 
         Date = as.Date(spotifyAR$Date, "%m/%d/%Y"))

#display data
head(spotifyAR)

#save to csv
write.csv(spotifyAR, 'spotifyARcleaned.csv')

