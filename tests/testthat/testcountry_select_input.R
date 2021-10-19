library(testthat)

test_that("country_select_input()", {
  expect_equal(
    country_select_input("country", covid_colsa$key_apple_mobility),
    (shiny::selectInput("country", label = "Which region do you want to examine?",
                       choices = covid_colsa$key_apple_mobility,
                       selected = ""))
  )
})