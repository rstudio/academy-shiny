library(tidyverse)
library(shiny)
library(bslib)

d <- readr::read_csv("data/weather.csv")

ui <- page_sidebar(
  title = "Temperature Forecasts",
  sidebar = sidebar(
    radioButtons(
      inputId = "name",
      label = "Select an airport",
      choices = c(
        "Raleigh-Durham",
        "Houston Intercontinental",
        "Denver",
        "Los Angeles",
        "John F. Kennedy"
      )
    )
  ),
  plotOutput("plot")
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    d |>
      filter(name %in% input$name) |>
      ggplot(aes(x = date, y = temp_avg, color = name)) +
      geom_line()
  })
}

shinyApp(ui = ui, server = server)
