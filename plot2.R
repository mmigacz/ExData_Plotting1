zipFile <- "./data/epc.zip"

if(!file.exists("data")){dir.create("data")}
if(!file.exists(zipFile)){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile = zipFile, method = "curl", mode="wb")
  unzip(zipFile, exdir="./data/")  
}

epc <- read.csv("./data/household_power_consumption.txt", header=TRUE, sep = ";", na.strings="?")
epc$Time <- strptime(paste(epc$Date, epc$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
epc$Date <- as.Date(epc$Date, "%d/%m/%Y")
epc2 <- epc[epc$Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")), ]

with(epc2, plot(Time, Global_active_power, "l", ylab = "Global Active Power (kilowatts)"))
dev.print(png, file = "plot2.png", width = 480, height = 480)
dev.off()

rm(zipFile)
rm(epc)
rm(epc2)

