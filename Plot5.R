# Downloading

fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download.file(fileUrl, destfile = './data/exdata_data_NEI_data.zip')

unzip('./exdata_data_NEI_data.zip', exdir = './data')

# Loading

library（ggplot2）

NEI <- readRDS("./data/summarySCC_PM25.rds")

SCC <- readRDS("./data/Source_Classification_Code.rds")

NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

# Baltimore City, Maryland == fips

MD.onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')

# Aggregate

MD.df <- aggregate(MD.onroad[, 'Emissions'], by=list(MD.onroad$year), sum)

colnames(MD.df) <- c('year', 'Emissions')

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 

png('~/Exploratory_Data_Analysis/Assignment_2/plot5.png')

ggplot(data = MD.df, aes(x = year, y = Emissions)) + geom_bar(aes(fill = year), stat = "identity") + guides(fill = F) + ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland') + ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position = 'none') + geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = 2))


dev.off()
