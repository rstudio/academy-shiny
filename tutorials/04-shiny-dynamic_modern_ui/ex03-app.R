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
  ),
  
  # Hint - the following two UI elements will need to be placed in a single row
  # use layout_columns() with an appropriate col_widths to achieve this.
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
  ),
  
  # Hint - the arrangement of the value boxes is controled by the output of 
  # renderUI() in the server function.
  uiOutput("valueboxes") 
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

  output$valueboxes <- renderUI({
    clean <- function(x) {
      round(x, 1) |> paste("°C")
    }
    
    layout_columns(
      value_box(
        title = "Average Temp",
        value = mean(d_city()$temp_avg, na.rm = TRUE) |> clean(),
        showcase = bsicons::bs_icon("thermometer-half"),
        theme = "success"
      ),
      value_box(
        title = "Minimum Temp",
        value = min(d_city()$temp_min, na.rm = TRUE) |> clean(),
        showcase = bsicons::bs_icon("thermometer-snow"),
        theme = "primary"
      ),
      value_box(
        title = "Maximum Temp",
        value = max(d_city()$temp_max, na.rm = TRUE) |> clean(),
        showcase = bsicons::bs_icon("thermometer-sun"),
        theme = "danger"
      )
    )
  })

  output$title <- renderText({
    paste0(names(d_vars)[d_vars == input$var], " — ", input$name, " (", input$region, ")")
  })

  d_city <- reactive({
    req(input$name)
    d |>
      filter(name %in% input$name)
  })

  output$plot <- renderPlot({
    d_city() |>
      ggplot(aes(x = date, y = .data[[input$var]])) +
      geom_line()
  })
}

shinyApp(ui = ui, server = server)
