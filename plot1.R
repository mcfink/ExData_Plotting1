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

## building first histogram
png(filename="plot1.png", width = 480, height = 480)
hist(dateSub$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()

