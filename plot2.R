## Plot 2

source(file="load_data.R")

####################### Question 2 ##############################################
## Have total emissions from PM2.5 decreased in the Baltimore City, 
## Maryland (fips == "24510") from 1999 to 2008?
## Use the base plotting system to make a plot answering this question.

## prepair data for plotting
df2 <- subset(NEI,NEI$fips=="24510")                       # subset with only baltimore city

plot.Q2 <- tapply(df2$Emissions/1000,df2$year,sum)         # summarize in vector

p2 <- ddply(df2,.(year),                                   # summarize in df
            summarize,
            Emissions=sum(Emissions)/1000)

## create function for plot1 
png("plot2.png")                                           # open grapichs device


bp <- barplot(plot.Q2, col=heat.colors(4),                 # create hist and set colour
              ylim=c(0,4),                                 # set y axis limits
              xlab="Year",                                 # label X
              ylab="PM2.5 emission (thousands of tons)",   # label y
              main="Baltimore City total PM2.5 emission")  # Annote histagram

text(bp, 1,                                              # text inside bars & 1.5 for placement of text by axis value
     format(p2$Emissions, digits=3),                       # set format for text
     xpd=T, 
     col="black")                                          # color of text


dev.off()                                                  # close graphics device 

