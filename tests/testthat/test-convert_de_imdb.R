context("test-convert_de_imdb.R")

##TODO: replace movies_DE_EN default
test_that("convert_DE_imdb() correctly filters search results", {
  expect_equal(convert_DE_imdb(query = "Love, Simon"), "tt5164432")
  expect_error(convert_DE_imdb(query = "love, simon"))
  expect_equal(
    convert_DE_imdb(query = c("Jurassic World: Das gefallene Königreich", "Vom Ende einer Geschichte")),
    c("tt4827986", "tt4881806")
  )
  expect_equal(
    convert_DE_imdb(query = c("Jurassic World: Das gefallene Königreich", "Vom Ende einer Geschichte"), return = "url"),
    c("https://www.imdb.com/title/tt4827986", "https://www.imdb.com/title/tt4881806")
  )
  expect_error(convert_DE_imdb())
  expect_error(convert_DE_imdb(query = "I am a movie"))
  expect_error(convert_DE_imdb(query = c("I am a movie", "Me too!"), return = "url"))
  expect_warning(convert_DE_imdb(query = c("I am a movie", "Love, Simon")))
  expect_equal(convert_DE_imdb(query = c("I am a movie", "Love, Simon")), "tt5164432")
  expect_warning(convert_DE_imdb(query = c("I am a movie", "Love, Simon"), return = "url"))
  expect_equal(
    convert_DE_imdb(query = c("I am a movie", "Love, Simon"), return = "url"),
    "https://www.imdb.com/title/tt5164432"
  )
})
