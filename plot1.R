library(sqldf)
library(dplyr)
library(lubridate)

plot1 <- function() {
        file ="household_power_consumption.txt"
        sql = 'select * from file where Date == "1/2/2007" or Date == "2/2/2007"'
        
        hpc <- read.csv2.sql(file,sql)
        closeAllConnections()
        hpc <- mutate(hpc, Date = dmy(Date))
        
        png(filename = "plot1.png",
            width = 480, height = 480)
        
        hist(hpc$Global_active_power,
             xlab = "Global Active Power (kilowatts)",
             main = "Global Active Power",
             col = "red")
        
        dev.off(dev.cur())        
}
