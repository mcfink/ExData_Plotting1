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
png(filename="plot2.png", width = 480, height = 480)
plot(newdtest$newdt, newdtest$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()