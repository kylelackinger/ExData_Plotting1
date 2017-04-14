## Download and unzip data file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./data")){dir.create("./data")}
download.file(fileUrl, destfile = "./data/powerData.zip", mode = "wb")
unzip("./data/powerData.zip", exdir = "./data")

## Read in the data
data <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";")
powerData <- tbl_df(data)
powerData$Date <- dmy(powerData$Date)

powerDataFeb <- subset(powerData, Date > as.Date("2007-01-31") & Date < as.Date("2007-02-03"))
