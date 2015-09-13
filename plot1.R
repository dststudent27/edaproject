#Exploratory Data Analysis, lajr sep2015
#Coursera project 1, plot1

# display date & time
todaysDate <- date()
print(todaysDate)

#read the original csv data file
dataFile <- "hpc.txt"
origDataSet <- read.table(dataFile, header = TRUE, sep = ";", stringsAsFactors = FALSE, dec = ".")
dataSubset <- origDataSet[origDataSet$Date %in% c("1/2/2007","2/2/2007") ,]

#str(dataSubset)
globalActivePower <- as.numeric(dataSubset$Global_active_power)

png("plot1.png", width = 480, height = 480)
hist(globalActivePower, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

dev.off()