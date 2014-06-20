## plot 1

source(file="load_data.R")

#################### Question 1 ################################################
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
## for each of the years 1999, 2002, 2005, and 2008.

# prepair data for plotting
plot.Q1 <- tapply(NEI$Emissions/1000000,NEI$year,sum)


# create plot1 
png("plot1.png")                                   # open grapichs device

bp <- barplot(plot.Q1, col=heat.colors(4),               # create hist and set colour
              ylim=c(0, 8),
              xlab="Year",                               # label X
              ylab="PM2.5 emission (millions of tons)",             # label y
              main="Total PM2.5 emission per year")      # Annote histagram

text(bp, 2, format(p1$Emissions, digits = 3), xpd=TRUE, col="black") 


dev.off()                                          # close graphics device 
