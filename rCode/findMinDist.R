library(data.table)
library(magrittr)
library(geosphere)
library(sf)
library(dplyr)

#sourceData
#point: 1 row data.table with lon & lat  as columns
findMinDist = function(sourceData, point){
  #100 meter
  sRing = 0.001
  
  #print(point)
  #only keep data points within search ring 
  temp <- sourceData[LONGITUDE < (point$lon + sRing) &
                       LONGITUDE > (point$lon - sRing) &
                       LATITUDE < (point$lat + sRing) &
                       LATITUDE > (point$lat - sRing)]
  if(nrow(temp) == 0){
    temp <- matrix(nrow = 1, ncol = 3) %>% as.data.table()
    colnames(temp) <- c("AVGRSRP",  "eNbLncell", "distanceM")
    #cbind is used to adpat all the columns except lon/lat from target csv, so all the columns 
    #from target csv will be kept
    result <- cbind(point, temp)
    return(result)
  }else{
    temp$lon <- point$lon
    temp$lat <- point$lat
    distanceM <- lapply(1:nrow(temp), 
                        function(x) round(distCosine(c(temp$LONGITUDE[x], temp$LATITUDE[x]),
                                                     c(temp$lon[x], temp$lat[x])),1)) %>% unlist()
    
    temp <- cbind(temp, distanceM)
    temp <- temp[,.(lon, lat, AVGRSRP, MODEECI, distanceM)]
    temp <- temp[which.min(distanceM)]
    temp$eNbLncell <- paste(floor(temp$MODEECI/256), temp$MODEECI %% 256, sep = "-")
    temp$AVGRSRP <- round(temp$AVGRSRP,1)
    #cbind is used to adpat all the columns except lon/lat from target csv, so all the columns 
    #from target csv will be kept
    result <- cbind(point, temp[,.(AVGRSRP, eNbLncell, distanceM)])
    return(result)
  }
  
  
}
