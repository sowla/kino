context("test-get_mov_info_en.R")

test_that("movie_details_EN contains expected data types", {
  sel_imdb_ids <- c("tt5164432", "tt4881806")
  movie_details_EN <- get_mov_info_en(sel_imdb_ids = c("tt5164432", "tt4881806"))  ##TODO: why have to type in though set as defaut

  # if (german_title == check_german_title)
  # mapply(adist, german_title, check_german_title)
  expect_equal(nrow(movie_details_EN), length(sel_imdb_ids))
  expect_equal(class(movie_details_EN$response), "character")
  # expect_equal(all(movie_details_EN$response), TRUE)
  expect_equal(class(movie_details_EN$imdb_id), "character")
  # expect_equal(movie_details_EN$imdb_id, movies_DE_EN$imdb_id)
  expect_equal(class(movie_details_EN$title), "character")
  expect_equal(class(movie_details_EN$rated), "character")
  expect_equal(class(movie_details_EN$runtime), "numeric")
  expect_equal(class(movie_details_EN$genre), "character")
  expect_equal(class(movie_details_EN$plot), "character")
  expect_equal(class(movie_details_EN$poster_url), "character")
  expect_equal(class(movie_details_EN$website), "character")
  expect_equal(class(movie_details_EN$imdb_rating), "numeric")
  expect_equal(class(movie_details_EN$imdb_vote), "numeric")
  expect_equal(class(movie_details_EN$metascore), "numeric")
})
