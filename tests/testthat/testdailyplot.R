library(testthat)

test_that("dailyplot()", {
  expect_equal(
    dailyplot(DailyCOL),
    (DailyCOL %>% ggplot() +
      geom_line(aes(x = date, y = dailytest, color = "dailytested")) +
      geom_line(aes(x = date, y = dailyconfirm, color = "dailyconfirmed")) +
      geom_line(aes(x = date, y = dailyrecover, color = "dailyrecovered")) +
      geom_line(aes(x = date, y = dailydeaths, color = "dailydeaths")) +
      xlab("Date") + ylab("Attribute Counts") +
      ggtitle("Daily Timeline Curves for Covid") +
      theme_light()
    )
  )
})