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

png("plot2.png", width = 480, height = 480)
plot(datetime, sub$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()



