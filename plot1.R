library(lubridate)

# Read Data
dt<- read.table("household_power_consumption.txt", header=TRUE, sep=";")
dt$Date <- dmy(dt$Date)
dt$Date <- as.character(dt$Date)

# Create "time-series-data" sub-data from the original data
tsd <- dt[(dt$Date=="2007-02-01" | dt$Date=="2007-02-02"), c(1,3)]

# Plot the histogram
hist(as.numeric(tsd$Global_active_power), col="Red", main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.copy(png, file = "plot1.png")
dev.off()

