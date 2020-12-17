base_url <- "https://api.scryfall.com"
card_url <- "https://api.scryfall.com/cards"



#' @importFrom attempt stop_if_not
#' @importFrom curl has_internet
check_internet <- function(){
  attempt::stop_if_not(
    .x = curl::has_internet(),
    msg = "No internet detected, Please check your network connection"
    )
}

#' @importFrom httr status_code
check_status <- function(res){
  stop_if_not(
    .x = httr::status_code(res),
    .p = ~ .x == 200,
    msg = "The API returned an error"
    )
}

#' stop if not in
#' @importFrom usethis ui_stop
#' @param var Name of var to check
#' @param list list of acceptable options
#' @param msg the warning message to display
stop_if_not_in <- function(var, list, msg){
  if(var %in% list){
    return()
  }
  else{
    usethis::ui_stop(msg)
  }

}
