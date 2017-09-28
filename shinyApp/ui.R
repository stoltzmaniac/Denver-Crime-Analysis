shinyUI(fluidPage(
  titlePanel("Denver Crime Data"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Data Source: https://www.denvergov.org/opendata/dataset/city-and-county-of-denver-crime"),
      
      dateRangeInput("reportedDateRange", "Reported Date Range:",
                     start = min(df$REPORTED_DATE), end = max(df$REPORTED_DATE)),
    
      checkboxGroupInput("offenseCategory", "Offense Category:",
                         choices = OFFENSE_CATEGORY_CHOICES,
                         selected = OFFENSE_CATEGORY_CHOICES[1:3])
      
      ),
  
    mainPanel(
      #plotOutput("chart")
      #plotlyOutput("plot")
      plotOutput('plot')
      )
  )
))