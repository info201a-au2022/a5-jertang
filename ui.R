#Libraries
library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(tidyr)
library(rsconnect)

#Source
source("server.R")


introduction_ui <- fluidPage(
  headerPanel(""),
)

page_2_ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      
      selectInput(inputId = "country_select",
                  lable = "Select Country",
                  choices = unique(carbon_data$country),
                  selected = "United States"),
      
      selectInput(inputId = "var_select",
                  lable = "Select Variable",
                  choices = c("co2_per_capita", "co2", "total_ghg"),
                  selected = "co2_per_capita")),
    
      sliderInput(inputId = "time_select",
                  lable = "Select Time Range",
                  min = min(carbon_data$year),
                  max = max(carbon_data$year),
                  sep = "",
                  value = c(1950, 2021))
      
    ),
  mainPanel(
    plotlyOutput(outputId = "interact"),
    p("Chart Descript")
  )
)
  


ui <- navbarPage(
  title = "Assignment 5",
  tabPanel("Introduction", introduction_ui),
  tabPanel("", page_2_ui),
)
