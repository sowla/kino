context("test-convert_movies.R")

##TODO:check lengths?
test_that("convert_movies() returns expected data types", {
  # movies_DE_EN <- convert_movies(imdb_query = get_screenings()[1:5,][[1]] %>% unique())
  movies_DE_EN <- convert_movies(imdb_query = c("Love, Simon", "Vom Ende einer Geschichte"))  # "imdb_query" is missing although alread default?

  expect_false(anyNA(movies_DE_EN))
  expect_equal(class(movies_DE_EN$check_german_title), "character")
  expect_equal(class(movies_DE_EN$english_title), "character")
  expect_equal(class(movies_DE_EN$imdb_id), "character")
  expect_equal(class(movies_DE_EN$imdb_url), "character")
})
