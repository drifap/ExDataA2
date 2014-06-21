### Plot 4

## Load data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

## load packages
require(ggplot2)                          
require(plyr)

######################## Question 4 ############################################
### Across the United States, how have emissions from 
### coal combustion-related sources changed from 1999–2008?


## prepair data for plotting
SCC$SCC <- as.character(SCC$SCC)                                # factor to character to match NEI variable
joined <- join(NEI,SCC,by="SCC")                                # join SCC with NEI df 


## create subset - using subset is quicker that []
coal <- subset(joined,
               grepl("Coal",joined$Short.Name,ignore.case=T))   # use grepl instead of grep for subsetting - as subset must be logical
              

## Aggregate data
coal_2 <- aggregate(coal$Emissions,                              # aggregate emissions by type and year
                    list(Year=coal$year,                         # rename year Year
                         Type=coal$SCC.Level.One),               # rename level.one Type
                    sum)                                         
colnames(coal_2)[3] <- "Total"                                   # name aggregated col
coal_2$Total  <-  coal_2$Total/1000                              # divide by 1000


## find types with less than 1 in total & reaggregate 
coal_2$Type <- as.character(coal_2$Type)                         # type into character 
coal_2[coal_2$Total < 1, "Type"] <- "Other"                      # if total is less than 1 then type cat should be other 
coal_2$Type <- factor(coal_2$Type)                               # Type into factor

coal_2 <- aggregate(coal_2$Total,                                # reaggregate to drop less than 1 types 
                    list(Year=coal_2$Year,       
                         Type=coal_2$Type), sum)
colnames(coal_2)[3] <- "Total"                                   # name aggregated col 

## create plot4 
png("plot4.png", width=800,height=600)                           # open grapichs device


qplot(factor(Year), Total, data=coal_2)+                         # start with qplot
        facet_grid(.~Type)+                                      # set facet so each city has a grid
        geom_bar(aes(fill=Type),stat = "identity")+              # set bar chart 
        guides(fill=F)+                                          # remove legend                    
        ylab("PM2.5 emissions (thousands of tons)") +                    # label Y axis
        xlab("Year")+                                            # label X axis
        ggtitle("Emissions from coal combustion in US from 1999-2008")+
        geom_text(data=coal_2,                                   # set text for bar label
                  aes(label=format(Total, digits=2)),
                  position = position_dodge(width = 0.8), 
                  vjust=-0.40,
                  size=3)


dev.off()                                                       # close graphics device 

