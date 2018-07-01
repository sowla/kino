context("test-get_mov_info_de.R")

##TODO: check lengths/number of digits (eg. duration 2-3 digits, description v long)
test_that("mov_info_DE contains expected data types", {
  mov_info_DE <- get_mov_info_de()
  # mov_info_DE <- get_mov_info_DE(cineplex_movies = get_branch(branch_url = "https://www.cineplex.de/filmreihe/originals/614/muenster/"))

  expect_false(anyNA(mov_info_DE))
  expect_equal(class(mov_info_DE$title), "character")
  expect_equal(class(mov_info_DE$duration), "numeric")
  expect_equal(class(mov_info_DE$genre), "character")
  expect_equal(class(mov_info_DE$poster_url), "character")
  expect_equal(class(mov_info_DE$poster_alt), "character")
  expect_equal(class(mov_info_DE$plot_summ), "character")
  expect_equal(class(mov_info_DE$description), "character")
})
