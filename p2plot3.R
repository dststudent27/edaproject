# Exploratory Data Analysis, lajr sep2015
# Coursera Project 2, plot 3
# p2plot3.R, p2plot3.png

# display date & time
todaysDate <- date()
print(todaysDate)

# Of the four types of sources indocated by the type variable, which of these 
# four sources have seen decreases in emissions from 1999-2008?  Use ggplot2 
# plotting system to determine the answer.

# preliminaries
library(data.table)
library(ggplot2)
library(RDS)

# read the data 
NEI <- readRDS("summaryPM25.rds")
SCC <- readRDS("scc.rds")

# assign to a data table
dtNEI <- data.table(NEI)
dtSCC <- data.table(SCC)

# sort selected columns of the data table
setkey(dtNEI, fips, year, SCC, type)
setkey(dtSCC, EI.Sector)

# sum PM2.5 emissions per fips by the keys 'type' & 'year', ordered by year
dtRaven <- dtNEI[fips == "24510", list (emissions = sum(Emissions)), by = list (year, type)]
dtRaven <- dtRaven[order(dtRaven$year)]

# create & save the plot
png("p2plot3.png", height = 800, width = 600)
p <- ggplot(dtRaven, aes(x = year, y = emissions, col = type)) + geom_line(size = 1.5)
p <- p + ggtitle("PM2.5 Emissions, Baltimore, Maryland, RavenNation")
p <- p + scale_color_manual(values = c("#00CD33", "#3300CD", "#000000", "#FF00FF"))
p <- p + xlab("Year") + ylab("PM[2.5] Emissions")
print(p)
dev.off()