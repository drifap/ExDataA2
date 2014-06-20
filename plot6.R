## Plot 6

source(file="load_data.R")
require(ggplot2)
require(plyr)


######################## Question 6 ############################################
## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los
## Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle
## emissions?


## prepair data for plotting
balt_la <- subset(joined,joined$fips=="24510"|joined$fips=="06037")           # subset with baltimore city & LA

balt_la$City <- factor(balt_la$fips,                                          # fips into factor and name levels
                       levels=c("Los Angeles County","Baltimore City"))


mobile <- subset(balt_la,
                 grepl("Mobile - On-Road",balt_la$EI.Sector,ignore.case=T))   # use grepl instead of grep for subsetting - as subset must be logical

mobile$yearF <- factor(mobile$year)                                           # year into factor

mobile2 <- ddply(mobile,.(year,City,yearF),                                   # summarize data by year - could also use aggregate
                 summarize,                                                   # if aggregate then you need to set names for col
                 Emissions=sum(Emissions)) 


## create plot6 
png("plot6.png", width=600,height=600)                          # open grapichs device


qplot(yearF, Emissions, data=mobile2)+                          # start with qplot
        facet_grid(.~City)+                                     # set facet so each city has a grid
        geom_bar(aes(fill=City),stat = "identity")+             # set bar chart 
        guides(fill=F)+                                         # remove legend                    
        ylab("PM2.5 emissions in kilotons") +                   # label Y axis
        xlab("Year")+                                           # label X axis
        ggtitle("Comparison of Motor Vehicles Emissions in Baltimore city & Los Angeles County")      # Annote plot


dev.off()                                                       # close graphics device 

