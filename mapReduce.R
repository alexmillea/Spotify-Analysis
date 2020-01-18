#map reduce on top 200 - Global 

mapReduce <- spotifyScraped$Artist
print(mapReduce)

#check class
class(mapReduce)

#make all lowercase 
mapReduce <- tolower(mapReduce)

#remove fullstops and hyphen
gsub('\\.', '-', mapReduce)

#numerics
gsub('[0-9]+', '', mapReduce)

#remove @ *.
mapReduce<-gsub("@.*","", mapReduce)

#remove ascii - double check it has worked
iconv(mapReduce, "latin1", "ASCII", sub="")

#remove whitespaces
gsub(" ", "", mapReduce)


#break into 4 files and save to .txt files
spotifyOne <- mapReduce[1:50]
spotifyTwo <- mapReduce[51:100]
spotifyThree <- mapReduce[101:150]
spotifyFour <- mapReduce[151:200]

spotifyOne <- as.character(spotifyOne)
spotifyTwo <- as.character(spotifyTwo)
spotifyThree <- as.character(spotifyThree)
spotifyFour <- as.character(spotifyFour)

#remove whitespaces
spotifyOne <- gsub(" ", "", spotifyOne)
spotifyTwo <- gsub(" ", "", spotifyTwo)
spotifyThree <- gsub(" ", "", spotifyThree)
spotifyFour <- gsub(" ", "", spotifyFour)

write(spotifyOne, file = "spotifyOne.txt", append = FALSE, sep = "")
write(spotifyTwo, file = "spotifyTwo.txt", append = FALSE, sep = " ")
write(spotifyThree, file = "spotifyThree.txt", append = FALSE, sep = " ")
write(spotifyFour, file = "spotifyFour.txt", append = FALSE, sep = " ")



