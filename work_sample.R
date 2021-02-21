#Katelyn Pease
#Guild Education Work Sample
#Reading in a csv file, breakdown of movie genres by year 


library(stringr)
library(readr)

#read in the csv file
dataset <- read.csv("~/Desktop/movies_metadata_sample.csv")

#create a new matrix to hold the breakdown of the file, only 3 columns 
new_dataset <- matrix(nrow = nrow(dataset), ncol = 3)
colnames(new_dataset) <- c("Year", "Genre", "Count") 

#insert relevant information into new matrix
new_dataset[,1] <- dataset$release_date
new_dataset[,2] <- dataset$genres
new_dataset[,3] <- dataset$vote_count

#breakdown information to be more compact 
for (row in 1:nrow(new_dataset)) {
  new_dataset[row, 1] <- substr(new_dataset[row, 1], 1, 4)
  new_dataset[row, 2] <- gsub("'name':", '', new_dataset[row, 2])
  new_dataset[row, 2] <- gsub("'id':", '', new_dataset[row, 2])
  new_dataset[row, 2] <- gsub('[0-9]+,', '', new_dataset[row, 2])
  new_dataset[row, 2] <- str_replace_all(new_dataset[row, 2], fixed(" "), "")
  new_dataset[row, 2] <- gsub("[{}]", "", new_dataset[row, 2] )
}

#order matrix based off of year
new_dataset <- new_dataset[order(new_dataset[1:nrow(new_dataset),1]),]
 
#create new csv file with complete breakdown
new_dataset <- as.data.frame(new_dataset)
new_dataset <- write_csv(new_dataset, "breakdown_by_year.csv", na="")
  
  
