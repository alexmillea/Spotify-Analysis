#########################
#   scraping script     #
########################


#install libraries -  working 
library(rvest) #parsing html/xml files
library(tidyverse) #general data wrangling
library(purrr)
library(scales)
library(lubridate) #date and time manipulation
library(tibble)
library(magrittr) 


#set url
url <- 'https://spotifycharts.com/regional/global/daily/'

timevalues <- seq(as.Date("2018/12/08"), as.Date("2018/12/08"), by="day")
timevalues[1:3]

unitedata <- function(x){
  full_url <- paste0(url, x)
  full_url
}

finalurl <- unitedata(timevalues)

SpotifyScrape <- function(x){
  page <- x
  rank <- page %>% read_html() %>% html_nodes('.chart-table-position') %>% html_text() %>% as.data.frame()
  track <- page %>% read_html() %>% html_nodes('strong') %>% html_text() %>% as.data.frame()
  artist <- page %>% read_html() %>% html_nodes('.chart-table-track span') %>% html_text() %>% as.data.frame()
  streams <- page %>% read_html() %>% html_nodes('td.chart-table-streams') %>% html_text() %>% as.data.frame()
  dates <- page %>% read_html() %>% html_nodes('.responsive-select~ .responsive-select+ .responsive-select .responsive-select-value') %>% html_text() %>% as.data.frame()
  
  #combine, name, and make it a tibble
  chart <- cbind(rank, track, artist, streams, dates)
  names(chart) <- c("Rank", "Track", "Artist", "Streams", "Date")
  chart <- as.tibble(chart)
  return(chart)
}

#using purrr to combine final url and spotifyscrap and store
spotify <- map_df(finalurl, SpotifyScrape)

