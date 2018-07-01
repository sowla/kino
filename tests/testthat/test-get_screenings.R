context("test-get_screenings.R")

test_that("get_screenings() returns expected data types", {
  expect_error(get_screenings(branch_html = NULL))  ##TODO: error looks same but supposedly different

  screenings_details <- get_screenings()
  # screenings_details <- get_screenings(branch_html = get_branch(branch_url = "https://www.cineplex.de/filmreihe/originals/614/muenster/"))  # if not default

  expect_false(anyNA(screenings_details))
  expect_equal(class(screenings_details$german_title), "character")
  expect_equal(class(screenings_details$dates), "character")  ##TODO: change to date?
  expect_equal(class(screenings_details$times), "character")  ##TODO: change to date?
  expect_equal(class(screenings_details$release_types), "character")
  expect_equal(class(screenings_details$sites), "character")
  # expect_equal(screenings_details$accessibility_icons[1], "icon-wheelchair_alt")
  expect_gt(nrow(screenings_details), 0)
})
