## Read the file with read.table
hpc <- read.table("plot/household_power_consumption.txt", header = T, sep=";", na.strings="?", stringsAsFactors=F)
## Format the Date Column with as.Date function
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")
## Subsetting the file only with two days in February
hpcf <- subset(hpc, Date >= '2007-02-01' & Date <= '2007-02-02')
## Create a Date/Time Column
datetime <- paste(as.Date(hpcf$Date), hpcf$Time)
hpcf$Datetime <- as.POSIXct(datetime)
## Open a png device; Create a "plot3.png" in my working directory
png(file="plot4.png")
## Use par() function to combine 4 plots in 2 rows and 2 columns
par(mfrow=c(2,2), mar=c(4,4,2,1) )
## Create plot in row 1, ncol 1
plot(hpcf$Global_active_power~hpcf$Datetime, type="l",
           ylab="Global Active Power (kilowatts)", xlab="")
## Create plot in row 1, ncol 2
plot(hpcf$Voltage~hpcf$Datetime, type="l",
     ylab="Voltage", xlab="datetime")
## Create plot in row 2, ncol 1
with(hpcf, {
        plot(Sub_metering_1~Datetime, type="l",
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~Datetime,col='Red')
        lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## Create plot in row 2, ncol 2
plot(hpcf$Global_reactive_power~hpcf$Datetime, type="l",
     ylab="Global_reactive_power", xlab="datetime")
## Close the png Device
dev.off()