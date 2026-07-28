library(tidyverse)
library(shiny)
library(bslib)
library(leaflet)

d = readr::read_csv("data/weather.csv")

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
  layout_column_wrap(
    fill = FALSE,
    uiOutput("valueboxes")
  ),
  layout_columns(
    col_widths = c(8,4),
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
    # TODO: Add a card with a leaflet map here, next to the plot card!
    # Use: card() with card_header() and card_body()
    # Inside card_body(), add: leafletOutput("map", height = 400)
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

  output$valueboxes = renderUI({
    clean = function(x) {
      round(x,1) |> paste("°C")
    }

    layout_column_wrap(
      fill = FALSE,
      value_box(
        title = "Average Temp",
        value = mean(d_city()$temp_avg, na.rm=TRUE) |> clean(),
        showcase = bsicons::bs_icon("thermometer-half"),
        theme = "success"
      ),
      value_box(
        title = "Minimum Temp",
        value = min(d_city()$temp_min, na.rm=TRUE) |> clean(),
        showcase = bsicons::bs_icon("thermometer-snow"),
        theme = "primary"
      ),
      value_box(
        title = "Maximum Temp",
        value = max(d_city()$temp_max, na.rm=TRUE) |> clean(),
        showcase = bsicons::bs_icon("thermometer-sun"),
        theme = "danger"
      )
    )
  })

  output$title = renderText({
    paste0(names(d_vars)[d_vars == input$var], " — ", input$name, " (", input$region, ")")
  })

  d_city = reactive({
    req(input$name)
    d |>
      filter(name %in% input$name)
  })

  output$plot = renderPlot({
    d_city() |>
      ggplot(aes(x=date, y=.data[[input$var]])) +
      geom_line()
  })

  # TODO: Add a reactive leaflet map here!
  # 1. Filter d by input$region
  # 2. Get distinct name, longitude, latitude, state
  # 3. Use leaflet(data = airports) |>
  #      addTiles() |>
  #      addMarkers(lng = ~longitude, lat = ~latitude, popup = ~name)

}

shinyApp(ui = ui, server = server)
