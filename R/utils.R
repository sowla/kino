#' @importFrom magrittr %>%

# internal
html_text_no_spaces <- function(html) {
  rvest::html_text(html, trim = TRUE) %>%
    stringr::str_remove_all("\\n") %>%
    stringr::str_squish()
}
