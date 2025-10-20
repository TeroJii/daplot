test_that("incorrect column names return error", {
  expect_error(
    daplot(mtcars, mpg, wt, nonexistent_column),
    "Column `nonexistent_column` not found in `dat`."
  )
})
