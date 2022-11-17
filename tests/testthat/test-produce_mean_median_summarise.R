# Test case 1: function should be terminated if the inputs' types are wrong.
library(palmerpenguins)
test_case_1 <- test_that("Testing function input type, target_summarise_col_label should be numeric value column", {
  expect_error(produce_mean_median_summarise(penguins, island, sex, TRUE),'The data is not a tibble or the variable target_summarise_col_label should be in numerical format.')
  expect_error(produce_mean_median_summarise(numeric(0), island, sex, TRUE),'The data is not a tibble or the variable target_summarise_col_label should be in numerical format.')
})
# Test case 2: check if the average and median are correct
correct_ans <- stats_values_summary <- penguins %>% # load data
  group_by(island) %>% # group data by `var_group`
  summarise(avg = mean(bill_depth_mm, na.rm = TRUE), median = median(bill_depth_mm, na.rm = TRUE))
test_case_2 <- test_that("Testing the calculation correctness, target_summarise_col_label should be numeric value column", {
  expect_equal(produce_mean_median_summarise(penguins, island, bill_depth_mm, TRUE), correct_ans)
})
# Test case 3: check the default value works if use did not pass a value to the na.rm variable.
test_case_3 <- test_that("Testing the default value of na.rm, the function should return a dropping NA cases even if we do not pass value to that variable.", {
  expect_equal(produce_mean_median_summarise(penguins, island, bill_depth_mm), correct_ans)
})
