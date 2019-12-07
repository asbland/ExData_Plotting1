# The following code will load the UC Irvine Machine Learning Repository power
# consumption data and create the second plot in fulfillment of Project 1 for
# the Exploratory Data Analysis course.

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Download the zipped datafile to the current working directory if the file 
# does not already exist.

filename <- 'household_power_consumption.txt'

if(!file.exists(filename)) {
        zipfile <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
        download.file(zipfile, 'powerdata.zip')
        
        # Unzip the folder
        unzip('powerdata.zip')
        
        # Delete the zipped folder
        unlink("powerdata.zip", recursive = TRUE)
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Load the data

data <- read.table(filename, header = TRUE, sep = ';', na.strings = '?', stringsAsFactors = FALSE)

# Subset the data to only include the dates 2007-02-01 and 2007-02-02

data <- subset(data, Date == '1/2/2007' | Date == '2/2/2007')

# Isolate the date and time columns and the Global Active Power column

data <- data[, 1:3]

# Convert the Global Active Power column to numeric

data$Global_active_power <- as.numeric(data$Global_active_power)

# Create new POSIXlt vector using the Date and Time columns

datetimes <-  strptime(paste(data$Date, data$Time), format = '%d/%m/%Y %H:%M:%S')

# Initialize a png

png(filename = 'plot2.png', width = 480, height = 480)

# Create a time (line) plot of the data that has appropriate labels

plot(datetimes, data$Global_active_power, type = 'l',
     ylab = 'Global Active Power (kilowatts)',
     xlab = NA)

# Close the connection
dev.off()
