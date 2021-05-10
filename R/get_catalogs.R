#' Get a Scryfall Catalog
#'
#' @description A Catalog object contains an array of Magic datapoints
#' (words, card values, etc). Catalog objects are provided by the API
#' as aids for building other Magic software and understanding possible
#' values for a field on Card objects.
#'
#' @param catalog Name of the catalog to fetch
#' @param pretty Should the response be returned in the pretty JSON format
#'
#' @return A list
#'
#' @export
get_catalog <- function(catalog = "card-names"){

  catalog <- tolower(catalog)

  #### CHECK ARGUMENTS ####
  stop_if_not_in(
    catalog,
    c(
      'card-names', 'artist-names',
      'word-bank','creature-types',
      'planeswalker-types', 'land-types',
      'artifact-types', 'enchantment-types',
      'spell-types', 'powers',
      'toughnesses', 'loyalties',
      'watermarks', 'keyword-abilities',
      'keyword-actions','ability-words'
    ),
    "'catalog' must be one of c(
      'card-names', 'artist-names',
      'word-bank','creature-types',
      'planeswalker-types', 'land-types',
      'artifact-types', 'enchantment-types',
      'spell-types', 'powers',
      'toughnesses', 'loyalties',
      'watermarks', 'keyword-abilities',
      'keyword-actions','ability-words'
    )"
    )
  attempt::stop_if_not(
    pretty,
    is.logical,
    "paramiter pretty must be either TRUE or FALSE"
  )

  #### CONVERT ####
  pretty_search <- ifelse(pretty, "true", "false")

  #### FETCH FROM API ####

  res <-httr::GET(
    paste(cat_url, catalog, sep="/"),
  )

  #### Format the response ####
  data <- jsonlite::fromJSON(rawToChar(res$content))
    return(data$data)

  ##### END #####


}
