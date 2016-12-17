#set wd, download and unzip files

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
  

  #subsetting for the two days
  
  hs_pow <- subset(household_power_consumption, Date == "2007-02-01" | Date == "2007-02-02")

  hs_pow$Time <- hms(hs_pow$Time)
  
  #creating new column with name Period for the relevat time interval
  
        hs_pow$Period <- hs_pow$Date + hs_pow$Time

# open graphics device
        
png(file = "plot2.png", width = 480, height = 480)
        
#making the plot 
       
  with(hs_pow, 
       plot(Period, Global_active_power,
            type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
  #closing graphics device
  
  dev.off()