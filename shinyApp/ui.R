shinyUI(fluidPage(
  titlePanel("Denver Crime Data"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Data Source: https://www.denvergov.org/opendata/dataset/city-and-county-of-denver-crime"),
      
      dateRangeInput("reportedDateRange", "Reported Date Range:",
                     start = min(df$REPORTED_DATE), end = max(df$REPORTED_DATE)),
      
      selectInput("groupTimeChoice", "Explore by Time Period:",
                  choices = c("Year","Month","DayOfWeek","Hour"),
                  selected = "DayOfWeek"),
      
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
                  tabPanel('Day of Week', p(),
                           fluidRow(plotOutput('plotDOW'))
                           ),
                  tabPanel('Hour of Day', p(),
                           fluidRow(plotOutput('plotHOD'))
                           ),
                  tabPanel('Month of Year', p(),
                           fluidRow(plotOutput('plotMOY'))
                           ),
                  tabPanel('Neighborhood', p(),
                           fluidRow(plotOutput('neighborhood', height = '800px', width = '100%'))
                           )
      )
  )
)))