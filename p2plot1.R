# Exploratory Data Analysis, lajr sep2015
# Coursera Project 2, plot 1
# p2plot1.R, p2plot1.png

# display date & time
todaysDate <- date()
print(todaysDate)

# read the data
NEI <- readRDS("summaryPM25.rds")
SCC <- readRDS("scc.rds")

# Have total emissions from PM2.5 decreased in the US from 1999-2008?
# Using the base plotting system, display the total PM2.5 emmissions 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

# sum total PM2.5 emissions per selected parameters
emissionsPM25 <- tapply(NEI$Emissions, NEI$year, sum)

# create & save plot of the result
png("p2plot1.png", height = 480, width = 480)
barplot(emissionsPM25,
        main = "Total Yearly PM2.5 Emissions, US",
        ylab  = "PM2.5",
        xlab  = "Year")
graphics.off()

