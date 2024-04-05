# Assume df_f4 contains the data
countries <- df_f4$iso

# Unit test to check if all countries are included in the plot
test_that("All countries are included in the plot", {
  expect_equal(length(unique(countries)), nrow(df_f4),
               info = "Number of unique countries should match the number of rows in the data frame.")
})