## Plot 2

source(file="load_data.R")

####################### Question 2 ##############################################
## Have total emissions from PM2.5 decreased in the Baltimore City, 
## Maryland (fips == "24510") from 1999 to 2008?
## Use the base plotting system to make a plot answering this question.

# prepair data for plotting
df2 <- subset(NEI,NEI$fips=="24510")                     # subset with only baltimore city

plot.Q2 <- tapply(df2$Emissions/1000,df2$year,sum)

# create function for plot1 
plot2 <- function(){
        png("plot2.png")                                     # open grapichs device
        barplot(plot.Q2, col=topo.colors(4),                 # create hist and set colour
                xlab="Year",                                 # label X
                ylab="PM2.5 emission in tons",               # label y
                main="Baltimore City total PM2.5 emission")  # Annote histagram
        dev.off()                                            # close graphics device 
}

plot2()                                                      # use function to save graph to file
