context("test-filter_screenings.R")

test_that("filter_screenings() correctly filters search results", {
  screenings_details <- get_screenings()

  expect_equal(nrow(filter_screenings()), nrow(screenings_details))  # in case let user select cols?
  expect_lte(
    nrow(filter_screenings(sel_dates = screenings_details$dates[1])),
    nrow(screenings_details)
  )
  expect_lte(
    nrow(filter_screenings(sel_release_types = screenings_details$release_types[1])),
    nrow(screenings_details)
  )
  expect_lte(
    nrow(filter_screenings(sel_sites = screenings_details$sites[1])),
    nrow(screenings_details)
  )
  expect_equal(filter_screenings(sel_release_types = "testing"), "no results were found")
})
