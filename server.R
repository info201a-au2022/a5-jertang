#Libraries
library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(tidyr)
library(rsconnect)

#source
source("ui.R")

#Dataset
carbon_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")
carbon_data <- na.omit(carbon_data)

#wrangled data for automatically generated values

#which country has the highest co2 emissions per capita and how much

highest_co2_usage_country <- carbon_data %>% 
  filter(co2_per_capita == max(co2_per_capita)) %>% 
  pull(country)

highest_co2_usage_num <- carbon_data %>% 
  filter(co2_per_capita == max(co2_per_capita)) %>% 
  pull(co2_per_capita)

#which country has the lowest co2 emissions per capita and how much
lowest_co2_usage_country <- carbon_data %>% 
  filter(co2_per_capita == min(co2_per_capita)) %>% 
  pull(country)

lowest_co2_usage_num <- carbon_data %>% 
  filter(co2_per_capita == min(co2_per_capita)) %>% 
  pull(co2_per_capita)

#whats the average co2 emissions per capita and how much
average_co2_usage_num <- carbon_data %>% 
  summarize(mean_co2 = mean(co2_per_capita)) %>% 
  pull(mean_co2)

#Start shinyServer
server <- function(input,output){
  
  interactive <- reactive({
    
    user_data <- carbon_data %>% 
      select(country, year, co2_per_capita, co2, total_ghg) %>% 
      filter(country %in% input$country_select)
    
    chart <- ggplot(carbon_data = user_data) +
      geom_line(mapping = aes_string(
        x = input$time_select,
        y = input$var_select),
        color = "black") +
      labs(title = "title",
           y = "Emissions",
           x = "Years")
          return(chart)
  })
  output$interact <- renderPlotly({
    interactive()
  })
}

