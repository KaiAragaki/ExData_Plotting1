# Estimating Data Size in Memory
# Memory = ncol * nrow * 8
# Memory = 9 * 2,100,000 * 8 = 151,200,000 bytes = ~151Mb

if(!file.exists("UCIData.zip")) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "UCIData.zip")
        unzip("UCIData.zip")
}

powerData <- read.delim("household_power_consumption.txt", sep = ";", na.strings = "?") # Read in data
powerData$Date <- strptime(paste(powerData$Date, powerData$Time), "%d/%m/%Y %T") # Convert Date to Date object
powerData <- powerData[,-c(2)] # Drops the now redundant time column
powerData <- powerData[(powerData$Date >="2007-02-01")&(powerData$Date < "2007-02-03"),] # Subset data. Overwrites big dataset
powerData <- powerData[!is.na(powerData$Date),] # Removes NA dates

png("Rplot3.png")
with(powerData, plot(Date, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(powerData, lines(Date, Sub_metering_2, col = "red"))
with(powerData, lines(Date, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, lwd = 1)

dev.off()
