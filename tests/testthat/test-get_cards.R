testthat::test_that("get_cards_by_search fails without a query", {
  testthat::expect_error(get_cards_by_search(q = NULL))
})
testthat::test_that("get_cards_by_search fails if arguments are the the wrong type", {
  testthat::expect_error(get_cards_by_search(unique = 1)) # should be char
  testthat::expect_error(get_cards_by_search(order = FALSE)) # should be char
  testthat::expect_error(get_cards_by_search(dir = 2)) # should be char
  testthat::expect_error(get_cards_by_search(pretty = "False")) # should be logical
  testthat::expect_error(get_cards_by_search(include_extras = "False")) # should be logical
  testthat::expect_error(get_cards_by_search(include_variations = "False")) # should be logical
  testthat::expect_error(get_cards_by_search(format = TRUE)) # should be Char
  testthat::expect_error(get_cards_by_search(page = "1")) # should be numeric
})
testthat::test_that("get_cards_by_search fails if arguments aren't in lists", {
  testthat::expect_error(get_cards_by_search(unique = "card"))
  testthat::expect_error(get_cards_by_search(order = "names"))
  testthat::expect_error(get_cards_by_search(dir = "automatic"))
  testthat::expect_error(get_cards_by_search(format = "xlsx"))
})
