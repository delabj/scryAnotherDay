



## To Add
# /sets/:code
# /sets/tcgplayer/:id
# /sets/:id

#' Get a list of all sets
#'
#' @description Fetch a list of all sets, and their respective codes/IDs, release date, and set attributes.
#'
#' @return a data.frame containing all listed sets
#' @export
get_sets <- function(){

  check_internet()

  res <- httr::GET(
    url = set_url
  )

  check_status(res)

  listed <- jsonlite::fromJSON(httr::content(res, "text", encoding = "UTF-8"))

  attempt::stop_if_not(("data" %in% names(listed)), msg="Error in response from API")

  return(listed$data)
}
