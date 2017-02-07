# R script to create Plot 1 for 
# "Exploratory Data Analysis" week 1 assignment.

library(dplyr)
library(lubridate)
library(grDevices)

energy <- read.table("household_power_consumption.txt", 
                     header = TRUE, sep = ";", stringsAsFactors = FALSE)

## energy <- cbind.data.frame(Date = strptime(paste(energy$Date[1], energy$Time[1]), 
##                                            "%d/%m/%Y %H:%M:%S"),energy[,-(1:2)])
energy$Date <- as.Date(energy$Date, "%d/%m/%Y")

energy <- tbl_df(energy)
energy$Global_active_power <- as.numeric(energy$Global_active_power)
energy$Global_reactive_power <- as.numeric(energy$Global_reactive_power)
energy$Voltage <- as.numeric(energy$Voltage)
energy$Global_intensity <- as.numeric(energy$Global_intensity)
energy$Sub_metering_1 <- as.numeric(energy$Sub_metering_1)
energy$Sub_metering_2 <- as.numeric(energy$Sub_metering_2)
energy$Sub_metering_3 <- as.numeric(energy$Sub_metering_3)

feb2007 <- subset(energy, Date == "2007-02-01" | Date == "2007-02-02")

png("plot1.png")

with(feb2007, hist(Global_active_power, breaks = 12, 
                   xlab = "Global Active Power (kilowatts)", 
                   main = "Global Active Power", col = "red"))

dev.off()
