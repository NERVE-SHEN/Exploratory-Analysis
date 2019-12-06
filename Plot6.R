# Downloading

fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download.file(fileUrl, destfile = './data/exdata_data_NEI_data.zip')

unzip('./exdata_data_NEI_data.zip', exdir = './data')

# Loading

library(ggplot2)

NEI <- readRDS("./data/summarySCC_PM25.rds")

SCC <- readRDS("./data/Source_Classification_Code.rds")

NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

# Baltimore City, Maryland

# Los Angeles County, California

MD.onroad <- subset(NEI, fips == '24510' & type == 'ON-ROAD')

CA.onroad <- subset(NEI, fips == '06037' & type == 'ON-ROAD')

# Aggregate

MD.DF <- aggregate(MD.onroad[, 'Emissions'], by=list(MD.onroad$year), sum)

colnames(MD.DF) <- c('year', 'Emissions')

MD.DF$City <- paste(rep('MD', 4))

CA.DF <- aggregate(CA.onroad[, 'Emissions'], by=list(CA.onroad$year), sum)

colnames(CA.DF) <- c('year', 'Emissions')

CA.DF$City <- paste(rep('CA', 4))

DF <- as.data.frame(rbind(MD.DF, CA.DF))


# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 

png('~/data/plot6.png')



ggplot(data=DF, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year)) + guides(fill=F) + 

    ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles County, California vs. Baltimore City, Maryland') + 

    ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + facet_grid(. ~ City) + 

    geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-1))



dev.off()
