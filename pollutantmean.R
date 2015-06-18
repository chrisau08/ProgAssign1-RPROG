pollutantmean <- function (directory, poluttant, id = 1:332) {
  ## 'directory' will take in the path to the folder where the csv
  ## files are located.
  
  ## 'poluttant' will take the name of the for the pollutant which
  ## will be either "sulfate" or "nitrate".
  
  ## 'id' will be a vector containing the ids that should be read.
  ## The default will be to read all of the ids.
  
  #Initialize empty data frame, mergeSet, to contain all merged data.
  bindSet <- data.frame(Date    = character(),
                        sulfate = numeric(),
                        nitrate = numeric(),
                        ID      = integer())
  
  #Use for loop to read in and bind each data set to the complete set.
  for (i in id) {
    ##Concatenate the full path including file name.
    fullPath <- paste(directory,          ##User provided path.
                      "/",                ##Separate folder from file.
                      sprintf("%03d", i), ##Pad id with 0 to three chars.
                      ".csv",             ##Add the file extension.
                      sep = "")           ##Place no space between items.
    
    ##Read the data set into the current data frame
    curSet <- data.frame(read.csv(fullPath))
    
    ##Bind the current data frame to the end of the complete data set.
    bindSet <- rbind(bindSet, curSet)
  }
  
  ## Return the mean for the pollutant across the complete set of ids.
  ## The value is not to be rounded and should ignore NA.
  if (poluttant == "sulfate") {
    mean(bindSet$sulfate, na.rm = TRUE)
  }
  else {
    mean(bindSet$nitrate, na.rm = TRUE)
  }
}