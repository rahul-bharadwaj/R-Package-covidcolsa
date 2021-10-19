#' Launch the Shiny App
#' 
#' This function automatically launches the Shiny App and makes it available to the user.
#' 
#'@export
launch_app <- function() {
  appDir <- system.file("app", "app.R", package = "covidcolsa")
  if (appDir == "") {
    stop("Could not find directory. Try re-installing `covidcolsa`.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal")
}