assignment_b1
================
Mingyuan Du
2022-11-03

## Exercise 1: Make a Function

``` r
library(palmerpenguins)
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(tibble)
library(testthat)
```

    ## 
    ## Attaching package: 'testthat'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     matches

## Exercise 1: Make a Function

``` r
produce_mean_median_summarise <- function(.data, col_label, target_summarise_col_label, na.rm=TRUE) {

  # determine if the input data is a tibble
  # determine if the variable x that you want to get median values is in numerical format 
  # use deparse(substitute(var_x)) to get the name of the var_x 
  # data[["name of a variable"]] can help extract the column
  # reference: https://stackoverflow.com/questions/69806040/how-to-check-whether-column-is-numeric-inside-the-function-call
  if(!is_tibble(.data) || !is.numeric(.data[[deparse(substitute(target_summarise_col_label))]])) {
    stop('The data is not a tibble or the variable target_summarise_col_label should be in numerical format.')
  } 
  stats_values_summary <- .data %>% # load data
    group_by({{col_label}}) %>% # group data by `var_group`
    summarise(avg = mean({{target_summarise_col_label}}, na.rm = na.rm), median = median({{target_summarise_col_label}}, na.rm = na.rm))  # get the median and mean of target_summarise_col_label in col_label group, and users can decide whether remove NA or not.
  
  return(stats_values_summary) 
}
```

## Exercise 2: Document your Function

``` r
#' @details the function is designed for calculating the summary stats (mean and median) of given target stats label and group label.
#' @param .data the data (has to be in tibble version)
#' @param col_label the data column will be used for grouping.
#' @param target_summarise_col_label is the numeric data column will be used to calculate the statistic values.
#' @param na.rm is a bool variable will be used to drop na values or not.
#' @return the mean and median target_summarise_col_label of the data grouped by col_label
```

## Exercise 3: Include examples

``` r
# penguins will be used as an example dataset. The function will calculate the average and median value of bill_depth_mm grouping by island.
head(penguins)
```

    ## # A tibble: 6 × 8
    ##   species island    bill_length_mm bill_depth_mm flipper_l…¹ body_…² sex    year
    ##   <fct>   <fct>              <dbl>         <dbl>       <int>   <int> <fct> <int>
    ## 1 Adelie  Torgersen           39.1          18.7         181    3750 male   2007
    ## 2 Adelie  Torgersen           39.5          17.4         186    3800 fema…  2007
    ## 3 Adelie  Torgersen           40.3          18           195    3250 fema…  2007
    ## 4 Adelie  Torgersen           NA            NA            NA      NA <NA>   2007
    ## 5 Adelie  Torgersen           36.7          19.3         193    3450 fema…  2007
    ## 6 Adelie  Torgersen           39.3          20.6         190    3650 male   2007
    ## # … with abbreviated variable names ¹​flipper_length_mm, ²​body_mass_g

``` r
stats_value <- produce_mean_median_summarise(penguins, island, bill_depth_mm, TRUE)
print(stats_value)
```

    ## # A tibble: 3 × 3
    ##   island      avg median
    ##   <fct>     <dbl>  <dbl>
    ## 1 Biscoe     15.9   15.5
    ## 2 Dream      18.3   18.4
    ## 3 Torgersen  18.4   18.4

## Exercise 4: Test

``` r
# Test case 1: function should be terminated if the inputs' types are wrong.
test_case_1 <- test_that("Testing function input type, target_summarise_col_label should be numeric value column", {
  expect_error(produce_mean_median_summarise(penguins, island, sex, TRUE),'The data is not a tibble or the variable target_summarise_col_label should be in numerical format.')
})
```

    ## Test passed 😀

``` r
# Test case 2: check if the average and median are correct
correct_ans <- stats_values_summary <- penguins %>% # load data
    group_by(island) %>% # group data by `var_group`
    summarise(avg = mean(bill_depth_mm, na.rm = TRUE), median = median(bill_depth_mm, na.rm = TRUE)) 
test_case_2 <- test_that("Testing the calculation correctness, target_summarise_col_label should be numeric value column", {
  expect_equal(produce_mean_median_summarise(penguins, island, bill_depth_mm, TRUE), correct_ans)
})
```

    ## Test passed 🎉

``` r
# Test case 3: check the default value works if use did not pass a value to the na.rm variable.
test_case_3 <- test_that("Testing the default value of na.rm, the function should return a dropping NA cases even if we do not pass value to that variable.", {
  expect_equal(produce_mean_median_summarise(penguins, island, bill_depth_mm), correct_ans)
})
```

    ## Test passed 🥇
