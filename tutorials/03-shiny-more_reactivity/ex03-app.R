library(tidyverse)
library(shiny)
library(bslib)

d <- readr::read_csv("data/weather.csv")

d_vars <- c(
  "Average temp" = "temp_avg",
  "Min temp" = "temp_min",
  "Max temp" = "temp_max",
  "Total precip" = "precip",
  "Snow depth" = "snow",
  "Wind direction" = "wind_direction",
  "Wind speed" = "wind_speed",
  "Air pressure" = "air_press"
)

ui <- page_sidebar(
  title = "Weather Forecasts",
  sidebar = sidebar(
    selectInput(
      "region", "Select a region",
      choices = c("West", "Midwest", "Northeast", "South")
    ),
    selectInput(
      "name", "Select an airport",
      choices = c()
    ),
    selectInput(
      "var", "Select a variable",
      choices = d_vars, selected = "temp_avg"
    ),
    actionButton("draw", "Draw plot")
  ),
  plotOutput("plot")
)


server <- function(input, output, session) {
  observe({
    updateSelectInput(
      inputId = "name",
      choices = d |>
        distinct(region, name) |>
        filter(region == input$region) |>
        pull(name)
    )
  })

  d_city <- reactive({
    req(input$name)
    d |>
      filter(name %in% input$name)
  })

  output$plot <- renderPlot({
    d_city() |>
      ggplot(aes(x = date, y = .data[[input$var]])) +
      ggtitle(names(d_vars)[d_vars == input$var]) +
      geom_line()
  }) |>
    bindEvent(input$draw)
}

shinyApp(ui = ui, server = server)
