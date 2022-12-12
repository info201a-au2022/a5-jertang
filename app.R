#Libraries
library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(tidyr)
library(rsconnect)

#Sources
source("server.R")
source("ui.R")

# Run the application 
shinyApp(ui = ui, server = server)
