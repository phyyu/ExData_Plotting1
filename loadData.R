if(!file.exists("data")){
  dir.create("data")
}

# Loading full dataset
data_full <- read.csv("./Data/household_power_consumption.txt")
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

# Subsetting the data
data <- subset(data_full, subset=(Date == "2007-02-01" | Date == "2007-02-02"))
rm(data_full)

# Converting dates

datetime <- paste(as.Date(data$Date), data$Time)

data$Datetime <- strptime(datetime, "%d/%m/%Y %H:%M:%S")
