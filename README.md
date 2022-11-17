assignment_b1
================
Mingyuan Du
2022-11-15

<!-- README.md is generated from README.Rmd. Please edit that file -->

# assignmentb1andb2dukedudu

<!-- badges: start -->
<!-- badges: end -->

The goal of assignmentb1andb2dukedudu is to calculate the summary stats
(mean and median) of given target stats label and group label.

## Installation

You can install the development version of assignmentb1andb2dukedudu
from [GitHub](https://github.com/) with:

``` r
install.packages("devtools")
devtools::install_github("stat545ubc-2022/assignment-b1-and-b2-dukedudu")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(assignmentb1andb2dukedudu)
#> Loading required package: dplyr
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
#> Loading required package: tibble
library(palmerpenguins)
produce_mean_median_summarise(penguins, island, bill_depth_mm, TRUE)
#> # A tibble: 3 × 3
#>   island      avg median
#>   <fct>     <dbl>  <dbl>
#> 1 Biscoe     15.9   15.5
#> 2 Dream      18.3   18.4
#> 3 Torgersen  18.4   18.4
produce_mean_median_summarise(penguins, island, bill_length_mm, TRUE)
#> # A tibble: 3 × 3
#>   island      avg median
#>   <fct>     <dbl>  <dbl>
#> 1 Biscoe     45.3   45.8
#> 2 Dream      44.2   44.7
#> 3 Torgersen  39.0   38.9
```
