
## Create a directory
if (!file.exists("./household_power_consumption") | !file.exists("./household_power_consumption/household_power_consumption.txt") ) { 
    dir.create("./household_power_consumption")
    ## download file
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./household_power_consumption/household_power_consumption.zip")

    ## unzip
    zipF<- "./household_power_consumption/household_power_consumption.zip"
    outDir<-"./household_power_consumption"
    unzip(zipF,exdir=outDir)
}

## load into a data.frame
df <- read.table("./household_power_consumption/household_power_consumption.txt", header=TRUE, sep=";", quote="", comment.char="", encoding="utf-8 . ")

## convert Date column to date format
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

## filter by dates

df1 <- df[df$Date %in% as.Date(c('2007-02-01', '2007-02-02')),]

df <- NULL
## 
df1$Global_active_power <- as.numeric(as.character(df1$Global_active_power))
df1$Global_reactive_power <- as.numeric(as.character(df1$Global_reactive_power))
df1$Voltage <- as.numeric(as.character(df1$Voltage))
df1$Sub_metering_1 <- as.numeric(as.character(df1$Sub_metering_1))
df1$Sub_metering_2 <- as.numeric(as.character(df1$Sub_metering_2))

df1$DateTime <- with(df1, as.POSIXct(paste(df1$Date, df1$Time), format = "%Y-%m-%d %H:%M:%S"))

par(mar=c(4,4,2,2), mfrow=c(2,2))
## plot1
plot(df1$DateTime, df1$Global_active_power, type = "l", xlab = "",  ylab = "Global Active Power", cex.axis=0.9, cex.lab=0.9)
## plot2
plot(df1$DateTime, df1$Voltage, type = "l", xlab = "datetime", ylab = "Voltage", cex.axis=0.9, cex.lab=0.9)

## plot3
plot(df1$DateTime, df1$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", cex.axis=0.9, cex.lab=0.9)
lines(df1$DateTime, df1$Sub_metering_2, type='l', col ='red')
lines(df1$DateTime, df1$Sub_metering_3, type='l', col ='blue')
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, bty="n", cex = 0.8, y.intersp = 0.5)

## plot4
plot(df1$DateTime, df1$Global_reactive_power, type = "l", xlab = "datetime", cex.axis=0.9, cex.lab=0.9)

dev.copy(png, "plot4.png")
dev.off()
