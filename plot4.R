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

# Convert the variables (except Date and Time) to numeric

data[, 3:9] <- sapply(data[,3:9],as.numeric)

# Create new POSIXlt vector using the Date and Time columns

datetimes <-  strptime(paste(data$Date, data$Time), format = '%d/%m/%Y %H:%M:%S')

# Initialize a png

png(filename = 'plot4.png', width = 480, height = 480)

# Setup the plot to contain 4 subplots

par(mfrow = c(2, 2))

# Create a time (line) plot of Global Active Power versus datetime that has 
# appropriate labels in the topleft

plot(datetimes, data$Global_active_power, type = 'l',
     ylab = 'Global Active Power',
     xlab = NA)

# Create a time (line) plot of Voltage versus datetime that has appropriate 
# labels in the topright

plot(datetimes, data$Voltage, type = 'l',
     ylab = 'Voltage',
     xlab = 'datetime')

# Create a time (line) plot of the sub metering data, with a black line for sub 
# metering 1, a red line for sub metering 2, and a blue line for sub metering 3.
# Add a legend to the bottomleft.

plot(datetimes, data$Sub_metering_1, type = 'l', col = 'black',
     ylab = 'Energy sub metering',
     xlab = NA)
lines(datetimes, data$Sub_metering_2, col = 'red')
lines(datetimes, data$Sub_metering_3, col = 'blue')
legend('topright', lty = 1,
       col = c('black', 'red', 'blue'),
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

# Create a time (line) plot of Global Reactive Power versus datetime that has 
# appropriate labels in the bottomright

plot(datetimes, data$Global_reactive_power, type = 'l',
     ylab = 'Global_reactive_power',
     xlab = 'datetime')


# Close the connection
dev.off()