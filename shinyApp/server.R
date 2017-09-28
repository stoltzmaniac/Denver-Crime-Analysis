shinyServer(
  function(input, output){
    
    # output$reportedDateList = renderUI({
    #   dateRangeInput("reportedDateRange", "Reported Date Range:",
    #                  start = min(df$REPORTED_DATE), end = max(df$REPORTED_DATE))
    # })
    # 
    # output$categoryList = renderUI({
    #   selectInput("variable1","Choose Option",
    #     unique(df$OFFENSE_CATEGORY_ID)
    #   )
    #   })
    # 
    # output$neighborhoodList = renderUI({
    #   selectInput("variable2","Choose Option",
    #     unique(df$NEIGHBORHOOD_ID)
    #   )
    #   })
    # 
    # output$typeList = renderUI({
    #   selectInput("variable3","Choose Option",
    #     unique(df$OFFENSE_TYPE_ID)
    #   )
    #   })
    
    # output$chart = renderPlot({
    #   ggplot(df %>% mutate(date = as.Date(REPORTED_DATE)) %>% group_by(date) %>% summarise(n=n()), aes(x=date,y=n)) + geom_line()
    
    df_reactive = reactive({
      tmp = df %>% 
        group_by(DayOfWeek, OFFENSE_CATEGORY_ID) %>% filter(OFFENSE_CATEGORY_ID %in% input$offenseCategory) %>% 
        mutate_if(is.numeric,sum)
    })
  
    # output$plot = renderPlotly({
    #   df_filtered = df_reactive()
    #   p = ggplot(df_filtered, aes(x = Date, y = reportedIncidents, col = OFFENSE_CATEGORY_ID)) + geom_line() + theme_minimal()
    #   ggplotly(p)
    # })
    
    output$plot = renderPlot({
      df_filtered = df_reactive()
      ggplot(df_filtered, aes(x = DayOfWeek, y = reportedIncidents, col = OFFENSE_CATEGORY_ID, fill = OFFENSE_CATEGORY_ID)) + 
        geom_bar(stat='identity') +
        facet_wrap(~OFFENSE_CATEGORY_ID, scales='free') + 
        theme(legend.position = 'none')
    })
    
  }
)