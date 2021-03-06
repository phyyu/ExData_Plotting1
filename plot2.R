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
png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "transparent")

#Plot2
plot(data$Global_active_power~data$Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

dev.off()
