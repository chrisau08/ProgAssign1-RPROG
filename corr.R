corr <- function(directory, threshold = 0) {
  ## 'directory' will take in the path to the folder where the csv
  ## files are located.
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Use the cor function. To understand the cor function type ?cor 
  ## in to the console window.
  
  ## Initialize the numeric vector.
  corVals <- vector("numeric")
  
  ## The design is to perform a cor() against each data set that has a 
  ## number of complete cases greater than the threshold.
  
  ## Use the function, complete, to provide ids with the number of complete
  ## cases. Assign that to ID.
  source("complete.R")
  ID <- complete("specdata")
  
  ## Create a subset of ID that includes only the number of complete cases,
  ## nobs, greater than the threshold.
  Thresh <- subset(ID, ID$nobs > threshold)
  
  for(i in Thresh$id) {
    ## Concatenate the full path including file name.
    fullPath <- paste(directory,          ##User provided path.
                      "/",                ##Separate folder from file.
                      sprintf("%03d", i), ##Pad id with 0 to three chars.
                      ".csv",             ##Add the file extension.
                      sep = "")           ##Place no space between items.
    
    ## Read the full path in to curSet data frame
    curSet <- data.frame(read.csv(fullPath))
    
    ## Store the correlation value
    cval <- cor(curSet$sulfate, curSet$nitrate, use = "complete.obs")
    
    ## Add the correlation value to the next column
    corVals <- c(corVals, cval)
  }
  
  ## Return a numeric vector of correlations for the monitors 
  ## NOTE: Do not round the result!
  corVals
}