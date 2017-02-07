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

png("plot2.png", width = 480, height = 480)

with(feb2007, plot(
      x = as.POSIXlt(strftime(paste(feb2007$Date,feb2007$Time),"%Y-%m-%d %H:%M:%S")),
      y = Global_active_power, 
      type = "l", lwd = 1, lty = 1, 
      xlab = "", ylab = "Global Active Power (kilowatts)"))

dev.off()
