folder<-"dataset"
file<-"data.zip"
if(!file.exists(folder)) {
      if(!file.exists(file)) {
            download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                          file)
      }
      unzip(file)
}

data<- read.table("household_power_consumption.txt", header = TRUE, sep=";", stringsAsFactors=FALSE)
sub<-data[data$Date=="1/2/2007"| data$Date=="2/2/2007",]
datetime <- strptime(paste(sub$Date, sub$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

sub$Global_active_power<-as.numeric(sub$Global_active_power)

sub$Voltage<-as.numeric(sub$Voltage)

sub$Sub_metering_1<-as.numeric(sub$Sub_metering_1)
sub$Sub_metering_2<-as.numeric(sub$Sub_metering_2)
sub$Sub_metering_3<-as.numeric(sub$Sub_metering_3)

sub$Global_reactive_power<-as.numeric(sub$Global_reactive_power)

png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

plot(datetime, sub$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

plot(datetime, sub$Voltage, ylab = "Voltage", type = "l")

plot(datetime, sub$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(datetime, sub$Sub_metering_2, type = "l", col = "red")
lines(datetime, sub$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 1, col = c("black", "red", "blue"))

plot(datetime, sub$Global_reactive_power, type = "l", ylab = "Global_reactive_power")

dev.off()
