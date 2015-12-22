pollutantmean <- function(directory, pollutant, id = 1:332) { 

  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  ## NOTE: Do not round the result!
  
  monitors <- list.files(file.path(getwd(), directory))
  total = 0
  
  #Get that data into memory
  for (monitor in monitors[id]) {
    # If main data frame don`t exist, load into it
    if(!exists("airpolution")){
      airpolution <- read.csv(file.path(directory, monitor), header = TRUE,na.strings=c("NA","NaN", " ") )
      #cat("Reading ", monitor, " into airpolution\n")
      next
    }
    
    #If main data frame exists, load into a temporary one and then concatenate those d'frames
    if(exists("airpolution")) {
      temp_dataset <- read.csv(file.path(directory, monitor), header = TRUE,na.strings=c("NA","NaN", " ") )
      #cat("Reading ", monitor, " into temp_dataset\n")
      
      airpolution <- rbind(airpolution, temp_dataset)
      rm(temp_dataset)
    }
  }
  
  mean(airpolution[[pollutant]],na.rm = TRUE)
}
