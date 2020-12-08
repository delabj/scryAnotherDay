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
#'  This parameter specifies if Scryfall should remove duplicate results in your query. The options are:
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
#' @export
get_cards_by_search <- function(
  q                  = "*",
  unique             = "cards",
  order              = "name",
  dir                = "auto",
  include_extras     = FALSE,
  include_variations = FALSE,
  page               = 1,
  format             = "json",
  pretty             = FALSE
){

  # checks
  attempt::stop_if(q, is.null, "You must specify a query")
  attempt::stop_if_not(pretty, is.logical, "paramiter pretty must be either TRUE or FALSE")
  attempt::stop_if_not(include_extras, is.logical, "paramiter include_extras must be either TRUE or FALSE")
  attempt::stop_if_not(include_variations, is.logical, "paramiter include_variations must be either TRUE or FALSE")
  attempt::stop_if_not(page, is.numeric, "paramiter page must be an whole number")
  stop_if_not_in(unique, c('cards', 'art', 'prints'), "`unique` must be one of c('cards', 'art', 'prints')" )
  stop_if_not_in(order,
                 c('name', 'set', 'released','rarity', 'usd', 'tix', 'eur', 'cmc', 'power', 'toughness', 'edhrec', 'artist'),
                 "`order` must be one of c('name', 'set', 'released','rarity', 'usd', 'tix', 'eur', 'cmc', 'power', 'toughness', 'edhrec', 'artist')" )
  stop_if_not_in(dir, c('auto', 'asc', 'desc'), "`dir must be on of c('auto', 'asc', 'desc')")
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
      pretty             = pretty_search
    )
    )

  check_status(res)


  if(format == "json"){
    return(jsonlite::fromJSON(rawToChar(res$content)))
  }
  else if (format == "csv"){
    return(readr::read_csv(rawToChar(res$content)))
  }
  else{
    usethis::ui_stop("There was an issue with the format. it should be either 'json' or 'csv'")
  }
}

#' Search for cards on Scryfall
#'
#' @description Returns a Card based on a name search string.
#'
#' @param q the card name to search for
#' @param search_type is the search an "exact" or "fuzzy" search
#' @param set set code to limit search to one set
#' @param format The format to return the data in. "json", "CSV", "image"
#' @param face The face that should be returned if format selected is "image"
#' @param version The size of the image to return when using "image"
#' @param pretty Should the JSON be prettified
#'
#' @export

get_cards_by_name <- function(
  q           = "Jace, the Mind Sculptor",
  search_type = "exact",
  set         = "",
  format      = "json",
  face        = "front",
  version     = "large",
  pretty      = FALSE
){
  # Checks
  attempt::stop_if(q, is.null, "You must specify a query")
  attempt::stop_if_not(search_type, is.character, "`search_type` must be of type character")
  stop_if_not_in(search_type, c('exact', 'fuzzy'), "`search_type` must be one of c('exact', 'fuzzy')")
  attempt::stop_if_not(set, is.character, "`set`  must be of type character")
  stop_if_not_in(format, c('json', 'csv', 'image'), "`format` must be one of c('json', 'csv', 'image')")
  attempt::stop_if_not(face, is.character, "`face` must be of type character")
  stop_if_not_in(face, c('front', 'back'), "`face` must be one of c('front', 'back')")
  attempt::stop_if_not(version, is.character, "`version` must be of type character")
  stop_if_not_in(version, c('small', 'normal', 'large', 'png', 'art_crop', 'border_crop'),
                 "`version` must be one of c('small', 'normal', 'large', 'png', 'art_crop', 'border_crop')")
  attempt::stop_if_not(pretty, is.logical, "`pretty` must be either TRUE or FALSE")
  check_internet()

  # Convert to proper formatting
  pretty_search <- ifelse(pretty, "true", "false")
  q <- gsub(pattern = "[^[:alnum:][:space:]]", "", q)
  q <- gsub(pattern = " ", "+", q)


  if(search_type == "exact"){
    res <- httr::GET(paste0(card_url, "/searched"),
                     query = list(
                       exact   = q,
                       set     = set,
                       format  = format,
                       face    = face,
                       version = version,
                       pretty  = pretty_search
                     )
    )
  }
  else if(search_type == "fuzzy"){
    res <- httr::GET(paste0(card_url, "/named"),
                     query = list(
                       fuzzy    = I(q),
                       set     = set,
                       format  = format,
                       face    = face,
                       version = version,
                       pretty  = pretty_search
                     )
    )
  }
  else{
    usethis::ui_stop("There was an issue with the search type it should be either 'exact' or 'fuzzy'")
  }


  check_status(res)


  if(format == "json"){
    return(jsonlite::fromJSON(rawToChar(res$content)))
  }
  else if (format == "csv"){
    return(readr::read_csv(rawToChar(res$content)))
  }
  else if (format == "image"){
    return((magick::image_read(res$content)))
  }
  else{
    usethis::ui_stop("There was an issue with the format. it should be either 'json', 'csv', or 'image")
  }


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


  check_status(res)


return(jsonlite::fromJSON(rawToChar(res$content)))


}

#' Get  single random Card object
#'
#' @description Returns a single random Card object.
#'
#' @param q The query string
#' @param format The format to return the data in. "json", "CSV", "image"
#' @param face The face that should be returned if format selected is "image"
#' @param version The size of the image to return when using "image"
#' @param pretty Should the JSON be prettified
#'
#'
#' @export
get_cards_random <- function(
  q       = "Jace",
  format  = "json",
  face    = "front",
  version = "large",
  pretty  = FALSE
){
  # checks
  attempt::stop_if(q, is.null, "You must specify a query")
  stop_if_not_in(format, c('json', 'csv', 'image'), "`format` must be one of c('json', 'csv', 'image')")
  attempt::stop_if_not(face, is.character, "`face` must be of type character")
  stop_if_not_in(face, c('front', 'back'), "`version` must be one of c('front', 'back')")
  attempt::stop_if_not(pretty, is.logical, "paramiter pretty must be either TRUE or FALSE")
  attempt::stop_if_not(face, is.character, "`face` must be of type character")
  stop_if_not_in(face, c('front', 'back'), "`face` must be one of c('front', 'back')")
  attempt::stop_if_not(version, is.character, "`version` must be of type character")
  stop_if_not_in(version, c('small', 'normal', 'large', 'png', 'art_crop', 'border_crop'),
                 "`version` must be one of c('small', 'normal', 'large', 'png', 'art_crop', 'border_crop')")
  check_internet()


  # convert
  pretty_search <- ifelse(pretty, "true", "false")


  # Connect to the API
  res <- httr::GET(
    paste0(card_url, "/random"),
    query = list(
      q       = q,
      format  = format,
      face    = face,
      version = version,
      pretty  = pretty_search
      )
    )


  check_status(res)


  if(format == "json"){
    return(jsonlite::fromJSON(rawToChar(res$content)))
  }
  else if (format == "csv"){
    return(readr::read_csv(rawToChar(res$content)))
  }
  else if (format == "image"){
    return((magick::image_read(res$content)))
  }
  else{
    usethis::ui_stop("There was an issue with the format. it should be either 'json', 'csv', or 'image")
  }

}


#' Get card by set code and colector number
#'
#' @param code the 3 to 5 letter set code
#' @param number the collector number of the card (must be whole number)
#' @param lang the 2 to 3 letter language code as described at https://scryfall.com/docs/api/languages
#' @param format The format to return the data in. "json", "CSV", "image"
#' @param face The face that should be returned if format selected is "image"
#' @param version The size of the image to return when using "image"
#' @param pretty Should the JSON be prettified
#'
#' @export
get_card_by_code <- function(
  code    = "wwk",
  number  = 31,
  lang    = "en",
  format  = "json",
  face    = "front",
  version = "large",
  pretty  = FALSE
){

  # checks
  assertthat::assert_that( nchar(code) <=5 , nchar(code) >= 3,
                           msg = "code must be a set code between 3 and 5 characters in length")
  attempt::stop_if_not(number, is.numeric, "Number must be a number")
  assertthat::assert_that(nchar(lang) <=3 , nchar(lang) >= 2,
                            msg = "lang must be a language code between 2 and 3 characters in length")
  stop_if_not_in(format, c('json', 'csv', 'image'), "`format` must be one of c('json', 'csv', 'image')")
  attempt::stop_if_not(face, is.character, "`face` must be of type character")
  stop_if_not_in(face, c('front', 'back'), "`version` must be one of c('front', 'back')")
  attempt::stop_if_not(version, is.character, "`version` must be of type character")
  stop_if_not_in(version, c('small', 'normal', 'large', 'png', 'art_crop', 'border_crop'),
                 "`version` must be one of c('small', 'normal', 'large', 'png', 'art_crop', 'border_crop')")
  attempt::stop_if_not(pretty, is.logical, "`pretty` must be either TRUE or FALSE")


  pretty_search <- ifelse(pretty, "true", "false")
  check_internet()



  res <- httr::GET(
    paste(card_url, code, number, lang, sep = "/"),
    query = list(
      format  = format,
      face    = face,
      version = version,
      pretty  = pretty_search
    )
  )


  check_status(res)


  if(format == "json"){
    return(jsonlite::fromJSON(rawToChar(res$content)))
  }
  else if (format == "csv"){
    return(readr::read_csv(rawToChar(res$content)))
  }
  else if (format == "image"){
    return((magick::image_read(res$content)))
  }
  else{
    usethis::ui_stop("There was an issue with the format. it should be either 'json', 'csv', or 'image")
  }


}
## To Add
# /cards/:code/:number(/:lang)
# /cards/multiverse/:id
# /cards/mtgo/:id
# /cards/arena/:id
# /cards/tcgplayer/:id
# /cards/cardmarket/:id
# /cards/:id
