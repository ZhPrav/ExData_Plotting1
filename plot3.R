
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
df2 <- df1[,c(1:2, 7:9)]

df2$Sub_metering_1 <- as.numeric(as.character(df2$Sub_metering_1))

df2$Sub_metering_2 <- as.numeric(as.character(df2$Sub_metering_2))

df2$DateTime <- with(df2, as.POSIXct(paste(df2$Date, df2$Time), format = "%Y-%m-%d %H:%M:%S"))

par(mar=c(2,4,2,2))
plot(df2$DateTime, df2$Sub_metering_1, type = "l",  ylab = "Energy sub metering")
lines(df2$DateTime, df2$Sub_metering_2, type='l', col ='red')
lines(df2$DateTime, df2$Sub_metering_3, type='l', col ='blue')

legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)

dev.copy(png, "plot3.png")
dev.off()
