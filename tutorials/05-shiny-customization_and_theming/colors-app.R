library(tidyverse)
library(shiny)
library(bslib)

ui <- page_fluid(
  theme = bs_theme(version = 5),
  title = "Custom Colors",
  br(), br(),
  actionButton("primary", "Primary", class = "btn-primary"),
  br(), br(),
  actionButton("secondary", "Secondary", class = "btn-secondary"),
  br(), br(),
  actionButton("success", "Success", class = "btn-success"),
  br(), br(),
  actionButton("danger", "Danger", class = "btn-danger"),
  br(), br(),
  actionButton("warning", "Warning", class = "btn-warning"),
  br(), br(),
  actionButton("light", "Light", class = "btn-light"),
  br(), br(),
  actionButton("dark", "Dark", class = "btn-dark")
)


server <- function(input, output, session) {
  bs_themer()
}

shinyApp(ui = ui, server = server)
