### Plot 6

## Load data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

## load packages
require(ggplot2)
require(plyr)


######################## Question 6 ############################################
## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los
## Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle
## emissions?


## prepair data for plotting
SCC$SCC <- as.character(SCC$SCC)                                        # factor to character to match NEI variable
joined <- join(NEI,SCC,by="SCC")                                        # join SCC with NEI df 

balt_la <- subset(joined,joined$fips%in%c("06037","24510"))             # subset with baltimore city & LA

balt_la$City <- factor(balt_la$fips)                                    # fips into factor and name levels
levels(balt_la$City) <- c("Los Angeles County","Baltimore City")
balt_la$City <- relevel(balt_la$City,ref = "Baltimore City")

mobile <- subset(balt_la,
                 grepl("veh",balt_la$EI.Sector,ignore.case=T))          # use grepl instead of grep for subsetting


## Aggregate data
mob_3 <- aggregate(mobile$Emissions,                                    # aggregate emissions by type and year
                   list(Year=mobile$year,                               # rename year Year
                        Type=mobile$SCC.Level.Two,                      # rename level.two Type
                        City=mobile$City),                              # rename City City
                   sum)                                         
colnames(mob_3)[4] <- "Total"                                           # name aggregated col


## find types with less than 1 in total & reaggregate 
mob_3$Type <- as.character(mob_3$Type)                                  # Type into character 
mob_3[mob_3$Total < 1, "Type"] <- "Other"                               # if total is less than 1 then type cat should be other 
mob_3$Type <- factor(mob_3$Type)                                        # Type into factor

mob_3 <- aggregate(mob_3$Total,                                         # reaggregate to drop less than 1 types 
                   list(Year=mob_3$Year,       
                        Type=mob_3$Type,
                        City=mob_3$City), sum)
colnames(mob_3)[4] <- "Total"                                           # name aggregated col 


## create plot6 
png("plot6.png", width=800,height=600)                           # open grapichs device

ggplot(mob_3,aes(factor(Year), Total))+                          # start with plot
        facet_grid(.~Type)+                                      # set facet so each city has a grid
        geom_bar(aes(fill=City),                                 # set bar chart
                 stat="identity",
                 position="dodge")+                              # set bars to be side by side
        ylab("PM2.5 emissions in kilotons") +                    # label Y axis
        xlab("Year")+                                            # label X axis
        ggtitle("Comparison of Motor Vehicles Emissions in Baltimore city & Los Angeles County")+
        geom_text(data=mob_3[mob_3$City=="Baltimore City",],     # set text for bar label BC
                  aes(label=format(round(Total),1),digits=2),    # what numbers to use
                  position = position_dodge(width = 0.7),        
                  vjust=-0.4,                                    # adjusting vertical alignm of text
                  hjust=1.4,                                     # adjusting horizontal alignm of text
                  size=4)+                                       # size of text
        geom_text(data=mob_3[mob_3$City=="Los Angeles County",], # set text for bar label LAC
                  aes(label=format(round(Total),1),digits=2),    # what numbers to use
                  position = position_dodge(width = 0.7), 
                  vjust=-0.4,                                    # adjusting vertical alignm of text
                  hjust=0,                                       # adjusting horizontal alignm of text
                  size=4)                                        # size of text



dev.off()                                                        # close graphics device 
