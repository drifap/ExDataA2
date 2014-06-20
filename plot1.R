## plot 1

source(file="load_data.R")

#################### Question 1 ################################################
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
## for each of the years 1999, 2002, 2005, and 2008.

# prepair data for plotting
plot.Q1 <- tapply(NEI$Emissions/1000,NEI$year,sum)

# create function for plot1 
plot1 <- function(){
        png("plot1.png")                                   # open grapichs device
        barplot(plot.Q1, col=topo.colors(4),                 # create hist and set colour
                xlab="Year",                               # label X
                ylab="PM2.5 emission in tons",             # label y
                main="Total PM2.5 emission per year")      # Annote histagram
        dev.off()                                          # close graphics device 
}

plot1()                                                    # use function to save graph to file
