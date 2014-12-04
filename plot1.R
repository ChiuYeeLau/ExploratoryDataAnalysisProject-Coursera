# Start the clock!
Start_Time = proc.time()

message ("0. Start Project 1-1 of Exploratory Data Analysis ~")

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

# Part 4: Subset data files with date as '2007-02-01' and '2007-02-02'
message ("4. Subset data files with date as '2007-02-01' and '2007-02-02' ~")

SubsetData = subset (Data, Date == "2007-02-01" | Date == "2007-02-02")

SubsetData$Global_active_power = sapply (SubsetData$Global_active_power, as.numeric)

# Part 5: Plot the histogram of 'Global Active Power' 
message ("5. Plot the histogram of 'Global Active Power' ~")

par (mfrow = c(1, 1))

hist (SubsetData$Global_active_power, col = "Red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)",ylab = "Frequency")

# Part 6: Save the histogram as a png
message ("6. Save the histogram as a png ~")

dev.copy (png, file = "plot1.png")
dev.off ()

# Part 7: Project 1-1 is done
message ("7. Project 1-1 of Exploratory Data Analysis is done ~")

# Stop the clock
Stop_Time = proc.time() 
Running_Time = Stop_Time - Start_Time
print (Running_Time)