---
title: "About - Description of the Dashboard"
output: html_document
---

#### Author - Rahul Bharadwaj Mysore Venkatesh
#### Date - 09/10/2020

![](Covid.PNG)

#### **Purpose of the Shiny App -**

* This is a dashboard of Covid-19 stats for the countries Colombia and South Africa. The purpose of this Shiny App is to make the explanation easy, interactive and concise in the form of a Web-App that can be shared and easily used. Interactive and UI-based data stories are more effective in conveying the explanations and involving the user completely.

#### **Background on Previous Blogs -** 

* This Shiny App is based on two blogs created previously, one each for South Africa and Colombia.

* The following are the two blogs that are combined in this Shiny App to explain Covid-19 in both the countries.

  + [A data story of COVID-19 in Colombia.](https://rahul-bharadwaj.netlify.app/posts/covid-19-col/)
  + [A data story of COVID-19 in South Africa.](https://rahul-bharadwaj.netlify.app/posts/covid-19-sa/)
  
#### **Introduction -**

Covid-19 has dropped a bombshell out of the blue and caught the world unaware. It has negatively impacted the lives of millions and proved fatal to thousands of others. With over 25 million cases and 800K deaths around the globe as of Sep 2020, this has been a serious issue of concern for the Governments of all the countries. Amidst the pandemic, this is the story of how Colombia and South Africa were affected by it. This Shiny App helps us understand the Covid-19 situation in Colombia and South Africa.

There are three main tabs in the Shiny App that covers the data story/ message to be conveyed to the reader.

* **Total Count Comparison:** Compares Total tests, cases, recoveries, and deaths till date in Colombia and South Africa.

* **Attribute Count Comparison:** Compares tests, cases, recoveries, and deaths as single attributes for both the countries.

* **Daily Counts:** Has a sub-menu for each country that explores the Daily Counts of tests, cases, recoveries, and deaths due to Covid-19.

* **Citation:** Contains references to R packages and Data Resource used for the analysis.

#### **Data Description -**

* The data used for this App is obtained from: Guidotti, E., Ardia, D., (2020), “COVID-19 Data Hub”, Journal of Open Source Software 5(51):2376, through the R package “COVID19”.

* The complete data table with values for both countries is as follows -