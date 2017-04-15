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

## Make plot 3 (Sub-meter readings over time) using R Base Plotting
png("plot3.png")
plot(powerDataFeb$timeStamp, powerDataFeb$Sub_metering_1, ylab = "Energy Sub-metering", xlab = "", type = "n")
lines(powerDataFeb$timeStamp, powerDataFeb$Sub_metering_1, type = "l", col = "black")
lines(powerDataFeb$timeStamp, powerDataFeb$Sub_metering_2, type = "l", col = "red")
lines(powerDataFeb$timeStamp, powerDataFeb$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pch = c(95, 95, 95), col = c("black", "red", "blue"))
dev.off()