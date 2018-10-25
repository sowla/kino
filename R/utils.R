#' @importFrom magrittr %>%

# internal
html_text_no_spaces <- function(html) {
  rvest::html_text(html, trim = TRUE) %>%
    stringr::str_remove_all("\\n") %>%
    stringr::str_squish()
}



##TODO!! use polite and imdb packages; https://twitter.com/SuzanBaert/status/1039606109890400256
