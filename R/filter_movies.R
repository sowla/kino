#' Filter Movie Results
#'
#' @param mov_info dataframe of movie information
#' @param details which details to retreive
#' @param quoted whether the details parameter should be quoted
#'
#' @return filtered movies
#' @export
#'
#' @examples
#' filter_movies(mov_info = get_mov_info_de())  # returns all details
#' filter_movies(mov_info = get_mov_info_en(), details = c("title", "runtime", "plot"))  # returns selected columns
#' filter_movies(details = expr(starts_with("poster")), quoted = TRUE)  ##TODO: check expr/quo/enquo
#' filter_movies(details = c("Who am I?", "Who are you?"))  # error
#' filter_movies(mov_info = get_mov_info_en(), details = c("title", "runtime", ":P", ":D"))  # warning; returns matchess

filter_movies <- function(mov_info = get_mov_info_de(), details = NULL, quoted = FALSE) {
  if (is.null(details)) {
    return(mov_info)
  } else if (quoted == TRUE) {
    dplyr::select(mov_info, !!details)
  } else if (any(is.element(details, names(mov_info)))) {
    irrel_details <- setdiff(details, names(mov_info))
    if (length(irrel_details) > 0) {
      warning(paste0("Information on \"", irrel_details, "\" is not available. "))
    }
    rel_details <- intersect(details, names(mov_info))
    return(dplyr::select(mov_info, rel_details))

  } else if (all(!is.element(details, names(mov_info)))) {
    stop(paste0("Information on \"", details, "\" is not available. "))
  }
}


##TODO: if column exists in German/English indicate not available in EN/DE?
