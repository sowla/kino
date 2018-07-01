##TODO: make sure no error if something missing


get_mov_info_en <- function(sel_imdb_ids = c("tt5164432", "tt4881806")) {

  # sel_imdb_ids <- movies_DE_EN$imdb_id

  movie_details_EN <- dplyr::tibble()

  for (i in 1:length(sel_imdb_ids)){

    # use API if available (1,000 daily limit)
    omdb_list <- jsonlite::fromJSON(paste0("http://www.omdbapi.com/?i=", sel_imdb_ids[i], "&apikey=a976f6a3"))

    response <- omdb_list$Response  ##TODO: warning if false
    imdb_id <- omdb_list$imdbID

    title <- omdb_list$Title
    # year <- omdb_list$Year
    rated <- omdb_list$Rated
    runtime <- omdb_list$Runtime %>%
      stringr::str_remove(" min") %>%
      as.numeric()
    genre <- omdb_list$Genre %>%
      stringr::str_replace_all(", ", " / ")
    plot <- omdb_list$Plot
    poster_url <- omdb_list$Poster %>%
      stringr::str_replace("(?<=_V1).*(?=\\.jpg)", "")
    website <- omdb_list$Website

    imdb_rating <- omdb_list$imdbRating
    if (imdb_rating != "N/A") {
      imdb_rating <- as.numeric(imdb_rating)
    } else {
      imdb_rating <- NaN
    }

    imdb_vote <- omdb_list$imdbVotes %>%
      stringr::str_remove_all(",")
    if (imdb_vote != "N/A") {
      imdb_vote <- as.numeric(imdb_vote)
    } else {
      imdb_vote <- NaN
    }

    metascore <- omdb_list$Metascore
    if (metascore != "N/A") {
      metascore <- as.numeric(metascore)  # out of 100
    } else {
      metascore <- NaN
    }

    rotten_tomatoes <- omdb_list$Ratings[2, 2] %>%
      stringr::str_remove("%")
    if (rotten_tomatoes != "N/A") {
      rotten_tomatoes <- as.numeric(rotten_tomatoes)
    } else {
      rotten_tomatoes <- NaN
    }

    movie_details_EN <- dplyr::bind_rows(
      movie_details_EN,
      dplyr::tibble(
        response = response,
        imdb_id = imdb_id,
        title = title,
        rated = rated,
        runtime = runtime,
        genre = genre,
        plot = plot,
        poster_url = poster_url,
        website = website,
        imdb_rating = imdb_rating,
        imdb_vote = imdb_vote,
        metascore = metascore,
        rotten_tomatoes = rotten_tomatoes
      )
    )
  }
  movie_details_EN[movie_details_EN == "N/A"] <- NA
  return(movie_details_EN)
}

# # example:
# get_mov_info_en()
