library(lubridate)

# Read Data
dt<- read.table("household_power_consumption.txt", header=TRUE, sep=";")
dt$Date <- dmy(dt$Date)
dt$Date <- as.character(dt$Date)

# Create "time-series-data" sub-data from the original data
tsd <- dt[(dt$Date=="2007-02-01" | dt$Date=="2007-02-02"), c(1,2,3)]

# Merge to get date-time field
datetime <- paste(as.Date(tsd$Date), tsd$Time)
tsd$Datetime <- as.POSIXct(datetime)

windows(width=10, height=8)

# Plot the details
plot(Sub_metering_1~Datetime, data = tsd, type="l", ylab="Global Active Power (kilowatts)", xlab="", col="black")
lines(Sub_metering_2~Datetime, data = tsd, type="l", ylab="Global Active Power (kilowatts)", xlab="", col="red")
lines(Sub_metering_3~Datetime, data = tsd, type="l", ylab="Global Active Power (kilowatts)", xlab="", col="blue")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Copy to png 
dev.copy(png, "plot3.png")
dev.off()

