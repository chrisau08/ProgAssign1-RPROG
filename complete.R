complete <- function(directory, id = 1:332) {
  ## 'directory' will take in the path to the folder where the csv
  ## files are located.
  
  ## 'id' will be a vector containing the ids that should be read.
  ## The default will be to read all of the ids.
  
  ## Initialize data frame for the results.
  resultFrame <- data.frame(id   = numeric(),
                            nobs = numeric())
  
  ## Use for loop to read in and bind each data set to the complete set.
  for (i in id) {
    ## Concatenate the full path including file name.
    fullPath <- paste(directory,          ##User provided path.
                      "/",                ##Separate folder from file.
                      sprintf("%03d", i), ##Pad id with 0 to three chars.
                      ".csv",             ##Add the file extension.
                      sep = "")           ##Place no space between items.
    
    ## Read the data set into the current data frame
    curSet <- data.frame(read.csv(fullPath))
    
    ## Count the rows where sulfate and nitrate are not NA
    nobs <- nrow(subset(curSet,
                        complete.cases(curSet)))
    
    resultFrame <- rbind(resultFrame, data.frame(id = i, nobs = nobs))
  }
  
  ## Return data frame with headers "id" and "nobs" where "id"is the
  ## Monitor ID Number and "nobs" is the number complete cases.
  resultFrame
}