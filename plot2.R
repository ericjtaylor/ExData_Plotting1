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

png(filename="./plot2.png")

# create plot 2
with(data, plot(Time, Global_active_power, ylab = "Global Active Power (kilowatts)", type = "l"))

dev.off()