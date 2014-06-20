## Plot 5

source(file="load_data.R")
require(ggplot2)
require(plyr)


######################## Question 5 ############################################
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?


# prepair data for plotting
balt <- subset(joined,joined$fips=="24510")                            # subset with only baltimore city

mobile <- subset(balt,
               grepl("Mobile - On-Road",balt$EI.Sector,ignore.case=T))   # use grepl instead of grep for subsetting - as subset must be logical


mobile2 <- ddply(mobile,.(year),                                    # summarize data by year - could also use aggregate
               summarize,                                      # if aggregate then you need to set names for col
               Emissions=sum(Emissions))  


## create plot5 
png("plot5.png", width=600,height=600)                           # open grapichs device


qplot(year, Emissions, data=mobile2)+                                                  # start with qplot
        geom_point(col="darkblue", size=3)+                                            # set points - color and size
        geom_smooth(method="lm",col="orange")+                                         # set lm line and color
        ylab("PM2.5 emissions in kilotons") +                                          # label Y axis
        xlab("Year")+                                                                  # label X axis
        ggtitle("Emissions from Motor Vehicles in Baltimore city from 1999-2008")      # Annote plot


dev.off()                                                       # close graphics device 