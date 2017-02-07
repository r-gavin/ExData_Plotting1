# R script to create Plot 1 for 
# "Exploratory Data Analysis" week 1 assignment.

library(dplyr)
library(lubridate)
library(grDevices)
library(ggplot2)

energy <- read.table("household_power_consumption.txt", 
                     header = TRUE, sep = ";", stringsAsFactors = FALSE)

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

png("plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))

with(feb2007, plot(
      x = as.POSIXlt(strftime(paste(feb2007$Date,feb2007$Time),"%Y-%m-%d %H:%M:%S")),
      y = Global_active_power, 
      type = "l", lwd = 1, lty = 1, 
      xlab = "", ylab = "Global Active Power"))

with(feb2007, plot(
      x = as.POSIXlt(strftime(paste(feb2007$Date,feb2007$Time),"%Y-%m-%d %H:%M:%S")),
      y = Voltage, 
      type = "l", lwd = 1, lty = 1, 
      xlab = "datetime", ylab = "Voltage"))

with(feb2007, {
     plot(as.POSIXlt(strftime(paste(Date,Time),"%Y-%m-%d %H:%M:%S")),Sub_metering_1,
          type = "l", xlab = "", ylab = "Energy sub metering")
     points(as.POSIXlt(strftime(paste(Date,Time),"%Y-%m-%d %H:%M:%S")),Sub_metering_2,
            type = "l", col = "red")
     points(as.POSIXlt(strftime(paste(Date,Time),"%Y-%m-%d %H:%M:%S")),Sub_metering_3,
            type = "l", col = "blue")
})

legend('topright', col = c("black","red","blue"), lty = 1, 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

with(feb2007, plot(
      x = as.POSIXlt(strftime(paste(feb2007$Date,feb2007$Time),"%Y-%m-%d %H:%M:%S")),
      y = Global_reactive_power, 
      type = "l", lwd = 1, lty = 1, 
      xlab = "datetime"))

dev.off()
