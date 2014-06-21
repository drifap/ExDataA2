## Assignment 2 - load data
library(plyr)


NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")


SCC$SCC <- as.character(SCC$SCC)                                # factor to character to match NEI variable
joined <- join(NEI,SCC,by="SCC")                                # join SCC with NEI df 
