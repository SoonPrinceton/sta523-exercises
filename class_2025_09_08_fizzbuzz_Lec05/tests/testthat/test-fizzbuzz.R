test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})


test_that("`+` works correctly", {
  expect_equal(`+`(2, 3), 5)
  expect_equal(`+`(0, 0), 0)
  expect_type(`+`(1, 1), "double")
  expect_type(`+`(1L, 1L), "integer")
})


test_that("print_summary produces consistent output", {
  df = data.frame(x = 1:3, y = letters[1:3])

  expect_snapshot({
    print_summary(df)
  })
})
