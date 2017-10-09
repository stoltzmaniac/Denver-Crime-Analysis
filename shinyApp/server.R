shinyServer(
  function(input, output){
    
    df_time_group_reactive = eventReactive(input$updateFilter, { 
      tmp = df %>%
        filter(Date >= input$reportedDateRange[1] & Date <= input$reportedDateRange[2]) %>%
        filter(OFFENSE_CATEGORY_ID %in% input$offenseCategory) %>% 
        group_by_(input$groupTimeChoice, input$groupCategory) %>%
        summarise(reportedIncidents = sum(reportedIncidents))
      })
    
    df_dow_reactive = eventReactive(input$updateFilter, {
      tmp = df %>% 
        filter(Date >= input$reportedDateRange[1] & Date <= input$reportedDateRange[2]) %>%
        group_by_('DayOfWeek', 'OFFENSE_CATEGORY_ID') %>% 
        filter(OFFENSE_CATEGORY_ID %in% input$offenseCategory) %>% 
        summarise(reportedIncidents = sum(reportedIncidents))
    })
    
    df_moy_reactive = eventReactive(input$updateFilter, {
      tmp = df %>% 
        filter(Date >= input$reportedDateRange[1] & Date <= input$reportedDateRange[2]) %>%
        group_by(Month, OFFENSE_CATEGORY_ID) %>% 
        filter(OFFENSE_CATEGORY_ID %in% input$offenseCategory) %>% 
        summarise(reportedIncidents = sum(reportedIncidents))
    })
    
    df_hod_reactive = eventReactive(input$updateFilter, {
      tmp = df %>% 
        filter(Date >= input$reportedDateRange[1] & Date <= input$reportedDateRange[2]) %>%
        group_by(Hour, OFFENSE_CATEGORY_ID) %>% 
        filter(OFFENSE_CATEGORY_ID %in% input$offenseCategory) %>% 
        summarise(reportedIncidents = sum(reportedIncidents))
    })
    
    df_ts_reactive = eventReactive(input$updateFilter, {
      tmp = df %>% arrange(Year,Month) %>% 
        mutate(Year_Month = factor(paste0(Year, "_", Month))) %>%
        filter(Date >= input$reportedDateRange[1] & Date <= input$reportedDateRange[2]) %>%
        group_by(Year_Month, OFFENSE_CATEGORY_ID) %>% 
        filter(OFFENSE_CATEGORY_ID %in% input$offenseCategory) %>% 
        summarise(reportedIncidents = sum(reportedIncidents))
    })
    
    df_neighborhood_reactive = eventReactive(input$updateFilter, {
      tmp = df %>% 
        filter(Date >= input$reportedDateRange[1] & Date <= input$reportedDateRange[2]) %>%
        filter(OFFENSE_CATEGORY_ID %in% input$offenseCategory) %>% 
        group_by(NEIGHBORHOOD_ID) %>% 
        summarise(reportedIncidents = sum(reportedIncidents))
    })
    
    output$plotDOW = renderPlot({
      df_filtered = df_time_group_reactive()
      ggplot(df_filtered, aes_string(x = input$groupTimeChoice, y = "reportedIncidents", col = input$groupCategory, fill = input$groupCategory)) + 
        geom_bar(stat='identity') +
        facet_wrap(as.formula(paste0("~",input$groupCategory)), scales='free') + 
        theme(legend.position = 'none')
    })
    
    output$plotHOD = renderPlot({
      df_filtered = df_hod_reactive()
      ggplot(df_filtered, aes(x = Hour, y = reportedIncidents, col = OFFENSE_CATEGORY_ID, fill = OFFENSE_CATEGORY_ID)) + 
        geom_bar(stat='identity') +
        facet_wrap(~OFFENSE_CATEGORY_ID, scales='free') + 
        theme(legend.position = 'none')
    })
    
    output$plotMOY = renderPlot({
      df_filtered = df_moy_reactive()
      ggplot(df_filtered, aes(x = Month, y = reportedIncidents, col = OFFENSE_CATEGORY_ID, fill = OFFENSE_CATEGORY_ID)) + 
        geom_bar(stat='identity') +
        facet_wrap(~OFFENSE_CATEGORY_ID, scales='free') + 
        theme(legend.position = 'none')
    })
    
    output$timeSeriesPlot = renderPlot({
      df_filtered = df_ts_reactive()
      ggplot(df_filtered, aes(x = Year_Month, y = reportedIncidents, group=OFFENSE_CATEGORY_ID, col = OFFENSE_CATEGORY_ID, fill = OFFENSE_CATEGORY_ID)) + 
        geom_line() +
        geom_smooth(se=FALSE) +
        facet_wrap(~OFFENSE_CATEGORY_ID, scales='free') + 
        theme(legend.position = 'none')
    })
    
    output$neighborhood = renderPlot({
      df_filtered = df_neighborhood_reactive()
      ggplot(df_filtered, aes(x = reorder(NEIGHBORHOOD_ID, reportedIncidents), y = reportedIncidents)) + 
        geom_bar(stat='identity') + 
        xlab('NEIGHBORHOOD_ID') +
        coord_flip() + 
        theme(legend.position = 'none')
    })
    
  }
)