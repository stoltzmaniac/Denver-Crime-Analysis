library(RSQLite)
library(dplyr)
library(lubridate)
library(ggmap)

con = dbConnect(RSQLite::SQLite(),dbname='crime.sqlite')
rs = dbSendQuery(con, "SELECT * FROM crime") 
data = dbFetch(rs)
data$date = as.Date(data$REPORTED_DATE)
data$year = year(data$date)
data$month = month(data$date)
data$day = day(data$date)
data$hour = hour(data$REPORTED_DATE)

df = data %>%
  select(date,year,month,day,hour,
         OFFENSE_TYPE_ID,OFFENSE_CATEGORY_ID,
         GEO_LAT,GEO_LON,NEIGHBORHOOD_ID)

rm(data)

pMap = ggmap(get_map(location = "Denver, Colorado, United States",
                     zoom=12,
                     maptype = 'terrain',
                     color = "bw")) 

shinyServer(
  function(input, output){
    
    output$categoryList = renderUI({
      selectInput("variable1","Choose Option",
        unique(df$OFFENSE_CATEGORY_ID)
      )
      })
    
    output$neighborhoodList = renderUI({
      selectInput("variable2","Choose Option",
        unique(df$NEIGHBORHOOD_ID)
      )
      })
    
    output$typeList = renderUI({
      selectInput("variable3","Choose Option",
        unique(df$OFFENSE_TYPE_ID)
      )
      })
    
    output$chart = renderPlot({
      pMap + geom_point(data=df %>%
                          filter(date == '2016-01-01'),
                        aes(x=GEO_LON,
                            y=GEO_LAT,
                            col=NEIGHBORHOOD_ID)
                        ) + 
        theme(legend.position='none')
      
    })
  }
)