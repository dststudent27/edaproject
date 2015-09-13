#Exploratory Data Analysis, lajr sep2015
#Coursera project 1, plot2

# display date & time
todaysDate <- date()
print(todaysDate)

#read the original csv data file
dataFile <- "hpc.txt"
origDataSet <- read.table(dataFile, header = TRUE, sep = ";", stringsAsFactors = FALSE, dec = ".")
dataSubset <- origDataSet[origDataSet$Date %in% c("1/2/2007","2/2/2007") ,]

#str(dataSubset)
datetime <- strptime(paste(dataSubset$Date, dataSubset$Time, sep = " "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(dataSubset$Global_active_power)

#create & save the plot
png("plot2.png", width = 480, height = 480)
plot(datetime, 
     globalActivePower, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)")
dev.off()