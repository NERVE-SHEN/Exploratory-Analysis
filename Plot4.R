# Downloading

fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download.file(fileUrl, destfile = './data/exdata_data_NEI_data.zip')

unzip('./exdata_data_NEI_data.zip', exdir = './data')

# Loading

library（ggplot2）

NEI <- readRDS("./data/summarySCC_PM25.rds")

SCC <- readRDS("./data/Source_Classification_Code.rds")


# Coal combustion related sources

SCC.coal = SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]

# Merging

merge <- merge(x=NEI, y=SCC.coal, by='SCC')

merge.sum <- aggregate(merge[, 'Emissions'], by=list(merge$year), sum)

colnames(merge.sum) <- c('Year', 'Emissions')


# Across the United States, how have emissions from coal combustion-related sources 

# changed from 1999-2008?

png(filename='~/data/plot4.png')


ggplot(data=merge.sum, aes(x=Year, y=Emissions/1000)) + 

    geom_line(aes(group=1, col=Emissions)) + geom_point(aes(size=2, col=Emissions)) + 

    ggtitle(expression('Total Emissions of PM'[2.5])) + 

    ylab(expression(paste('PM', ''[2.5], ' in kilotons'))) + 

    geom_text(aes(label=round(Emissions/1000,digits=2), size=2, hjust=1.5, vjust=1.5)) + 

    theme(legend.position='none') + scale_colour_gradient(low='black', high='red')


dev.off()
