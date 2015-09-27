# Exploratory Data Analysis, lajr sep2015
# Coursera Project 2, plot 2
# p2plot2.R, p2plot2.png

# display date & time
todaysDate <- date()
print(todaysDate)

# Have total emmissions from PM2.5 decreased in Baltimore City, MD 
# (fips == "24510") from 1999 to 2008?  
# Using the base plotting system, display the total PM2.5 emmissions 
# for the selected time period.

# read the data
NEI <- readRDS("summaryPM25.rds")
SCC <- readRDS("scc.rds")

# Subset the data, fips = 24510
RavenNation <- NEI[NEI$fips == '24510', ]
# str(ravenNation)

# Sum the total emmissions per selected parameters
totalEmissions <- tapply(RavenNation$Emissions, RavenNation$year, sum)

# Create & save the plot
png("p2plot2.png", height = 480, width = 480)
barplot(totalEmissions,       
        main  = "Total PM2.5 Emissions, RavensNation, MD",
        xlab  = "Year",
        ylab  = "PM2.5")
dev.off()