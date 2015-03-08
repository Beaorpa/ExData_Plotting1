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
png(file="plot3.png")
##Create a plot and send to a file
with(hpcf, {
        plot(Sub_metering_1~Datetime, type="l",
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~Datetime,col='Red')
        lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## Close the png Device
dev.off()