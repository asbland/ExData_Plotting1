# The following code will load the UC Irvine Machine Learning Repository power
# consumption data and create the third plot in fulfillment of Project 1 for
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

# Isolate the date and time columns and the three Sub Metering columns

data <- data[, c(1:2, 7:9)]

# Convert the three Sub Metering columns to numeric

data[, 3:5] <- sapply(data[,3:5],as.numeric)

# Create new POSIXlt vector using the Date and Time columns

datetimes <-  strptime(paste(data$Date, data$Time), format = '%d/%m/%Y %H:%M:%S')

# Initialize a png

png(filename = 'plot3.png', width = 480, height = 480)

# Create a time (line) plot of the data, with a black line for sub metering 1,
# a red line for sub metering 2, and a blue line for sub metering 3.
# Add a legend to the topright.

plot(datetimes, data$Sub_metering_1, type = 'l', col = 'black',
     ylab = 'Energy sub metering',
     xlab = NA)
lines(datetimes, data$Sub_metering_2, col = 'red')
lines(datetimes, data$Sub_metering_3, col = 'blue')
legend('topright', lty = 1,
       col = c('black', 'red', 'blue'),
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))


# Close the connection
dev.off()