if(!file.exists("data")){
  dir.create("data")
}

fullData <- read.csv("./Data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                     check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
fullData$Date <- as.Date(fullData$Date, format="%d/%m/%Y")

# Subsetting data
subset <- fullData$Date == "2007-02-01" | fullData$Date == "2007-02-02"
data <- fullData[subset, ]

rm(fullData)

# Converting dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

#Create png file
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "transparent")

#2by2 plots
par(mfrow = c(2, 2))

## Top-left
plot(data$Global_active_power~data$Datetime, type = "l",xlab = "", ylab = "Global Active Power")

## Top-right
plot(data$Voltage~data$Datetime,type = "l", xlab = "datetime", ylab = "Voltage")

## Bottom-left
plot(data$Sub_metering_1~data$Datetime, type="l",col = "black", ylab="Energy sub metering", xlab="")
lines(data$Sub_metering_2~data$Datetime, col = "red")
lines(data$Sub_metering_3~data$Datetime, col = "blue")
#legend of the plot
legend("topright", bty="n",col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lwd = 1)

## Bottom-right
plot(data$Global_reactive_power~data$Datetime, type = "l",col = "black", xlab = "datetime", ylab = colnames(data)[4])

dev.off()