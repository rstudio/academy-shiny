# Testing the weather app with shiny::testServer()
# This is a minimal example of a Shiny app test

library(shiny)
library(testthat)

# Run this file to see the test in action!
# In a real project, this would be in tests/testthat/test-app.R

test_that("Weather app responds to region and airport selection", {
  # "." is the app in this folder (app.R). test_file() runs this test with its
  # own folder as the working directory, so the app can find data/weather.csv.
  testServer(".", {
    # TODO: Try changing this to a different region and one of its airports.
    # West: "San Francisco", "Denver", "Seattle-Tacoma", "Los Angeles"
    # Northeast: "Boston Logan", "Newark", "John F. Kennedy"
    # South: "Miami", "Orlando", "Raleigh-Durham"
    session$setInputs(
      region = "West",
      name = "San Francisco",
      var = "temp_avg"
    )

    # The d_city() reactive should hold data for the selected airport only
    expect_equal(unique(d_city()$name), "San Francisco")

    # The card header should describe the current selection
    expect_equal(output$title, "Average temp — San Francisco (West)")

    # The plot should render without error
    expect_true(nchar(output$plot$src) > 0)
  })
})

# To run this test:
# 1. In your Console, run (from the repo root):
#    testthat::test_file("tutorials/08-shiny-production_ready_apps/testing.R")
#    (test_file() runs the test with this folder as the working directory,
#    so testServer(".") can find app.R)
# 2. You should see "Test passed", with one success per expect_*() call
