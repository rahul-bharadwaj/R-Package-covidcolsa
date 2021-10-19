# Covid-19 Shiny App for ETC5523 Assessment
# Author - Rahul Bharadwaj (31322239)

#loading libraries
library(covidcolsa)
library(shiny)
library(shinythemes)
library(tidyverse)
library(plotly)
library(COVID19)
library(DT)
library(reactable)

##################################################################################################

#Reading Dataset
covid <- COVID19::covid19(country = c("South Africa", "Colombia"), verbose = FALSE)

#wrangling COL
nCovCOL <- covid %>% select(date, tests, confirmed, recovered, deaths) %>% filter(id == "COL")

DailyCOL <- nCovCOL %>% mutate(lag_tests = lag(nCovCOL$tests),
                         dailytest = (nCovCOL$tests - lag_tests),
                         lag_confirm = lag(nCovCOL$confirmed),
                         dailyconfirm = (nCovCOL$confirmed - lag_confirm),
                         lag_recover = lag(nCovCOL$recovered),
                         dailyrecover = (nCovCOL$recovered - lag_recover),
                         lag_deaths = lag(nCovCOL$deaths),
                         dailydeaths = (nCovCOL$deaths - lag_deaths)) %>%
  select(date, dailytest, dailyconfirm, dailyrecover, dailydeaths)

#wrangling ZAF
nCovZAF <- covid %>% select(date, tests, confirmed, recovered, deaths) %>% filter(id == "ZAF")

DailyZAF <- nCovZAF %>% mutate(lag_tests = lag(nCovZAF$tests),
                               dailytest = (nCovZAF$tests - lag_tests),
                               lag_confirm = lag(nCovZAF$confirmed),
                               dailyconfirm = (nCovZAF$confirmed - lag_confirm),
                               lag_recover = lag(nCovZAF$recovered),
                               dailyrecover = (nCovZAF$recovered - lag_recover),
                               lag_deaths = lag(nCovZAF$deaths),
                               dailydeaths = (nCovZAF$deaths - lag_deaths)) %>%
  select(date, dailytest, dailyconfirm, dailyrecover, dailydeaths)

##################################################################################################

# Define UI for application
ui <- fluidPage( theme = shinytheme("flatly"),
  navbarPage(
    title = "Covid Dashboard",
    tabPanel("About",
             includeMarkdown("shiny.md"),
             reactableOutput("data")
             ),
    tabPanel("Total Count Comparison",
             sidebarLayout(
               sidebarPanel(country_select_input("country", covid_colsa$key_apple_mobility),
                    plotlyOutput("test"),
                    plotlyOutput("confirm"),
                    plotlyOutput("recover"),
                    plotlyOutput("death")
                ),
               mainPanel(
                 #
                 plotlyOutput("compare"),
                 includeText("textfiles/total.txt"),
                 DT::dataTableOutput("table")
              )
            )
    ),
    tabPanel("Attribute Count Comparison",
             sidebarLayout(
               sidebarPanel(radioButtons("attribute", "Which attribute do you want to examine?",
                                         choices = c("Tests", "Confirmed", "Recovered", "Deaths"))
               ),
               mainPanel(
                  plotlyOutput("attr"),
                  includeText("textfiles/attr.txt")
               )
             )
    ),
    navbarMenu("Daily Counts",
               tabPanel("Colombia",
                        plotlyOutput("COL"),
                        includeText("textfiles/col.txt"),
                        DT::dataTableOutput("COLtable")
                        ),
               tabPanel("South Africa",
                        plotlyOutput("SA"),
                        includeText("textfiles/sa.txt"),
                        DT::dataTableOutput("SAtable")
                        )
    ),
    tabPanel("Citation",
             includeMarkdown("citation.md")
    )
  )
)

##################################################################################################

server <- function(input, output, session) {
  
  output$data <- renderReactable ({
      #datatable(covid, options = list(lengthMenu = c(5, 10)))
      reactable(covid)
  })
  
  output$test <- renderPlotly({
    ggplot(covid) +
      geom_bar(aes(x = key_apple_mobility, y = tests, fill = key_apple_mobility), stat = "identity") +
      theme(legend.title = element_blank()) + xlab("country")
  })
  
  output$confirm <- renderPlotly({
    ggplot(covid) +
      geom_bar(aes(x = key_apple_mobility, y = confirmed, fill = key_apple_mobility), stat = "identity") +
      theme(legend.title = element_blank()) + xlab("country")
  })
  output$recover <- renderPlotly({
    ggplot(covid) +
      geom_bar(aes(x = key_apple_mobility, y = recovered, fill = key_apple_mobility), stat = "identity") +
      theme(legend.title = element_blank()) + xlab("country")
  })
  output$death <- renderPlotly({
    ggplot(covid) +
      geom_bar(aes(x = key_apple_mobility, y = deaths, fill = key_apple_mobility), stat = "identity") +
      theme(legend.title = element_blank()) + xlab("country")
  })
  
  output$compare <- renderPlotly({
    covid %>% filter(key_apple_mobility == input$country) %>% ggplot() +
      geom_path(aes(x = date, y = tests, color = "tested")) +
      geom_path(aes(x = date, y = confirmed, color = "confirmed")) +
      geom_path(aes(x = date, y = recovered, color = "recovered")) +
      geom_path(aes(x = date, y = deaths, color = "deaths")) +
      xlab("Date") + ylab("Attribute Counts") +
      theme_bw() + labs(title = paste("Timeline Curves in", input$country))
  })
  
  output$table <- DT::renderDataTable({
    covid %>% filter(key_apple_mobility == input$country) %>%
      select(date, tests, confirmed, recovered, deaths) %>%
      datatable(options = list(lengthMenu = c(25, 50, 100)))
  })
  
  output$attr <- renderPlotly({
    if(input$attribute == "Tests"){
      covid %>% ggplot(aes(color = key_apple_mobility)) +
        geom_path(aes(x = date, y = tests)) +
        xlab("Date") + ylab("Test Count") +
        theme(legend.title = element_blank()) + ggtitle("Testing Comparison")
    }
    
    else if(input$attribute == "Confirmed"){
      covid %>% ggplot(aes(color = key_apple_mobility)) +
        geom_path(aes(x = date, y = confirmed)) +
        xlab("Date") + ylab("Confirmed Count") +
        theme(legend.title = element_blank()) + ggtitle("Confirmed Cases Comparison")
    }
    
    else if(input$attribute == "Recovered"){
      covid %>% ggplot(aes(color = key_apple_mobility)) +
        geom_path(aes(x = date, y = recovered)) +
        xlab("Date") + ylab("Recovery Count") +
        theme(legend.title = element_blank()) + ggtitle("Recovery Comparison")
    }
    
    else if(input$attribute == "Deaths"){
      covid %>% ggplot(aes(color = key_apple_mobility)) +
        geom_path(aes(x = date, y = deaths)) +
        xlab("Date") + ylab("Death Counts") +
        theme(legend.title = element_blank()) + ggtitle("Death Counts Comparison")
    }
  })
  
  output$SAtable <- DT::renderDataTable({
    DT::datatable(DailyZAF)
  })
  
  output$SA <- renderPlotly({
    dailyplot(DailyZAF)
  })
  
  output$COLtable <- DT::renderDataTable({
    DT::datatable(DailyCOL)
  })
  
  output$COL <- renderPlotly({
    dailyplot(DailyCOL)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)