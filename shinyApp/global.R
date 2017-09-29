library(tidyverse)
library(shiny)
library(shinythemes)
library(ggthemes)
library(lubridate)
library(plotly)

crime = read_csv('../data/crime.csv')

df = crime %>%
  mutate(Date = mdy_hms(REPORTED_DATE), reportedIncidents = 1) %>%
  mutate(Year = year(Date), Month = month(Date), DayOfWeek = wday(Date, label=TRUE), Hour = hour(Date)) %>%
  select(Date, Month, DayOfWeek, Hour, FIRST_OCCURRENCE_DATE, LAST_OCCURRENCE_DATE, REPORTED_DATE,
         OFFENSE_TYPE_ID,OFFENSE_CATEGORY_ID,
         GEO_LAT,GEO_LON,NEIGHBORHOOD_ID, DISTRICT_ID, PRECINCT_ID,
         IS_CRIME, IS_TRAFFIC,
         reportedIncidents)
  

OFFENSE_CATEGORY_CHOICES = unique(df$OFFENSE_CATEGORY_ID)
