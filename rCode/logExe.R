source("mainMinDist.R")

sourceDataDir <- "tw700.csv"

targetDir <- "closestPoint/test/L700/"
tempDir <- "closestPoint/test/pending/"
outDir <- "closestPoint/test/output/"

successDir <- "closestPoint/test/success/"
failDir <- "closestPoint/test/fail/"


capture.output(mainMinDist(sourceDataDir, targetDir, tempDir, outDir, successDir, failDir),
               file = "closestPoint/log.txt", append = T)



