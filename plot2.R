library(sqldf)
library(dplyr)
library(lubridate)

plot2 <- function() {
        file ="household_power_consumption.txt"
        sql = 'select * from file where Date == "1/2/2007" or Date == "2/2/2007"'
        
        hpc <- read.csv2.sql(file,sql)
        closeAllConnections()
        hpc <- mutate(hpc, Date = dmy(Date))
        
        png(filename = "plot2.png",
            width = 480, height = 480)
        
        Sys.setlocale("LC_TIME", "C")
        
        timeperiod <- ymd_hms(paste(hpc$Date, hpc$Time))
        plot(timeperiod, hpc$Global_active_power, type = "n",
             xlab = "",
             ylab = "Global Active Power (kilowatts)")
        lines(timeperiod, 
              hpc$Global_active_power, 
              type = "l")
        
        dev.off(dev.cur())
        
}
