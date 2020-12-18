
# Tests for get_cards_by_search
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
testthat::test_that("get_cards_by_search fails if arguments aren't in list options", {
  testthat::expect_error(get_cards_by_search(unique = "card"))
  testthat::expect_error(get_cards_by_search(order = "names"))
  testthat::expect_error(get_cards_by_search(dir = "automatic"))
  testthat::expect_error(get_cards_by_search(format = "xlsx"))
})

# Tests for get_cards_by_name
testthat::test_that("get_cards_by_name fails without a query", {
  testthat::expect_error(get_cards_by_name(q = NULL))
})
testthat::test_that("get_cards_by_name fails if arguments are the the wrong type", {
  testthat::expect_error(get_cards_by_name(search_type = 1))
  testthat::expect_error(get_cards_by_name(set = 1))
  testthat::expect_error(get_cards_by_name(format = 1))
  testthat::expect_error(get_cards_by_name(face = 1))
  testthat::expect_error(get_cards_by_name(version = 1))
  testthat::expect_error(get_cards_by_name(pretty = "False"))
})
testthat::test_that("get_cards_by_name fails if arguments aren't in list options", {
  testthat::expect_error(get_cards_by_name(search_type = "exactish"))
  testthat::expect_error(get_cards_by_name(face = "two"))
  testthat::expect_error(get_cards_by_name(face = "extra-medium"))
  testthat::expect_error(get_cards_by_name(format = "xlsx"))
})

# Tests for get_cards_autocomplete
testthat::test_that("get_cards_autocomplete fails without a query",{
  testthat::expect_error(get_cards_autocomplete(q = NULL))
})
testthat::test_that("get_cards_autocomplete fails if arguments are the the wrong type", {
  testthat::expect_error(get_cards_autocomplete(pretty = "False"))
  testthat::expect_error(get_cards_autocomplete(include_extras = "False"))
})

# Tests for get_cards_random
testthat::test_that(("get_cards_random fails without a query"), {
  testthat::expect_error(get_cards_autocomplete(q = NULL))
})

testthat::test_that(("get_cards_random fails if arguments are the the wrong type"), {
  testthat::expect_error(get_cards_autocomplete(format = 1))
  testthat::expect_error(get_cards_autocomplete(face   = 1))
  testthat::expect_error(get_cards_autocomplete(version = 1))
  testthat::expect_error(get_cards_autocomplete(pretty = "FALSE"))
})

# Tests for get_card_by_code
testthat::test_that(("get_card_by_code fails if arguments are wrong size"), {
  testthat::expect_error(get_card_by_code(code = "AA"))
  testthat::expect_error(get_card_by_code(code = "AAAAAA"))
  testthat::expect_error(get_card_by_code(code = "A"))
  testthat::expect_error(get_card_by_code(code = "AAAA"))

})

testthat::test_that(("get_card_by_code fails if arguments are the the wrong type"), {
  testthat::expect_error(get_card_by_code(number = "A"))
  testthat::expect_error(get_card_by_code(format = 1))
  testthat::expect_error(get_card_by_code(face   = 1))
  testthat::expect_error(get_card_by_code(version = 1))
  testthat::expect_error(get_card_by_code(pretty = "FALSE"))
})
