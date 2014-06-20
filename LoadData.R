## Assignment 2 - load data

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")


SCC$SCC <- as.character(SCC$SCC)                                # factor to character to match NEI variable
names <- SCC[,c(1,3:4)]                                           # extract the two variables need for joining
joined <- join(NEI,names,by="SCC")                              # join names with NEI df 
