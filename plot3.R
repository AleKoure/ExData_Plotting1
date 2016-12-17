#set wd download and unzip files

setwd("D:/Data Science/Coursera/Exploratory Data Analysis")

if(!file.exists("./household_power_consumption")){
        dir.create("./household_power_consumption")
}

fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileUrl, destfile = "./household_power_consumption/data.zip")

unzip(zipfile = "./household_power_consumption/data.zip")

#read data and changing class to Date and Period for the time intervals

household_power_consumption <- read.csv("./household_power_consumption.txt", 
                                        sep=";", na.strings="?")

library(lubridate)

household_power_consumption$Date <-dmy(household_power_consumption$Date)

#subseting for the two days
hs_pow <- subset(household_power_consumption, Date == "2007-02-01" | Date == "2007-02-02")

hs_pow$Time <- hms(hs_pow$Time)

#creating new column for the relevant time interval

hs_pow$Period <- hs_pow$Date + hs_pow$Time

#open graphics device

png(file = "plot3.png", width = 480, height = 480)

#creating the "palette"

with(hs_pow, plot(Period, Sub_metering_1, "n", xlab = "", ylab = "Energy sub metering"))

#adding plots and legend

with(hs_pow, points(Period, Sub_metering_1, type = "l", col = "black"))

with(hs_pow, points(Period, Sub_metering_2, type = "l", col = "red"))

with(hs_pow, points(Period, Sub_metering_3, type = "l", col = "blue"))

legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd = 1)

#close graphics device

dev.off()