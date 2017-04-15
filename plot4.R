## Run required libraries
library(lubridate)
library(dplyr)

## Download and unzip data file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./data")){dir.create("./data")}
download.file(fileUrl, destfile = "./data/powerData.zip", mode = "wb")
unzip("./data/powerData.zip", exdir = "./data")

## Read in the data
data <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = c("character", "character", rep("numeric", 7)))

## Format some of the variables
timeStamp <- paste(data$Date, data$Time)
data$timeStamp <- dmy_hms(timeStamp)
powerData <- tbl_df(data)
powerData$Date <- dmy(powerData$Date)

## Subsetting of the data for the dates in question
powerDataFeb <- subset(powerData, Date > as.Date("2007-01-31") & Date < as.Date("2007-02-03"))

## Make plot 4 (4 plots in a 2x2 matrix) using R Base Plotting
png("plot4.png")
par(mfrow = c(2, 2))

## Top left plot
plot(powerDataFeb$timeStamp, powerDataFeb$Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", type = "n")
lines(powerDataFeb$timeStamp, powerDataFeb$Global_active_power, type = "l")

## Top right plot
plot(powerDataFeb$timeStamp, powerDataFeb$Voltage, ylab = "Voltage", xlab = "datetime", type = "n")
lines(powerDataFeb$timeStamp, powerDataFeb$Voltage, type = "l")

## Bottom left plot
plot(powerDataFeb$timeStamp, powerDataFeb$Sub_metering_1, ylab = "Energy Sub-metering", xlab = "", type = "n")
lines(powerDataFeb$timeStamp, powerDataFeb$Sub_metering_1, type = "l", col = "black")
lines(powerDataFeb$timeStamp, powerDataFeb$Sub_metering_2, type = "l", col = "red")
lines(powerDataFeb$timeStamp, powerDataFeb$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pch = c(95, 95, 95), col = c("black", "red", "blue"))

## Bottom right plot
plot(powerDataFeb$timeStamp, powerDataFeb$Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type = "n")
lines(powerDataFeb$timeStamp, powerDataFeb$Global_reactive_power, type = "l")

dev.off()