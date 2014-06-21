### Plot 5

## Load data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

## load packages
require(ggplot2)
require(plyr)


######################## Question 5 ############################################
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?


## prepair data for plotting
SCC$SCC <- as.character(SCC$SCC)                            # factor to character to match NEI variable
joined <- join(NEI,SCC,by="SCC")                            # join SCC with NEI df 

balt <- subset(joined,joined$fips=="24510")                 # subset with only baltimore city

mobile <- subset(balt,
               grepl("veh",balt$EI.Sector,ignore.case=T))   # use grepl instead of grep for subsetting - as subset must be logical


## Aggregate data
mob_2 <- aggregate(mobile$Emissions,                        # aggregate emissions by type and year
                    list(Year=mobile$year,                  # rename year Year
                         Type=mobile$SCC.Level.Two),        # rename level.two Type
                    sum)                                         
colnames(mob_2)[3] <- "Total"                               # name aggregated col


## find types with less than 1 in total & reaggregate 
mob_2$Type <- as.character(mob_2$Type)                      # type into character 
mob_2[mob_2$Total < 1, "Type"] <- "Other"                   # if total is less than 1 then type cat should be other 
mob_2$Type <- factor(mob_2$Type)                            # Type into factor

mob_2 <- aggregate(mob_2$Total,                             # reaggregate to drop less than 1 types 
                    list(Year=mob_2$Year,       
                         Type=mob_2$Type), sum)
colnames(mob_2)[3] <- "Total"                               # name aggregated col


## create plot5 
png("plot5.png", width=600,height=600)                           # open grapichs device

ggplot(mob_2,aes(factor(Year), Total))+                          # start with qplot
        facet_grid(.~Type)+                                      # set facet so each city has a grid
        geom_bar(aes(fill=Type),stat = "identity")+              # set bar chart 
        guides(fill=F)+                                          # remove legend                    
        ylab("PM2.5 emissions in kilotons") +                    # label Y axis
        xlab("Year")+                                            # label X axis
        ggtitle("Emissions from Motor Vehicles in Baltimore city from 1999-2008")+
        geom_text(data=mob_2,                                    # set text for bar label
                  aes(label=format(Total, digits=2)),
                  position = position_dodge(width = 0.8), 
                  vjust=-0.40,
                  size=4)

dev.off()                                                        # close graphics device 