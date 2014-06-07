library(data.table)

#download unzip and read the file into "data"
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="power.zip", method="curl")
unzip("power.zip")
data<-fread("household_power_consumption.txt")

#cast Dates to Date class
data$Date<- as.Date(data$Date, format ="%d/%m/%Y")

#pull just the subset we are graphing
subset <- data[(data$Date >= "2007-02-01") & (data$Date <= "2007-02-02"), ]

#creates a DateTime column format: %Y-%m-%d %H:%M:%S
subset$DateTime <- paste(subset$Date, subset$Time)

#create file
png(file = "plot4.png")

#reference plat has a transparent background
par("bg"=rgb(0,0,0,0))

#create 2X2 grid
par(mfrow=c(2,2))

#plot Global_active_power against DateTime
plot(as.POSIXlt(subset$DateTime), subset$Global_active_power, ylab="Global Active Power", type="l", xlab="")

#plot Voltage against DateTime
plot(as.POSIXlt(subset$DateTime), subset$Voltage, ylab="Voltage", type="l", xlab="datetime" )

#plot Sub_metering against DateTime
plot(as.POSIXlt(subset$DateTime), subset$Sub_metering_1, type="l",  ylab="Energy sub metering", xlab="", col="black")
points(as.POSIXlt(subset$DateTime), subset$Sub_metering_2, type="l",  col="red")
points(as.POSIXlt(subset$DateTime), subset$Sub_metering_3, type="l", col="blue")
legend("topright", bty="n", col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lty=c(1,1))

#plot Global_reactive_power against DateTime
plot(as.POSIXlt(subset$DateTime), subset$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")

#save off the file
dev.off()