##TODO: write test so people can check css selectors still up to date?

#' Retrieve Details from the Page of a Cineplex City
#'
#' @param city_url
#'
#' @return input for get_screenings() (at the moment only testing Münster originals)
#' @export
#'
#' @examples
#' my_city <- get_city(city_url = "https://www.cineplex.de/filmreihe/originals/614/muenster/")


get_city <- function(city_url) {
  xml2::read_html(city_url) %>% rvest::html_nodes(".movie-schedule")
}
