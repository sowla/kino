context("test-get_branch.R")

test_that("correct data type returned", {
  expect_equal(class(get_branch(branch_url = "https://www.cineplex.de/filmreihe/originals/614/muenster/")), "xml_nodeset")
})
