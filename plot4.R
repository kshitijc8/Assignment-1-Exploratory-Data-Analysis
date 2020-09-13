library(lubridate)

# Read Data
dt<- read.table("household_power_consumption.txt", header=TRUE, sep=";")
dt$Date <- dmy(dt$Date)
dt$Date <- as.character(dt$Date)

# Sub-setting data
gap <- dt[(dt$Date=="2007-02-01" | dt$Date=="2007-02-02"), c(1,2,3)]
grap <- dt[(dt$Date=="2007-02-01" | dt$Date=="2007-02-02"), c(1,2,4)]
vol <- dt[(dt$Date=="2007-02-01" | dt$Date=="2007-02-02"), c(1,2,5)]
subm <- dt[(dt$Date=="2007-02-01" | dt$Date=="2007-02-02"), c(1,2,7, 8, 9)]

# Defining date-time format
datetime <- paste(as.Date(gap$Date), gap$Time)

# Appending date-time column
gap$Datetime <- as.POSIXct(datetime)
grap$Datetime <- as.POSIXct(datetime)
vol$Datetime <- as.POSIXct(datetime)
subm$Datetime <- as.POSIXct(datetime)

windows(width=10, height=8)
par(mfrow=c(2,2))

# Plotting the graphs
with(gap, {plot(Global_active_power~Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")})
with(vol, {plot(Voltage~Datetime, type="l", ylab="Voltage", xlab="datetime")})
plot(Sub_metering_1~Datetime, data = subm, type="l", ylab="Global Active Power (kilowatts)", xlab="", col="black")
lines(Sub_metering_2~Datetime, data = subm, type="l", ylab="Global Active Power (kilowatts)", xlab="", col="red")
lines(Sub_metering_3~Datetime, data = subm, type="l", ylab="Global Active Power (kilowatts)", xlab="", col="blue")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
with(grap, {plot(Global_reactive_power~Datetime, type="l", ylab="Voltage", xlab="datetime")})

dev.copy(png, "plot4.png")
dev.off()
