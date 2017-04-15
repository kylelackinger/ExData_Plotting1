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

## Make plot 1 (Histogram of Global Active Power) using R Base Plotting
png("plot1.png")
hist(powerDataFeb$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()