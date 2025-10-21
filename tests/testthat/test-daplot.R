test_that("incorrect column names return error", {
  expect_error(
    daplot(mtcars, mpg, wt, nonexistent_column),
    "Column `nonexistent_column` not found in `dat`."
  )
})

test_that("daplot returns a ggplot object", {
  p <- daplot(mtcars, mpg, wt, qsec)
  expect_s3_class(p, "ggplot")
})

test_that("non-data.frame input produces an error", {
  expect_error(
    daplot("not_a_dataframe", mpg, wt, qsec),
    "is.data.frame\\(dat\\) is not TRUE"
  )
})
