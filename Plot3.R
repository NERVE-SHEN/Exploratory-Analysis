# Downloading

fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download.file(fileUrl, destfile = './data/exdata_data_NEI_data.zip')

unzip('./exdata_data_NEI_data.zip', exdir = './data')

# Loading

library（ggplot2）

NEI <- readRDS("./data/summarySCC_PM25.rds")

SCC <- readRDS("./data/Source_Classification_Code.rds")

# Baltimore City, Maryland == fips

MD <- subset(NEI, fips == 24510)

MD$year <- factor(MD$year, levels=c('1999', '2002', '2005', '2008'))

# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 

png(filename='~/data/plot3.png', width=800, height=500, units='px')



ggplot(data=MD, aes(x=year, y=log(Emissions))) + facet_grid(. ~ type) + guides(fill=F) +

    geom_boxplot(aes(fill=type)) + stat_boxplot(geom ='errorbar') +

    ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) + xlab('Year') + 

    ggtitle('Emissions per Type in Baltimore City, Maryland') +

    geom_jitter(alpha=0.10)


dev.off()
