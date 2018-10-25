context("test-filter_movies.R")

test_that("filter_movies() correctly filters search results", {
  n_movies <- length(
    get_city(city_url = "https://www.cineplex.de/filmreihe/originals/614/muenster/") %>%
      rvest::html_nodes(".movie-schedule--details")
    )

  expect_equal(nrow(filter_movies()), n_movies)
  expect_length(filter_movies(details = c("title", "duration")), 2)
  expect_equal(length(filter_movies(details = dplyr::expr(dplyr::starts_with("poster")), quoted = TRUE)), 2)
  expect_error(filter_movies(details = "Who am I?"))
  expect_error(filter_movies(details = c("Who am I?", "Who are you?")))
  expect_warning(filter_movies(details = c("title", "duration", ":P", ":)")))
})

#
# test_that("filter_movies() correctly filters search results", {
#   expect_equal(nrow(filter_movies()), n_movies)
#   expect_length(filter_movies(details = c("title", "duration")), 2)
#   expect_equal(length(filter_movies(details = expr(starts_with("poster")), quoted = TRUE)), 2)
#   expect_error(filter_movies(details = "Who am I?"))
#   expect_error(filter_movies(details = c("Who am I?", "Who are you?")))
#   expect_warning(filter_movies(details = c("title", "duration", ":P", ":)")))
# })
