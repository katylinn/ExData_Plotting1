library(data.table)

#download unzip and read the file into "data"
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="power.zip", method="curl")
unzip("power.zip")
data<-fread("household_power_consumption.txt")

#cast Dates to Date class
data$Date<- as.Date(data$Date, format ="%d/%m/%Y")

#pull just the subset we are graphing
subset <- data[(data$Date >= "2007-02-01") & (data$Date <= "2007-02-02"), ]

#create file
png(file = "plot1.png")

#reference plat has a transparent background
par("bg"=rgb(0,0,0,0))

#histogram of Golbal Actice Power
hist(as.numeric(subset$Global_active_power), main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")

#save off the file
dev.off()