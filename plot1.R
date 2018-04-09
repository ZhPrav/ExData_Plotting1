
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
df2 <- df1[,1:3]

df2$Global_active_power <- as.character(df2$Global_active_power)

df2$Global_active_power <- as.numeric(df2$Global_active_power)

hist(df2$Global_active_power, col = "red", main = " Global Active Power", xlab = "Global Active Power (killowats)", ylab = "Frequency")
dev.copy(png, "plot1.png")
dev.off()
