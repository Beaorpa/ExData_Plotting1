## Read the file with read.table
hpc <- read.table("plot/household_power_consumption.txt", header = T, sep=";", na.strings="?", stringsAsFactors=F)
## Format the Date Column with as.Date function
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")
## Subsetting the file only with two days in February
hpcf <- subset(hpc, Date >= '2007-02-01' & Date <= '2007-02-02')
## Create a Date/Time Column
datetime <- paste(as.Date(hpcf$Date), hpcf$Time)
hpcf$Datetime <- as.POSIXct(datetime)
## Open a png device; Create a "plot2.png" in my working directory
png(file="plot2.png")
##Create a plot and send to a file
plot(hpcf$Global_active_power~hpcf$Datetime, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="")
## Close the png Device
dev.off()