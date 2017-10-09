shinyUI(fluidPage(
  titlePanel("Denver Crime Data"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Data Source: https://www.denvergov.org/opendata/dataset/city-and-county-of-denver-crime"),
      
      dateRangeInput("reportedDateRange", "Reported Date Range:",
                     start = min(df$REPORTED_DATE), end = max(df$REPORTED_DATE)),
      
      selectInput("groupCategory","Explore Data by Category:",
                  choices = c("OFFENSE_CATEGORY_ID", "OFFENSE_TYPE_ID", "NEIGHBORHOOD_ID", "IS_TRAFFIC", "IS_CRIME"),
                  selected = "OFFENSE_CATEGORY_ID"),
    
      checkboxGroupInput("offenseCategory", "Offense Category:",
                         choices = OFFENSE_CATEGORY_CHOICES,
                         selected = OFFENSE_CATEGORY_CHOICES[1:3]),
      
      actionButton("updateFilter", "Update")
      
      ),
  
    mainPanel(
      tabsetPanel(id = 'main',
                  
                  tabPanel('Month of Year', p(),
                           fluidRow(plotOutput('plotMOY'))
                           ),
                  
                  tabPanel('Day of Week', p(),
                           fluidRow(selectInput("groupTimeChoice", "Explore by Time Period:",
                                                choices = c("Year","Month","DayOfWeek","Hour"),
                                                selected = "DayOfWeek"),
                                    plotOutput('plotDOW'))
                           ),
                  
                  tabPanel('Hour of Day', p(),
                           fluidRow(plotOutput('plotHOD'))
                           ),
                  
                  tabPanel('Neighborhood', p(),
                           fluidRow(sliderInput("neighborhoodRows", "Maximum Results: ",
                                                min = 1,
                                                max = 25,
                                                value = 15),
                                    plotOutput('neighborhood'))
                           ),
                  
                  tabPanel('Map', p(),
                           fluidRow(sliderInput("mapRows", "Maximum Results: ",
                                                min = 100,
                                                max = 5000,
                                                value = 300,
                                                step = 100),
                                    leafletOutput('map'))
                          )
      )
  )
)))