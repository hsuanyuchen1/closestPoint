source("c:/Work/Operators/TWM/MDT/phase2_itmes/closestPoint/rCode/mainMinDist.R")

sourceDataDir <- "c:/Work/Operators/TWM/MDT/phase2_itmes/closestPoint/tw700.csv"

targetDir <- "c:/Work/Operators/TWM/MDT/phase2_itmes/closestPoint/test/L700/"
tempDir <- "c:/Work/Operators/TWM/MDT/phase2_itmes/closestPoint/test/pending/"
outDir <- "c:/Work/Operators/TWM/MDT/phase2_itmes/closestPoint/test/output/"

successDir <- "c:/Work/Operators/TWM/MDT/phase2_itmes/closestPoint/test/success/"
failDir <- "c:/Work/Operators/TWM/MDT/phase2_itmes/closestPoint/test/fail/"


capture.output(mainMinDist(sourceDataDir, targetDir, tempDir, outDir, successDir, failDir),
               file = "c:/Work/Operators/TWM/MDT/phase2_itmes/closestPoint/log.txt", append = T)



