# Exploratory Data Analysis, lajr sep2015
# Coursera Project 2, plot 5
# p2plot5.R, p2plot5.png

# display date & time
todaysDate <- date()
print(todaysDate)

library(data.table)
library(ggplot2)
library(RDS)

# How have emissions from motor vehicles changed from 1999-2008 in Baltimore City?

# read the data
NEI <- readRDS("summaryPM25.rds")
SCC <- readRDS("scc.rds")

# Subset the data, fips = 24510, type = on_road
BaltoMD.OnRoad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')
NEI$year <- factor(NEI$year, levels = c('1999', '2002', '2005', '2008'))
BaltoMD.df <- aggregate(BaltoMD.OnRoad[, 'Emissions'], by = list(BaltoMD.OnRoad$year), sum)
colnames(BaltoMD.df) <- c('year', 'Emissions')

# Create & save the plot
png("p2plot5.png", height = 550, width = 550)
E <- ggplot(data = BaltoMD.df, aes(x = year, y = Emissions)) +
    ggtitle('PM2.5 Emissions, Motor Vehicles, Baltimore, MD, RavenNation') +
    geom_bar(stat = "identity", fill = "#4682B4") +
    theme(legend.position = 'none') +
    ylab(expression('PM'[2.5])) +
    xlab('Year') +
    geom_text(aes (label = round(Emissions, 0), face = "bold", hjust = 0.5, size = 1, vjust = 2))
print(E)
graphics.off()
