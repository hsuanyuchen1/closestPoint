library(data.table)
library(magrittr)
library(geosphere)
library(sf)
library(dplyr)

source("c:/Work/Operators/TWM/MDT/phase2_itmes/closestPoint/rCode/findMinDist.R")
source("c:/Work/Operators/TWM/MDT/phase2_itmes/closestPoint/rCode/scanExport.R")
#################
#sourceDataDir <- "c:/Work/Operators/TWM/MDT/phase2_itmes/closestPoint/tw700.csv"

#targetDir <- "c:/Work/Operators/TWM/MDT/phase2_itmes/closestPoint/test/L700/"
#tempDir <- "c:/Work/Operators/TWM/MDT/phase2_itmes/closestPoint/test/pending/"
#outDir <- "c:/Work/Operators/TWM/MDT/phase2_itmes/closestPoint/test/output/"

#successDir <- "c:/Work/Operators/TWM/MDT/phase2_itmes/closestPoint/test/success/"
#failDir <- "c:/Work/Operators/TWM/MDT/phase2_itmes/closestPoint/test/fail/"
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
  
