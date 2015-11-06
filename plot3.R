library('dplyr')
library('lubridate')

##  loading data 
raw_consumption <- read.table("household_power_consumption.txt", header=TRUE, sep = ";", as.is=TRUE, colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = "?")

## formatting for dplyr
raw_con <- tbl_df(raw_consumption)

## adding date row for lubridate
consumption <- mutate(raw_con, nDate = dmy(Date), nTime = hms(Time))

## selecting time range of concern
interval <- new_interval(ymd("2007-02-01"), ymd("2007-02-02"))
dateSub <- filter(consumption, nDate %within% interval)

##getting a datetime column
newdtest <- mutate(dateSub, newdt = dmy_hms(paste(Date, Time, sep = " ")))

## making the plot
png(filename="plot3.png", width = 480, height = 480)
plot(newdtest$newdt, newdtest$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(newdtest$newdt, newdtest$Sub_metering_2, type = "l", col="red")
lines(newdtest$newdt, newdtest$Sub_metering_3, type = "l", col="blue")
legend("topright", lwd = 2, col= c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()