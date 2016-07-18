library(dplyr)
library(lubridate)

setwd("./Exploratory Data Analysis 1")

# This is how I got the hardcoded skip and nrows parameters.
#data_range = grep("^1/2/2007", readLines("./household_power_consumption.txt"))
#skip <- min(data_range) - 2 # 1 (for header) + 1 (to go before first match) = 2
#data_range = grep("^2/2/2007", readLines("./household_power_consumption.txt"))
#nrows <- max(data_range) - skip

# read in the data
data <- read.csv("./household_power_consumption.txt", sep=";", na.strings="?", as.is = FALSE, skip=66636, nrows=2880)
names(data) <- names(read.csv("./household_power_consumption.txt", sep=";", nrows=1))
data <- mutate(data, Date = dmy(Date))
data <- mutate(data, Time = as.POSIXct(strptime(paste(Date, Time), format="%Y-%m-%d %H:%M:%S")))

png(filename="./plot3.png")

# create plot 3
with(data, plot(Time, Sub_metering_1, ylab = "Energy sub metering", xlab = " ", type = "n"))
with(data, lines(Time, Sub_metering_1, type = "l", col="black"))
with(data, lines(Time, Sub_metering_2, type = "l", col="orangered"))
with(data, lines(Time, Sub_metering_3, type = "l", col="blue"))
legend("topright", col=c("black", "orangered", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1)

dev.off()