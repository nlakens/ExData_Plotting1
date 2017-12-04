##download file
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

##unzip file
unzip(zipfile = "./data/Dataset.zip", exdir="./data")

##save paths and working directory
wd<- getwd()
fp <- file.path(getwd(),"data")
list.files(fp, recursive = TRUE)

setwd(fp)


##read file
hpc_all<- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

##set initial working directory
setwd(wd)

##lubridate is great for handling dates
library(lubridate)

##change datatypes
hpc_all$datetime <- paste(hpc_all$Date, hpc_all$Time, sep = " ")
hpc_all$Date <- dmy(hpc_all$Date)
hpc_all$Time <- hms(hpc_all$Time)
hpc_all$datetime <- dmy_hms(hpc_all$datetime)
hpc_all$Global_active_power <- as.numeric(hpc_all$Global_active_power)
hpc_all$Sub_metering_1 <- as.numeric(hpc_all$Sub_metering_1)
hpc_all$Sub_metering_2 <- as.numeric(hpc_all$Sub_metering_2)
hpc_all$Sub_metering_3 <- as.numeric(hpc_all$Sub_metering_3)
hpc_all$Voltage <- as.numeric(hpc_all$Voltage)
hpc_all$Global_reactive_power <- as.numeric(hpc_all$Global_reactive_power)


##select correct dates
first<-subset(hpc_all, Date == as.Date("01/02/2007","%d/%m/%Y"))
second<-subset(hpc_all, Date == as.Date("02/02/2007","%d/%m/%Y"))

##bind two dates together
hpc<-rbind(first,second)



##plot1.png
with(hpc, hist(Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))
dev.off()

##plot1 to .png
dev.cur()
png(file="plot1.png")
with(hpc, hist(Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))
dev.off()
