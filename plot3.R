## Extract and read data from working directory; read only first 70,000 rows to limit file size (includes required dates)
power <- read.table("household_power_consumption.txt", header = TRUE, dec = ".", sep = ";", nrow = 70000, stringsAsFactors=FALSE, na.strings = "?")

##read only dates of 2007-02-01 and 2007-02-01
power_sub <- subset(power, Date == "2/2/2007" | Date == "1/2/2007")

##convert Global active power column to numeric
power_sub$Global_active_power <- as.numeric(as.character(power_sub$Global_active_power))

##convert Date from character
power_sub$Date <- as.Date(power_sub$Date, "%d/%m/%Y")

##combine Date and Time in new "DateTime" column
power_sub <- mutate(power_sub, DateTime = as.POSIXct(paste(power_sub$Date, power_sub$Time), format="%Y-%m-%d %H:%M:%S"))

#create png file
png(file = "plot3.png")

#create plot
with(power_sub, plot(DateTime, Sub_metering_1, type = "l", xlab = " ", ylab = "Energy sub metering"))

#add lines for other 2 sub metering groups
lines(power_sub$DateTime, power_sub$Sub_metering_2, type = "l", col = "red")
lines(power_sub$DateTime, power_sub$Sub_metering_3, type = "l", col = "blue")

#add legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

#close graphic device
dev.off()
