#set wd, download and unzip files

setwd("D:/Data Science/Coursera/Exploratory Data Analysis")

       if(!file.exists("./household_power_consumption")){
           dir.create("./household_power_consumption")
          }

fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileUrl, destfile = "./household_power_consumption/data.zip")

unzip(zipfile = "./household_power_consumption/data.zip")

#read data and changing class to Date for the time intervals

household_power_consumption <- read.csv("./household_power_consumption.txt", 
                                        sep=";", na.strings="?")

library(lubridate)

household_power_consumption$Date <-dmy(household_power_consumption$Date)

#subsetting for the relevant days

hs_pow <- subset(household_power_consumption, Date == "2007-02-01" | Date == "2007-02-02")

# open graphics device

png(file = "plot1.png", width = 480, height = 480)

#plotting histogram

        hist(hs_pow$Global_active_power, col = "red", 
       main = "Global Active Power", 
       xlab = "Global Active Power (kilowatts)")

#closing graphics device
        dev.off()