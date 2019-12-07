# The following code will load the UC Irvine Machine Learning Repository power
# consumption data and create the first plot in fulfillment of Project 1 for
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

# Isolate the Global Active Power column and convert to numeric

data <- as.numeric(data$Global_active_power)

# Initialize a png

png(filename = 'plot1.png', width = 480, height = 480)

# Create a histogram of the data that is red, has 12 breaks, and appropriate labels

hist(data, col = 'red', breaks = 12,
     main = 'Global Active Power', 
     xlab = 'Global Active Power (kilowatts)')

# Close the connection
dev.off()