##TODO: make sure no error if something missing


get_screenings <- function(branch_html = get_branch(branch_url = "https://www.cineplex.de/filmreihe/originals/614/muenster/")) {

  if (is.null(branch_html) | any(is.na(branch_html))) {
    stop("`branch_html` can't be empty or missing. See examples in `?get_branch`.",
      call. = FALSE)
  }

  n_movies <- length(branch_html %>% rvest::html_nodes(".movie-schedule--details"))

  screenings_details <- dplyr::tibble()

  # get screening attributes (by screening, not my movie)
  for (i in 1:n_movies){

    german_title <- c(
      branch_html[[i]] %>%
        rvest::html_node(".filmInfoLink") %>%  # take first only (possible second node has no text)
        rvest::html_text()
    )

    dates <- c(
      branch_html[[i]] %>%
        rvest::html_nodes(".schedule__date") %>%
        rvest::html_attr("datetime")
    )

    times <- c(
      branch_html[[i]] %>%
        rvest::html_nodes(".movie-schedule--performances--all ") %>%  # other one not unique
        rvest::html_nodes(".schedule__time") %>%
        rvest::html_text()
    )

    release_types <- c(
      branch_html[[i]] %>%  ##TODO: split 2D/3D from OmU/OV?
        rvest::html_nodes(".performance-date-block") %>%
        rvest::html_nodes(".performance-holder") %>%
        rvest::html_attr("data-release-type")  ##TODO: collect lots then unique to see factors
    )

    sites <- c(
      branch_html[[i]] %>%
        rvest::html_nodes(".performance-date-block") %>%
        rvest::html_nodes(".schedule__site") %>%
        html_text_no_spaces() %>%
        stringr::str_extract(".+(?=, )")
    )

    # ##TODO: presence vs. value; might need to add "attempt()" or something like this?
    # accessibility_icons <- c(
    #   branch_html[[i]] %>%
    #     rvest::html_nodes(".performance-date-block") %>%
    #     rvest::html_nodes(".schedule__location") %>%
    #     rvest::html_nodes(".icon-wheelchair_alt") %>%
    #     rvest::html_attr("class")
    # )

    screenings_details <- dplyr::bind_rows(
      screenings_details,
      dplyr::tibble(german_title = german_title, dates = dates, times = times, release_types = release_types, sites = sites)  # , accessibility_icons = accessibility_icons
    )
  }
  return(screenings_details)
}

# # example:
# my_screenings_details <- get_screenings(branch_html = get_branch(branch_url = "https://www.cineplex.de/filmreihe/originals/614/muenster/"))
