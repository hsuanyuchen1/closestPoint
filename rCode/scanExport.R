library(data.table)
library(magrittr)
library(geosphere)
library(sf)
library(dplyr)

source("c:/Work/Operators/TWM/MDT/phase2_itmes/closestPoint/rCode/findMinDist.R")

#sourceData is the 25mx25m CSV with whole taiwan data

scanExport = function(targetDir, sourceData, tempDir, outDir, successDir, failDir){
  
  target <- fread(targetDir)
  #move the file to failDir first
  file.copy(targetDir, paste(failDir, basename(targetDir)))
  file.remove(targetDir)
  
  results <- lapply(1:nrow(target), function(x) findMinDist(sourceData, target[x]) ) %>% rbindlist()
  
  resultSF <- st_as_sf(results, coords = c("lon", "lat"), crs=4326)
  resultSF$OGR_STYLE <- case_when(resultSF$AVGRSRP >= -85 ~ "SYMBOL(a:0,c:#0000FF,s:12pt,id:ogr-sym-4)",
                                  resultSF$AVGRSRP >= -95 ~ "SYMBOL(a:0,c:#008000,s:12pt,id:ogr-sym-4)",
                                  resultSF$AVGRSRP >= -105 ~ "SYMBOL(a:0,c:#D2D250,s:12pt,id:ogr-sym-4)",
                                  resultSF$AVGRSRP >= -115 ~ "SYMBOL(a:0,c:#FFBE78,s:12pt,id:ogr-sym-4)",
                                  resultSF$AVGRSRP < -115 ~ "SYMBOL(a:0,c:#FF0000,s:12pt,id:ogr-sym-4)")
  
  fileName <- tools::file_path_sans_ext(basename(targetDir))
  
  #write files to temp folder  
  fwrite(results, paste0(tempDir, fileName, "_result.csv"))
  st_write(resultSF, paste0(tempDir, fileName, "_result.TAB"), driver = "MapInfo File", quiet=T)
  
  #zip csv and TAB to outDir
  zip(paste0(outDir, fileName,"_result.zip"),list.files(tempDir, full.names = T), 
      flags = " a -tzip", zip = "C:\\Program Files\\7-Zip\\7z")
  
  #remove all the files from temp folder
  file.remove(list.files(tempDir, full.names = T))
  
  #move the file to success folder if everything went well
  file.copy(paste(failDir, basename(targetDir)), paste(successDir, basename(targetDir)))
  file.remove(paste(failDir, basename(targetDir)))
}