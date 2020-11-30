#' Search for cards on Scryfall
#'
#' @md
#' @description Get a list of cards found using a fulltext search string.
#' This string uses the same syntax as [Scryfall's site](https://scryfall.com/docs/syntax)
#' This is pagenated, returning a maximum of 175 cards at a time
#'
#' @param q the string query using Scryfall Syntax
#' @param unique the rollup mode for removing duplicates. See details
#' @param order the method to sort returned cards. See details
#' @param dir direction to sort cards
#' @param include_extras Should the search include extra cards (tokens, planes, vanguards, etc)
#' @param include_variations Should rare card varients be included Defaults to false
#' @param page the page to return defaults to 1
#' @param format The format to return the data in. json or CSV
#' @param pretty Should the JSON be prettified
#'
#'
#' @details
#'
#' `unique`
#'  This parameter specifies if Scryfall should remove “duplicate” results in your query. The options are:
#'  - "cards" (default): Removes duplicate gameplay objects (cards that share a name and have the same functionality).
#'  - "art" : Returns only one copy of each unique artwork for matching cards.
#'  - "prints": Returns all prints for all cards matched (disables rollup).
#'
#'
#'  `order`
#'  This parameter determines how Scryfall should sort the returned cards.
#'  - "name" (default): by card name
#'  - "set": by their set and collector number
#'  - "released": by release date
#'  - "rarity": by card Rarity
#'  - "usd": by card lowest known US dollar price
#'  - "tix": by lowest known TIX price
#'  - "eur": by lowest known Euro price
#'  - "cmc": by converted mana cost
#'  - "power": by power
#'  - "toughness": by toughness
#'  - "edhrec": by edhrec ranking
#'  - "artist" by front side artist name
#'
#' @return A list
#'
get_cards_by_search <- function(
  q="*",
  unique = "cards",
  order = "name",
  dir = "auto",
  include_extras = FALSE,
  include_variations = FALSE,
  page = 1,
  format = "json",
  pretty = FALSE
){

  # checks
  attempt::stop_if(q, is.null, "You must specify a query")
  attempt::stop_if_not(pretty, is.logical, "paramiter pretty must be either TRUE or FALSE")
  attempt::stop_if_not(include_extras, is.logical, "paramiter include_extras must be either TRUE or FALSE")
  attempt::stop_if_not(include_variations, is.logical, "paramiter include_variations must be either TRUE or FALSE")
  attempt::stop_if_not(page, is.numeric, "paramiter page must be an whole number")

  # attempt unique in list
  # attempt order in list
  # attempt dir in list


  # convert to api formatting
  pretty_search <- ifelse(pretty, "true", "false")
  extras_search <- ifelse(include_extras,  "true", "false")
  variations_search <- ifelse(include_variations,  "true", "false")
  page <- round(page)



  # Connect to the API
  res <- httr::GET(
    paste0(card_url, "/search"),
    query = list(
      q                  = q,
      unique             = unique,
      order              = order,
      dir                = dir,
      include_extras     = extras_search,
      include_variations = variations_search,
      page               = page,
      format             = format,
      pretty             = pretty_search,

    )
    )


  if(format == "json"){
    return(jsonlite::fromJSON(rawToChar(res$content)))
  }
  else if (

  ){
    return(readr::read_csv(rawToChar(res$content)))

  }
  else{
    usethis::ui_stop("There was an issue with the format. it should be either 'json' or 'csv'")
  }





}

#' Search for cards on Scryfall
get_cards_by_name <- function(

){

}

#' Get Potential Card names
#'
#' @description Returns up to 20 full English card names that could
#' autocomplete the supplied query string.
#'
#' @param q The query string
#' @param pretty Should the JSON be prettified
#' @param include_extras Should the search include extra cards (tokens, planes, vanguards, etc)
#'
#' @return A list
#'
#' @export
get_cards_autocomplete <- function(
  q = "Jace, ",
  pretty = FALSE,
  include_extras = FALSE
){
  # Checks
  attempt::stop_if(q, is.null, "You must specify a query")
  attempt::stop_if_not(pretty, is.logical, "paramiter pretty must be either TRUE or FALSE")
  attempt::stop_if_not(include_extras, is.logical, "paramiter include_extras must be either TRUE or FALSE")
    check_internet()



  pretty_search <- ifelse(pretty, "true", "false")
  extras_search <- ifelse(include_extras,  "true", "false")

# Connect to the API
  res <- httr::GET(
    paste0(card_url, "/autocomplete"),
    query = list(
      q=q,
      pretty=pretty_search,
      include_extras = extras_search))

return(jsonlite::fromJSON(rawToChar(res$content)))


}


