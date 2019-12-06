# Downloading

fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download.file(fileUrl, destfile = './data/exdata_data_NEI_data.zip')

unzip('./exdata_data_NEI_data.zip', exdir = './data')

# Loading

NEI <- readRDS("./data/summarySCC_PM25.rds")

SCC <- readRDS("./data/Source_Classification_Code.rds")

# Aggregate

Emissions <- aggregate(NEI[, 'Emissions'], by=list(NEI$year), FUN=sum)

Emissions$PM <- round(Emissions[,2]/1000,2)

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 

png(filename='~/data/plot1.png')

barplot(Emissions$PM, names.arg=Emissions$Group.1, 

        main=expression('Total Emission of PM'[2.5]),

        xlab='Year', ylab=expression(paste('PM', ''[2.5], ' in Kilotons')))

dev.off()
