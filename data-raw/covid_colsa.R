## code to prepare `covid_colsa` dataset goes here

#loading libraries
library(COVID19)
library(tidyverse)

#Reading Dataset
covid_colsa <- COVID19::covid19(country = c("South Africa", "Colombia"), verbose = FALSE)

#wrangling COL
nCovCOL <- covid_colsa %>% select(date, tests, confirmed, recovered, deaths) %>% filter(id == "COL")

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
nCovZAF <- covid_colsa %>% select(date, tests, confirmed, recovered, deaths) %>% filter(id == "ZAF")

DailyZAF <- nCovZAF %>% mutate(lag_tests = lag(nCovZAF$tests),
                               dailytest = (nCovZAF$tests - lag_tests),
                               lag_confirm = lag(nCovZAF$confirmed),
                               dailyconfirm = (nCovZAF$confirmed - lag_confirm),
                               lag_recover = lag(nCovZAF$recovered),
                               dailyrecover = (nCovZAF$recovered - lag_recover),
                               lag_deaths = lag(nCovZAF$deaths),
                               dailydeaths = (nCovZAF$deaths - lag_deaths)) %>%
  select(date, dailytest, dailyconfirm, dailyrecover, dailydeaths)

usethis::use_data(covid_colsa, overwrite = TRUE)
usethis::use_data(DailyCOL, overwrite = TRUE)
usethis::use_data(DailyZAF, overwrite = TRUE)