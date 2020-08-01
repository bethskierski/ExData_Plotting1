## Extract and read data from working directory; read only first 70,000 rows to limit file size (includes required dates)
power <- read.table("household_power_consumption.txt", header = TRUE, dec = ".", sep = ";", nrow = 70000, stringsAsFactors=FALSE)

##read only dates of 2007-02-01 and 2007-02-01
power_sub <- subset(power, Date == "2/2/2007" | Date == "1/2/2007")

##convert Global active power column to numeric
power_sub$Global_active_power <- as.numeric(as.character(power_sub$Global_active_power))

#create png file
png(file = "plot1.png")

#create histogram
hist(power_sub$Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col = "red")

#close graphic device
dev.off()