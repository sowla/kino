context("test-get_city.R")

test_that("correct data type returned", {
  expect_equal(class(get_city(city_url = "https://www.cineplex.de/filmreihe/originals/614/muenster/")), "xml_nodeset")
})
