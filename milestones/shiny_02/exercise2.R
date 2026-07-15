## Uploading a file to Shiny
## -------------------------
##
## Shiny provides the `fileInput()` widget which allows users to select one or
## more files from their local system to upload to an app.
##
## This widget behaves a bit differently than the others we have seen thus far.
## It does not have a `value` that is accessible in the same way as other inputs,
## at least initially.
##
## Before a file is uploaded, the input will return `NULL` if accessed. After
## file(s) are uploaded the input returns a data frame with one row per file
## and the columns: `name`, `size`, `type`, and `datapath.` The last is the most important
## as it is a path to the temporary file on the server which contains the uploaded
## file and is what your app will need to read in.
##
## Below is a sample app that demonstrates how to use `fileInput()`. The main panel
## has two sections:
##
## * *Result* which displays the raw data frame returned by `input$upload`
##
## * *Content* which displays the data frame read in by `readr::read_csv()` using
##   `datapath`
##
## Note in both `renderTable()` calls we use `req(input$upload)` to ensure that
## our subsequent code only runs after a file has been uploaded.

library(tidyverse)
library(shiny)
library(bslib)

ui <- page_sidebar(
  title = "File Upload",
  sidebar = sidebar(
    fileInput(
      inputId = "upload",
      label = "Upload a file",
      # Specify the file type(s) that can be uploaded (does not guarantee a csv)
      accept = ".csv"
    )
  ),
  h3("Result"),
  tableOutput("result"),
  h3("Content"),
  tableOutput("data")
)

server <- function(input, output, session) {
  output$result <- renderTable({
    req(input$upload) # req() is used to ensure the file is uploaded
    input$upload
  })

  output$data <- renderTable({
    req(input$upload) # req() is used to ensure the file is uploaded
    readr::read_csv(input$upload$datapath) # we assume only a single file has been uploaded
  })
}

shinyApp(ui = ui, server = server)
