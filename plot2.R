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
png(file = "plot2.png")

#create plot
with(power_sub, plot(DateTime, Global_active_power, type = "l", xlab = " ", ylab = "Global Active Power (kilowatts)"))

#close graphic device
dev.off()