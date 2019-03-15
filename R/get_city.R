#' Retrieve Details from the Site of a Cineplex City
#'
#' @param city_url URL for cineplex in the city you're interested in (at the moment I'm only testing Münster originals, but in future versions it will be the city name as a string, and the function will determine the URL)
#'
#' @return an xml nodeset that can be used as input for `get_screenings()`
#' @export
#'
#' @examples
#' my_city <- get_city(city_url = "https://www.cineplex.de/filmreihe/originals/614/muenster/")


get_city <- function(city_url) {

  # ask for permission to scrape; see https://github.com/dmi3kno/polite
  session <- polite::bow("https://www.cineplex.de/filmreihe/originals/614/muenster/")

  polite::scrape(session, accept = "html") %>%
    rvest::html_nodes(".movie-schedule")
}
