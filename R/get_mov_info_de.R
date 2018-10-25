##TODO: make sure no error if something missing

#' Retreive Movie Details from Cineplex
#'
#' @param sel_imdb_ids
#'
#' @return details eg. runtime, poster URL..
#' @export
#'
#' @examples
#' my_mov_info_DE <- get_mov_info_de()
#' my_mov_info_DE <- get_mov_info_de(city_html = get_city(city_url = "https://www.cineplex.de/filmreihe/originals/614/muenster/"))

get_mov_info_de <- function(city_html = get_city(city_url = "https://www.cineplex.de/filmreihe/originals/614/muenster/")) {
  n_movies <- length(city_html %>% rvest::html_nodes(".movie-schedule--details"))

  mov_info_DE <- dplyr::tibble()

  for (i in 1:n_movies){

    title <- c(
      city_html[[i]] %>%
        rvest::html_node(".filmInfoLink") %>%  ##TODO: always OK to take first one only?
        rvest::html_text()
    )

    duration <- c(
      city_html[[i]] %>%
        rvest::html_nodes(".movie-attributes") %>%
        rvest::html_nodes(".length") %>%
        rvest::html_text() %>%
        stringr::str_extract("\\d+") %>%
        as.numeric()
    )

    # ##TODO: presence vs. value; might need to add "attempt()" or something like this?
    # fsk <- c(city_html[[i]] %>%
    #   rvest::html_nodes(".movie-attributes") %>%
    #   rvest::html_nodes(".fsk") %>%
    #   html_text(trim = TRUE)
    #   )
    # # https://en.wikipedia.org/wiki/Freiwillige_Selbstkontrolle_der_Filmwirtschaft

    genre <- c(
      city_html[[i]] %>%
        rvest::html_nodes(".movie-attributes") %>%
        rvest::html_nodes(".genre") %>%
        rvest::html_text(trim = TRUE)
    )

    poster_url <- c(
      city_html[[i]] %>%
        rvest::html_nodes(".movie-poster--preview img") %>%
        rvest::html_attr("src")
    )

    poster_alt <- c(
      city_html[[i]] %>%
        rvest::html_nodes(".movie-poster--preview img") %>%
        rvest::html_attr("alt")
    )

    plot_summ <- c(
      city_html[[i]] %>%
        rvest::html_nodes(".movie-schedule--description") %>%
        rvest::html_children() %>%
        .[1] %>%
        html_text_no_spaces()
    )

    description <- c(
      city_html[[i]] %>%
        rvest::html_nodes(".movie-schedule--description") %>%
        rvest::html_children() %>%
        .[2] %>%
        html_text_no_spaces()
    )

    mov_info_DE <- dplyr::bind_rows(
      mov_info_DE,
      dplyr::tibble(
        title = title,  # class character
        duration = duration,  # class numeric
        genre = genre,  # class character
        poster_url = poster_url,  # class character (url)
        poster_alt = poster_alt,  # class character
        plot_summ = plot_summ,  # class character
        description = description  # class character
      )
    )
  }
  return(mov_info_DE)
}


##TODO: combine get_mov_info and EN
