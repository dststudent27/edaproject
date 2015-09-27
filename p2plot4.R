# Exploratory Data Analysis, lajr sep2015
# Coursera Project 2, plot 4
# p2plot4.R, p2plot4.png

# display date & time
todaysDate <- date()
print(todaysDate)

library(data.table)
library(ggplot2)
library(RDS)

# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999-2008 in Baltimore City?

# read the data
NEI <- readRDS("summaryPM25.rds")
SCC <- readRDS("scc.rds")

# aggregate source emissions
names(SCC) <- gsub("\\.","", names(SCC))
coalSSC <- grepl(pattern = "coal", SCC$SCCLevelFour, ignore.case = TRUE)
combSSC <- grepl(pattern = "comb", SCC$SCCLevelOne, ignore.case = TRUE)
combinedSSC <- SCC[coalSSC & combSSC, ]$SCC
combinedNEI <- NEI[NEI$SCC %in% combinedSSC, ]
combinedNEITotal <- aggregate(Emissions~year, combinedNEI, sum)

# create & save the plot
png("p2plot4.png", height = 400, width = 600)
hundThousth <- 0.00001
thousth <- 0.001
E <- ggplot(data = combinedNEITotal, aes(year, Emissions * hundThousth)) +
    geom_text(aes(label = round(Emissions * thousth, 2), size = 1.5, hjust = 0.5, vjust = 1.5)) +
    geom_line(aes(group = 1, col = Emissions), size = 1.0) +
    geom_point(aes(size = 1.5, col = Emissions)) +
    labs(title = 'Coal Combustion Emissions, US') +
    ylab(expression(paste('PM'[2.5], '(kT)'))) +    
    theme(legend.position = 'none')
print(E)
dev.off()