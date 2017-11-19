library(sqldf)
library(dplyr)
library(lubridate)

readdata <- function() {
        file ="household_power_consumption.txt"
        sql = 'select * from file where Date == "1/2/2007" or Date == "2/2/2007"'
        
        hpc <- read.csv2.sql(file,sql)
        closeAllConnections()
        hpc <- mutate(hpc, Date = dmy(Date))
}

plot_a <- function(hpc, timeperiod) {
        
        plot(timeperiod, hpc$Global_active_power, type = "n",
             xlab = "",
             ylab = "Global Active Power")
        lines(timeperiod, 
              hpc$Global_active_power, 
              type = "l")
}

plot_b <- function(hpc, timeperiod) {
        
        plot(timeperiod, hpc$Sub_metering_1, type = "n", 
             xlab = "", 
             ylab = "Energy sub metering")
        lines(timeperiod, hpc$Sub_metering_1, col = "black", type = "l")
        lines(timeperiod, hpc$Sub_metering_2, col = "red", type = "l")
        lines(timeperiod, hpc$Sub_metering_3, col = "blue", type = "l")
        legend("topright", 
               legend = names(hpc)[7:9], 
               col = c("black", "red", "blue"),
               lty = c(1,1,1),
               inset = 0.005,
               box.lty = 0)
        
}

plot_c <- function(hpc, datetime) {
        
        plot(datetime, hpc$Voltage, type = "n",
             ylab = "Voltage")
        lines(datetime, hpc$Voltage, col = "black", type = "l")
        
}

plot_d <- function(hpc, datetime) {
        
        plot(datetime, hpc$Global_reactive_power, type = "n",
             ylab = "Global_reactive_power")
        lines(datetime, hpc$Global_reactive_power, col = "black", type = "l")
        
}

plot4 <- function() {
        hpc <- readdata()
        
        png(filename = "plot4.png",
            width = 480, height = 480)
 
        par(mfcol = c(2,2))
        Sys.setlocale("LC_TIME", "C")
        timeperiod <- ymd_hms(paste(hpc$Date, hpc$Time))
        
        plot_a(hpc, timeperiod)
        plot_b(hpc, timeperiod)
        plot_c(hpc, timeperiod)
        plot_d(hpc, timeperiod)
        
        dev.off(dev.cur())       
}
