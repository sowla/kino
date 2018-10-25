#' Returns Relevant Details from German Movie Title(s)
#'
#' @param imdb_query
#'
#' @return a tibble with English title(s) and IMDB details
#' @export
#'
#' @examples
#' convert_movies(c("Love, Simon", "Vom Ende einer Geschichte"))

convert_movies <- function(imdb_query = c("Love, Simon", "Vom Ende einer Geschichte")) {  ##TODO: change default?

  ##TODO: if null/na
  # imdb_query <- screenings_details[1:5,][[1]] %>% unique()

  movies_DE_EN <- dplyr::tibble()

  for (i in 1:length(imdb_query)){

    imdb_id <- imdb_query[i] %>%
      URLencode(reserved = TRUE) %>%
      stringr::str_replace_all("%20", "+") %>%
      paste0("https://www.imdb.com/find?ref_=nv_sr_fn&q=", ., "&s=tt") %>%
      xml2::read_html() %>%
      rvest::html_node(".result_text") %>%  # atm, taking first hit only
      rvest::html_node("a") %>%
      rvest::html_attr("href") %>%
      stringr::str_extract("(?<=/title/)tt[0-9]+(?=/)")

    imdb_url <- paste0("https://www.imdb.com/title/", imdb_id, "/")

    ##TODO: friendly message if no match; options if multiple matches

    imdb_html <- xml2::read_html(imdb_url)

    english_title <- imdb_html %>%  ##TODO: why German? how to make English??
      rvest::html_node(".title_wrapper") %>%
      rvest::html_node("h1") %>%
      html_text_no_spaces() %>%
      stringr::str_remove("\\s\\(\\d+\\)$")  # remove year so consistent with German title (or add to German title??)

    check_german_title <- paste0(imdb_url, "releaseinfo") %>%
      xml2::read_html() %>%
      rvest::html_nodes("table") %>%
      .[[2]] %>%
      rvest::html_table() %>%
      dplyr::filter(stringr::str_detect(X1, "Germany")) %>%
      dplyr::select(X2) %>%
      as.character()

    # if (imdb_query[i] == check_german_title) {
    # "Die brillante Mademoiselle Neila" != "Die brillante Mademoiselle Neïla"
    ##TODO: mention showing closest match to...
    movies_DE_EN <- dplyr::bind_rows(
      movies_DE_EN,
      dplyr::tibble(
        check_german_title = check_german_title,  # class character
        english_title = english_title,  # class character
        imdb_id = imdb_id,  # class character
        imdb_url = imdb_url  # class character (url)
      )
    )
    # }

  }
  return(movies_DE_EN)
}

