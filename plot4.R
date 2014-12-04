# Start the clock!
Start_Time = proc.time()

message ("0. Start Project 1-4 of Exploratory Data Analysis ~")

# Part 1: Set working directory and download file
message ("1. Set working directory and download file ~")

Project_Path = getwd()
Url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
File_Name = "Project_1_Data.zip"
File_Path = paste (Project_Path, File_Name, sep = "/")

if (!file.exists(File_Path))
{
        download.file (Url, File_Path)
}

# Part 2: Unzip downloaded file
message ("2. Unzip downloaded file ~")

unzip (zipfile = File_Path)

# Part 3: Read data files
message ("3. Read data files ~")

Data = read.csv ("household_power_consumption.txt", sep = ";", stringsAsFactors = F)

Data$Date = as.Date (Data$Date, format = "%d/%m/%Y")

# Part 4: Subset data files with date as '2007-02-01' and '2007-02-02' and format time
message ("4. Subset data files with date as '2007-02-01' and '2007-02-02' and format time ~")

SubsetData = subset (Data, Date == "2007-02-01" | Date == "2007-02-02")

SubsetData$Global_active_power = sapply (SubsetData$Global_active_power, as.numeric)
SubsetData$Voltage = sapply (SubsetData$Voltage, as.numeric)
SubsetData$Global_reactive_power = sapply (SubsetData$Global_reactive_power, as.numeric)


SubsetData$Sub_metering_1 = sapply (SubsetData$Sub_metering_1, as.numeric)
SubsetData$Sub_metering_2 = sapply (SubsetData$Sub_metering_2, as.numeric)
SubsetData$Sub_metering_3 = sapply (SubsetData$Sub_metering_3, as.numeric)

Date_Time = paste(SubsetData$Date, SubsetData$Time)
Date_Time = as.POSIXct(Date_Time)

# Part 5: Plot 2 by 2 subfigures 
message ("5. Plot 2 by 2 subfigures  ~")

par (mfrow = c(2, 2))

with(SubsetData, {
        plot(Date_Time, Global_active_power, type = "l",
             ylab = "Global Active Power", xlab = "", col = "black")
        plot(Date_Time, Voltage, type = "l",
             ylab = "Voltage", xlab = "datetime", col = "black")
        plot(Date_Time, Sub_metering_1, type = "l",
             ylab = "Energy sub metering", xlab = "", col = "black")
        lines(Date_Time, Sub_metering_2, col = 'Red')
        lines(Date_Time, Sub_metering_3, col = 'Blue')
        legend("topright", lty = 1, lwd = 1, bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Date_Time, Global_reactive_power, type = "l",
             ylab = "Global_reactive_power", xlab = "datetime", col = "black")
})

# Part 6: Save the plot as a png
message ("6. Save the plot as a png ~")

dev.copy (png, file = "plot4.png")
dev.off ()

# Part 7: Project 1-3 is done
message ("7. Project 1-4 of Exploratory Data Analysis is done ~")

# Stop the clock
Stop_Time = proc.time() 
Running_Time = Stop_Time - Start_Time
print (Running_Time)