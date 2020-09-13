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
with(tsd, {plot(Global_active_power~Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")})


# Copy to png 
dev.copy(png, "plot2.png")
dev.off()

