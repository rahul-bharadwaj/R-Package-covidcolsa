# covidcolsa
<!-- badges: start -->
[![R build status](https://github.com/etc5523-2020/r-package-assessment-rahul-bharadwaj/workflows/R-CMD-check/badge.svg)](https://github.com/etc5523-2020/r-package-assessment-rahul-bharadwaj/actions)
<!-- badges: end -->

The goal of 'covidcolsa' is to make available the Coivd-19 data and statistics for Colombia and South Africa easy to access through R Shiny App that can be run by simple functions using the package. It consists of the counts of tests, cases, recoveries, and deaths summarized and compared between the two regions.

## Installation

You can install the  covidcolsa with:

``` r
# install.package("devtools")
devtools::install_github("etc5523-2020/r-package-assessment-rahul-bharadwaj")
```

## Example

This is a basic example which loads the required datasets:

``` r
library(covidcolsa)
covid_colsa
DailyCOL
DailyZAF
```