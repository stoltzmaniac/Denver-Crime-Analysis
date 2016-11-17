library(dplyr)
library(lubridate)
library(ggplot2)
options("stringsAsFactors" = TRUE)

####
# Data from: http://data.denvergov.org/dataset/city-and-county-of-denver-crime
# File name: crime.csv
CWD = getwd()
data = read.csv(paste(CWD,'/data/crime.csv',sep=''))
####

#Consider FIRST_OCCURRENCE_DATE as date for analysis (at least for now)
data$date = as.Date(data$FIRST_OCCURRENCE_DATE)

#Create columns for year, month, day, hour
data$year = factor(year(data$date))
data$month = factor(month(data$date))
data$day = factor(day(data$date))
data$hour = factor(hour(data$FIRST_OCCURRENCE_DATE))

#Create new column for crimes (may speed up sum instead of count function)
data$crimes = 1

#View data
head(data)

#Basic data exploration
##########################
#Basic exploration of data
##########################

#Count of lines per year
p = ggplot(data,aes(year,fill=month)) 
p + geom_bar()