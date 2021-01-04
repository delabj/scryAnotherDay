



## To Add
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



#' Get set by set code
#'
#' @description Retrieve set details using the set's 3-5 character code
#'
#' @param code the 3 to 5 letter set code
#'
#' @return a data.frame with set details
#' @export
get_set_by_code <- function(
  code = "wwk"
){

  assertthat::assert_that(nchar(code) <= 5, nchar(code) >= 3,
                          msg = "code must be a set code between 3 and 5 characters in length"
  )

  check_internet()


  res <- httr::GET(
    url = paste(set_url, code, sep = "/")
  )

  check_status(res)

  listed <- jsonlite::fromJSON(httr::content(res, "text", encoding = "UTF-8"))
  df <- as.data.frame(listed)

  return(df)

}
