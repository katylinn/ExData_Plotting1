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
png(file = "plot3.png")

#reference plat has a transparent background
par("bg"=rgb(0,0,0,0))

#create plot 
plot(as.POSIXlt(subset$DateTime), subset$Sub_metering_1, type="l",  ylab="Energy sub metering", xlab="", col="black")
points(as.POSIXlt(subset$DateTime), subset$Sub_metering_2, type="l",  col="red")
points(as.POSIXlt(subset$DateTime), subset$Sub_metering_3, type="l", col="blue")

#create legend
legend("topright", col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lty=c(1,1))

#save off the file
dev.off()