#Exploratory Data Analysis, lajr sep2015
#Coursera project 1, plot4

# display date & time
todaysDate <- date()
print(todaysDate)

# read the original csv data file
dataFile <- "hpc.txt"
origDataSet <- read.table(dataFile, header = TRUE, sep = ";", stringsAsFactors = FALSE, dec = ".")
dataSubset <- origDataSet[origDataSet$Date %in% c("1/2/2007","2/2/2007") ,]

#str(dataSubset)
datetime <- strptime(paste(dataSubset$Date, dataSubset$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

globalActivePower <- as.numeric(dataSubset$Global_active_power)
globalReactivePower <- as.numeric(dataSubset$Global_reactive_power)
voltage <- as.numeric(dataSubset$Voltage)

subMetering1 <- as.numeric(dataSubset$Sub_metering_1)
subMetering2 <- as.numeric(dataSubset$Sub_metering_2)
subMetering3 <- as.numeric(dataSubset$Sub_metering_3)

#create & save the plots
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2)) 

plot(datetime, 
     globalActivePower, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power", cex = 0.2)

plot(datetime, 
     voltage, 
     type="l", 
     xlab = "datetime", 
     ylab = "Voltage")

plot(datetime, subMetering1, type = "l", ylab = "Energy Submetering", xlab = "")
    lines(datetime, subMetering2, type = "l", col = "red")
    lines(datetime, subMetering3, type = "l", col = "blue")
    legend("topright", 
           c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           lty=, 
           lwd=2.5, 
           col=c("black", "red", "blue"), bty="o")

plot(datetime, 
     globalReactivePower, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Global_reactive_power")

dev.off()