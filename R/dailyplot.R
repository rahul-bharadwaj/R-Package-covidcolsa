#' Daily Count Plot
#' 
#' This function plots daily counts of tests, confirmed cases, recoveries, and deaths for the given data that has variable names "dailytested", "dailyconfirmed", "dailyrecovered", and "dailydeaths". 
#' 
#' @param data A dataset which consists of daily counts of all attributes.
#' 
#' @export
dailyplot <- function(data){
  library(ggplot2)
  data %>% ggplot() +
    geom_line(aes(x = date, y = dailytest, color = "dailytested")) +
    geom_line(aes(x = date, y = dailyconfirm, color = "dailyconfirmed")) +
    geom_line(aes(x = date, y = dailyrecover, color = "dailyrecovered")) +
    geom_line(aes(x = date, y = dailydeaths, color = "dailydeaths")) +
    xlab("Date") + ylab("Attribute Counts") +
    ggtitle("Daily Timeline Curves for Covid") +
    theme_light()
}