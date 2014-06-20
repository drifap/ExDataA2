## Plot 4

source(file="load_data.R")
require(ggplot2)                          
require(plyr)

######################## Question 4 ############################################
### Across the United States, how have emissions from 
### coal combustion-related sources changed from 1999–2008?


## prepair data for plotting
## create subset - using subset is quicker that []
# coal <- joined[grep("Coal", joined$Short.Name,ignore.case = T),]

coal <- subset(joined,
               grepl("Coal",joined$Short.Name,ignore.case=T))   # use grepl instead of grep for subsetting - as subset must be logical

coal2 <- ddply(coal,.(year),                                    # summarize data by year - could also use aggregate
                summarize,                                      # if aggregate then you need to set names for col
                Emissions=sum(Emissions))                  


## create plot4 
png("plot4.png", width=600,height=600)                           # open grapichs device


qplot(year, Emissions, data=coal2)+                                         # start with qplot
        geom_point(col="darkblue", size=3)+                                 # set points - color and size
        geom_smooth(method="lm",col="orange")+                              # set lm line and color
        ylab("PM2.5 emissions in kilotons") +                               # label Y axis
        xlab("Year")+                                                       # label X axis
        ggtitle("Emissions from coal combustion in US from 1999-2008")      # Annote plot



dev.off()                                                       # close graphics device 

