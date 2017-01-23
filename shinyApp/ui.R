shinyUI(fluidPage(
  titlePanel("Denver Crime Data"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Create demographic maps with 
        information from the 2010 US Census."),
      
      selectInput("var", 
                  label = "Choose a variable to display",
                  choices = uiOutput(NEIGHBORHOOD_ID))
    ),
    
    mainPanel(plotOutput("chart"))
  )
))