##TODO: write test so people can check css selectors still up to date?

get_branch <- function(branch_url) {
  xml2::read_html(branch_url) %>% rvest::html_nodes(".movie-schedule")
}

# example:
# my_branch <- get_branch(branch_url = "https://www.cineplex.de/filmreihe/originals/614/muenster/")
# "xml_nodeset"
