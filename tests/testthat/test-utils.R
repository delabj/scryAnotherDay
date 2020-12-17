testthat::test_that("check_internet breaks if no internet", {
  testthat::with_mock(
    "curl::has_internet" = function() FALSE,
    testthat::expect_error(check_internet())
  )
})


testthat::test_that("check_status breaks if no response", {
  testthat::expect_error(check_status())
})

testthat::test_that("check_status stops if response is not 200", {
  testthat::expect_error(check_status(res = 201))
})

testthat::test_that("stop_if_not_in gives a message when not in", {
  testthat::expect_error(
    stop_if_not_in(1, c(2, 3, 4), "Error")
  )
})
