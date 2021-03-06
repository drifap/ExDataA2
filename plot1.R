### plot 1

## Load data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

#################### Question 1 ################################################
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
## for each of the years 1999, 2002, 2005, and 2008.

# prepair data for plotting
plot.Q1 <- tapply(NEI$Emissions/1000000,NEI$year,sum)   # summarize in a vector

p1 <- ddply(NEI,.(year),                                # summarize in df
            summarize,
            Emissions=sum(Emissions)/1000000)

# create plot1 
png("plot1.png")                                         # open grapichs device

bp <- barplot(plot.Q1, col=heat.colors(4),               # create hist and set color
              ylim=c(0, 8),                              # set limits for y axis
              xlab="Year",                               # label X
              ylab="PM2.5 emission (millions of tons)",  # label y
              main="Total PM2.5 emission per year")      # Annote histagram

text(bp, 2,                                              # text inside bars
     format(p1$Emissions, digits = 3),                   # set format for text
     xpd=TRUE, 
     col="black")                                        # color of text


dev.off()                                                # close graphics device 
