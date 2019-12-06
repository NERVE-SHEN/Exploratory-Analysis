# Downloading

fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download.file(fileUrl, destfile = './data/exdata_data_NEI_data.zip')

unzip('./exdata_data_NEI_data.zip', exdir = './data')

# Loading

NEI <- readRDS("./data/summarySCC_PM25.rds")

SCC <- readRDS("./data/Source_Classification_Code.rds")

# Subset

MD <- subset(NEI, fips=='24510')

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510")

 png(filename='~/data/plot2.png')

barplot(tapply(X=MD$Emissions, INDEX=MD$year, FUN=sum), 

        main='Total Emission in Baltimore City, MD', 

        xlab='Year', ylab=expression('PM'[2.5]))


dev.off()
