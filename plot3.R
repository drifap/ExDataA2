### Plot 3

## Load data 
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

## load package
require(ggplot2)

######################## Question 3 ############################################
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
## variable, which of these four sources have seen decreases in emissions from 1999–2008 
## for Baltimore City? Which have seen increases in emissions from 1999–2008? 
## Use the ggplot2 plotting system to make a plot answer this question.


# prepair data for plotting
df2 <- subset(NEI,NEI$fips=="24510")                            # subset with only baltimore city
df2$year <- factor(df2$year)                                    # year into factor

# create plot3 

png("plot3.png", width=800,height=600)                          # open grapichs device
        
ggplot(df2, aes(year,log(Emissions),color=type))+               # set aes - log for clarity - color by type
        geom_boxplot()+                                         # set type of plot to boxplot
        stat_boxplot(geom="errorbar")+                          # set error bars for boxplot
        facet_grid(.~type)+                                     # set facet so each type has a grid
        ylab("PM2.5 Log-emissions") +                           # label Y axis
        xlab("Year")+                                           # label X axis
        ggtitle("Baltimore City PM2.5 emissions per type")      # Annote plot
        
dev.off()                                                       # close graphics device 
