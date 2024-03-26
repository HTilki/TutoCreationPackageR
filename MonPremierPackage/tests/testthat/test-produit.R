testthat::test_that("multiplication fonctionne", {
  A <- 2
  B <- 5
  testthat::expect_equal(produit(A, B), 10)
})
