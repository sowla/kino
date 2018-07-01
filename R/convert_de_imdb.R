##TODO: think about case-sensitivity
##TODO: "ï" or other special characters won't match

# imdb_query <- screenings_details[1:5,][[1]] %>% unique()

##TODO: edit defaults so doesn't take so long!
convert_DE_imdb <- function(movies_DE_EN = convert_movies(imdb_query = get_screenings()[1:5,][[1]] %>% unique()), query = NULL, return = "id") {  # can be "id" or "url"
  if (is.null(query)) {
    stop("imdb_query can't be NULL")
  }

  if (any(is.element(query, movies_DE_EN$check_german_title))) {
    irrel_queries <- setdiff(query, movies_DE_EN$check_german_title)
    if (length(irrel_queries) > 0) {
      warning(paste0("No IMDB entry found for", irrel_queries, ". "))
    }
    rel_queries <- intersect(query, movies_DE_EN$check_german_title)
    id <- dplyr::filter(movies_DE_EN, rel_queries == check_german_title) %>%
      dplyr::select(imdb_id) %>%
      .[[1]]
  } else {
    stop(paste0("No IMDB entry found for \"", query, "\". "))
  }

  if (return == "id") {
    return(id)
  } else if (return == "url") {
    url <- paste0("https://www.imdb.com/title/", id)
    return(url)
  }
}

# # examples:
# convert_DE_imdb(query = "Love, Simon")  # "tt5164432"
# convert_DE_imdb(query = "love, simon")  # error # case-senstive
# convert_DE_imdb(query = "Love, Simon", return = "url")  # "https://www.imdb.com/title/tt5164432"
#
# # should also work for non-English titles or multiple queries
# convert_DE_imdb(query = c("Jurassic World: Das gefallene Königreich", "Vom Ende einer Geschichte"))  # "tt4827986" "tt4881806"
# # convert_DE_imdb(query = c("Jurassic World: Das gefallene Königreich", "Vom Ende einer Geschichte"), return = "url")
#
# convert_DE_imdb()  # error
# convert_DE_imdb(query = c("I am a movie", "Love, Simon"))  # warning; "tt5164432"
