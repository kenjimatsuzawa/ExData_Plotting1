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
png("plot4.png", width=480, height=480)

# define 2 by 2 canvas
par(mfrow=c(2,2), oma=c(4,0,0,0))

# graph on top left
plot(powerpart$datetime, powerpart$Global_active_power, type="n",xlab="", ylab="Global Active Power")
lines(powerpart$datetime, powerpart$Global_active_power)

# graph on top right
plot(powerpart$datetime, powerpart$Voltage, type="n", xlab="datetime", ylab="Voltage")
lines(powerpart$datetime, powerpart$Voltage)

# graph on bottom left
plot(powerpart$datetime, powerpart$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(powerpart$datetime, powerpart$Sub_metering_1)
point(powerpart$datetime, powerpart$Sub_metering_2, type="n")
lines(powerpart$datetime, powerpart$Sub_metering_2, col="red")
point(powerpart$datetime, powerpart$Sub_metering_3, type="n")
lines(powerpart$datetime, powerpart$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"), lty=c(1,1,1,1), bty="n")

# graph on bottom right
plot(powerpart$datetime, powerpart$Global_reactive_power, type="n", xlab="datetime", ylab="Global_reactive_power")
lines(powerpart$datetime, powerpart$Global_reactive_power)

# add disclaimer at the bottom of all graph
mtext(side = 1, line=1, outer = T, text="allow me to use Japanese char for week of the day to avoid to change locale")

dev.off()
