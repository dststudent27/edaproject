# Exploratory Data Analysis, sep2015
# Coursera Project 2, plot 6
# p2plot6.R, p2plot6.png

# display date & time
todaysDate <- date()
print(todaysDate)

library(data.table)
library(ggplot2)
library(RDS)

# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips = "00637").
# Which city has seen greater changes over time in moter vehicle emissions?

# read the data
NEI <- readRDS("summaryPM25.rds")
SCC <- readRDS("scc.rds")

# subset the data ...
NEI$year <- factor(NEI$year, levels = c('1999', '2002', '2005', '2008'))
Baltimore.onroad <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
LACounty.onroad <- subset(NEI, fips == '06037' & type == 'ON-ROAD')

# sum emissions & aggregate the data
Baltimore.df <- aggregate(Baltimore.onroad[, 'Emissions'], by = list(Baltimore.onroad$year), sum)
colnames(Baltimore.df) <- c('year', 'Emissions')
Baltimore.df$City <- paste(rep('Maryland', 4))

LACounty.df <- aggregate(LACounty.onroad[, 'Emissions'], by = list(LACounty.onroad$year), sum)
colnames(LACounty.df) <- c('year', 'Emissions')
LACounty.df$City <- paste(rep('California', 4))

df <- as.data.frame(rbind(Baltimore.df, LACounty.df))

# create & save the plot
png('p2plot6.png')
E <- ggplot(data = df, aes(x = year, y = Emissions)) + 
    ggtitle('Vehicle Source Emissions: LACounty, Baltimore City') + 
    geom_bar(aes(fill = year), stat = "identity") + 
    theme(legend.position = 'none') + 
    ylab(expression('PM'[2.5] * ' Emissions (kT)')) + 
    facet_grid(. ~ City) + 
    guides(fill = F) + 
    xlab('Year') +     
    geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = -1))
print(E)
dev.off()