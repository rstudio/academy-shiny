# Testing the weather app with shinytest2
# This is a minimal example of a Shiny app test

library(shinytest2)
library(testthat)

# Run this file to see the test in action!
# In a real project, this would be in tests/testthat/test-app.R

test_that("Weather app loads and responds to inputs", {
  # Start the app (assumes app.R is in the same directory)
  # In practice, you'd point to your app directory
  app <- AppDriver$new(
    name = "weather-app",
    height = 800,
    width = 1200
  )

  # TODO: Try changing this to test a different region
  # Options: "West", "Midwest", "Northeast", "South"
  app$set_inputs(region = "West")

  # Wait for the region dropdown to populate
  Sys.sleep(1)

  # Select an airport
  app$set_inputs(name = "San Francisco, CA")

  # Check that outputs rendered correctly
  # This creates a snapshot of all output values
  app$expect_values()

  # Test passed! The app loaded and responded to inputs.
})

# To run this test:
# 1. Make sure you have shinytest2 installed: install.packages("shinytest2")
# 2. In your Console, run (from the repo root):
#    testthat::test_file("08-shiny-production_ready_apps/testing.R")
#    (test_file() runs the test with this folder as the working directory,
#    so AppDriver can find app.R)
# 3. The test will open a headless browser, interact with the app, and check outputs
