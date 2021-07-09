library(dplyr)

# download file
fileurl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zip_file = "power_consumption.zip"
download.file(fileurl, destfile = zip_file)
unzip(zip_file)

# read data to data table
power <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.string="?", colClasses = c("character","character", rep("numeric", 7)))
powerpart <- filter(power, (Date =="1/2/2007" | Date == "2/2/2007"))
# add new feature datatime with yyyy/mm/dd hh:mm:ss format
powerpart <- mutate(powerpart, datetime=strptime(paste(powerpart$Date, powerpart$Time), "%e/%m/%Y %H:%M:%S"))

# create graph
png("plot2.png", width=480, height=480)
plot(powerpart$datetime, powerpart$Global_active_power, type="n", xlab="allow me to use Japanese char for week of the day not to change locale", ylab="Global Active Power (kirowatts)")
lines(powerpart$datetime, powerpart$Global_active_power)
dev.off()
