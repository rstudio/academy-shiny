library(tidyverse)
library(shiny)
library(bslib)

d = readr::read_csv("data/weather-09.csv")

d_vars = c("Average temp" = "temp_avg",
           "Min temp" = "temp_min",
           "Max temp" = "temp_max",
           "Total precip" = "precip",
           "Snow depth" = "snow",
           "Wind direction" = "wind_direction",
           "Wind speed" = "wind_speed",
           "Air pressure" = "air_press")

ui = page_sidebar(
  title = "Weather Forecasts",
  sidebar = sidebar(
    selectInput(
      "region", "Select a region",
      choices = c("West", "Midwest", "Northeast", "South")
    ),
    selectInput(
      "name", "Select an airport", choices = c()
    ),

  ),
  card(
    card_header(
      textOutput("title"),
      popover(
        bsicons::bs_icon("gear", title = "Settings"),
        selectInput(
          "var", "Select a variable",
          choices = d_vars, selected = "temp_avg"
        )
      ),
      class = "d-flex justify-content-between align-items-center"
    ),
    card_body(
      plotOutput("plot")
    ),
    full_screen = TRUE
  )
)


server = function(input, output, session) {

  observe({
    updateSelectInput(
      inputId = "name",
      choices = d |>
        distinct(region, name) |>
        filter(region == input$region) |>
        pull(name)
    )
  })

  output$title = renderText({
    paste0(names(d_vars)[d_vars == input$var], " — ", input$name, " (", input$region, ")")
  })

  d_city = reactive({
    # TODO: Add req(input$name) here to wait for user selection
    d |>
      filter(name %in% input$name, !is.na(date))
  })

  output$plot = renderPlot({
    # TODO: Add validate(need(...)) to show a message if d_city() is empty
    # Check if nrow(d_city()) > 0
    # Message: "No data available for this selection"

    d_city() |>
      ggplot(aes(x=date, y=.data[[input$var]])) +
      geom_line()
  })

}

shinyApp(ui = ui, server = server)
