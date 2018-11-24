#' Retreive Screenings Available at a Cineplex City
#'
#' @param city_xml an xml nodeset; output of `get_city()`
#'
#' @return data frame with screening details for a given city that can be used as input for `filter_screenings()`.
#' @export
#'
#' @examples
#' my_screenings_details <- get_screenings(city_xml = my_city)


get_screenings <- function(city_xml = get_city(city_url = "https://www.cineplex.de/filmreihe/originals/614/muenster/")) {

  if (is.null(city_xml) | any(is.na(city_xml))) {
    stop("`city_xml` can't be empty or missing. See examples in `?get_city`.",
      call. = FALSE)
  }

  n_movies <- length(city_xml %>% rvest::html_nodes(".movie-schedule--details"))

  screenings_details <- dplyr::tibble()

  # get screening attributes (by screening, not my movie)
  for (i in 1:n_movies){

    german_title <- c(
      city_xml[[i]] %>%
        rvest::html_node(".filmInfoLink") %>%  # take first only (possible second node has no text)
        rvest::html_text()
    )

    dates <- c(
      city_xml[[i]] %>%
        rvest::html_nodes(".schedule__date") %>%
        rvest::html_attr("datetime")
    )

    times <- c(
      city_xml[[i]] %>%
        rvest::html_nodes(".movie-schedule--performances--all ") %>%  # other one not unique
        rvest::html_nodes(".schedule__time") %>%
        rvest::html_text()
    )

    release_types <- c(
      city_xml[[i]] %>%  ##TODO: split 2D/3D from OmU/OV?
        rvest::html_nodes(".performance-date-block") %>%
        rvest::html_nodes(".performance-holder") %>%
        rvest::html_attr("data-release-type")  ##TODO: collect lots then unique to see factors
    )

    sites <- c(
      city_xml[[i]] %>%
        rvest::html_nodes(".performance-date-block") %>%
        rvest::html_nodes(".schedule__site") %>%
        html_text_no_spaces() %>%
        stringr::str_extract(".+(?=, )")
    )

    # ##TODO: presence vs. value; might need to add "attempt()" or something like this?
    # accessibility_icons <- c(
    #   city_xml[[i]] %>%
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

