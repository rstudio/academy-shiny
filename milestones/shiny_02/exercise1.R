## Downloading from Shiny
## ----------------------
##
## Shiny is capable of letting users download files from your app. This is
## useful for exporting data or reports that users may want to save locally.
##
## This is facilitated via `downloadButton()` which is a variant of an
## `actionButton()` with specialized server syntax. As with other input widgets
## it is used in your UI and its appearance is determined by the `label` and
## `icon` arguments.
##
## The server side is handled by the `downloadHandler()` function which is paired
## with the button's id via `output` in the same as the usual `render*()` functions,
## e.g. `output$download_btn = downloadHandler(...)`.
##
## Unlike the other `render*()` functions, `downloadHandler()` takes
## two functions `filename` and `content` as arguments (rather than an R expression).
##
## * `filename` is a function that returns a character string that will be used
##   as the *default* filename for the download, i.e. what shows up in the download
##   dialog by default.
##
## * `content` is a function that takes the argument `file`, which is the path to
##   a temporary file location, and `content` is then expected to write out the
##   the content of the file to be downloaded file to that location (using something
##   like `readr::write_csv()`).

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
    downloadButton("download")
  ),
  card(
    card_header(
      textOutput("title"),
    ),
    card_body(
      plotOutput("plot")
    )
  )
)


server <- function(input, output, session) {
  output$download <- downloadHandler(
    filename = function() {
      # Remove spaces, convert to lowercase, and add .csv suffix
      input$name |>
        stringr::str_replace(" ", "_") |>
        tolower() |>
        paste0(".csv")
    },
    content = function(file) {
      # Write desired data to `file`
      readr::write_csv(d_city(), file)
    }
  )

  observe({
    updateSelectInput(
      session, "name",
      choices = d |>
        distinct(region, name) |>
        filter(region == input$region) |>
        pull(name)
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
