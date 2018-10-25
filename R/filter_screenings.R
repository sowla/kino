#' Filter Available Screenings
#'
#' @param screenings_details output from get_screenings()
#' @param sel_dates selected date(s)
#' @param sel_release_types selected release type(s)
#' @param sel_sites selected site(s)
#'
#' @return a tibble of movie titles (in German) and screening details
#' @export
#'
#' @examples
#' filter_screenings(my_screenings_details)  # returns all screenings in my_screenings_details
#' filter_screenings(sel_dates = Sys.Date())  # returns all screenings found playing today
#' filter_screenings(sel_sites = "Cineplex")  # returns all screenings found playing in Cineplex
#' filter_screenings(sel_release_types = "2D OmU")  # returns all screenings found playing in 2D OmU
#' filter_screenings(sel_sites = "just making stuff up now")  # "no results were found"

filter_screenings <- function(screenings_details = get_screenings(), sel_dates = NULL, sel_release_types = NULL, sel_sites = NULL) {
  ##TODO: double check if input from date selector fits ymd
  ##TODO: check out filter_all()?
  ##TODO: incorporate accessibility_icons

  if (is.null(screenings_details) | any(is.na(screenings_details))) {
    stop("`screenings_details` can't be empty or missing. See examples in `?get_screenings`.",
      call. = FALSE)
  }

  if (all(is.null(sel_dates), is.null(sel_release_types), is.null(sel_sites))) {
    return(screenings_details)
  }

  results <- screenings_details

  if (!is.null(sel_dates)) {
    results <- dplyr::filter(results, dates == sel_dates)  ##TODO: test if date?
  }
  if (!is.null(sel_release_types)) {
    results <- dplyr::filter(results, release_types == sel_release_types)
  }

  if (!is.null(sel_sites)) {
    results <- dplyr::filter(results, sites == sel_sites)
  }

  if (nrow(results) > 0) {
    results
  } else {
    return("no results were found")  ##TODO: see if attempt(fits this)
  }
}
