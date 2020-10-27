library(data.table)
library(magrittr)
library(geosphere)
library(sf)
library(dplyr)

source("findMinDist.R")
source("scanExport.R")
#################
mainMinDist = function(sourceDataDir, targetDir, tempDir, outDir, successDir, failDir){
  
  if(length(list.files(targetDir)) == 0){
    cat(format(Sys.time(), usetz = T), ": ", "No File \n")
  }else{
    sourceData <- fread(sourceDataDir)
    allFiles <- list.files(targetDir, pattern = ".csv", full.names = T, recursive = T)
    
    
    for (file in allFiles) {
      t1 <- Sys.time()
      cat(format(Sys.time(), usetz = T), ": ")
      cat(file)
      result <- try(scanExport(file, sourceData, tempDir, outDir, successDir, failDir))
      if(class(result) == "try-error"){
        cat(" => failed!", "\n")
      }else{
        cat(" => Succeeded. Time spent: ",format(Sys.time() - t1, usetz = T), "\n")
      }
      
    }
    
    
  }
  
  
  
}
  
