library(sqldf)
library(dplyr)
library(lubridate)

plot3 <- function() {
        file ="household_power_consumption.txt"
        sql = 'select * from file where Date == "1/2/2007" or Date == "2/2/2007"'
        
        hpc <- read.csv2.sql(file,sql)
        closeAllConnections()
        hpc <- mutate(hpc, Date = dmy(Date))
        
        png(filename = "plot3.png",
            width = 480, height = 480)
        
        Sys.setlocale("LC_TIME", "C")
        
        timeperiod <- ymd_hms(paste(hpc$Date, hpc$Time))
        plot(timeperiod, hpc$Sub_metering_1, type = "n", 
             xlab = "", 
             ylab = "Energy sub metering")
        lines(timeperiod, hpc$Sub_metering_1, col = "black", type = "l")
        lines(timeperiod, hpc$Sub_metering_2, col = "red", type = "l")
        lines(timeperiod, hpc$Sub_metering_3, col = "blue", type = "l")
        legend("topright", 
               legend = names(hpc)[7:9], 
               col = c("black", "red", "blue"),
               lty = c(1,1,1))
        
        
        dev.off(dev.cur())
        
}
