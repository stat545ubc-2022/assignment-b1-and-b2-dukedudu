#' @title Produce Mean Median Summarise
#' @details the function is designed for calculating the summary stats (mean and median) of given target stats label and group label.
#' @param .data the data (has to be in tibble version)
#' @param col_label the data column will be used for grouping.
#' @param target_summarise_col_label is the numeric data column will be used to calculate the statistic values.
#' @param na.rm is a bool variable will be used to drop na values or not.
#' @return The mean and median target_summarise_col_label of the data grouped by col_label
#' @export
#' @examples
#' library(palmerpenguins)
#' library(dplyr)
#' library(tibble)
#' produce_mean_median_summarise(palmerpenguins::penguins, island, bill_depth_mm, TRUE)
#' produce_mean_median_summarise(palmerpenguins::penguins, island, bill_length_mm, TRUE)
produce_mean_median_summarise <- function(.data, col_label, target_summarise_col_label, na.rm=TRUE) {

  # determine if the input data is a tibble
  # determine if the variable x that you want to get median values is in numerical format
  # use deparse(substitute(var_x)) to get the name of the var_x
  # data[["name of a variable"]] can help extract the column
  # reference: https://stackoverflow.com/questions/69806040/how-to-check-whether-column-is-numeric-inside-the-function-call
  if(!tibble::is_tibble(.data) || !is.numeric(.data[[deparse(substitute(target_summarise_col_label))]])) {
    stop('The data is not a tibble or the variable target_summarise_col_label should be in numerical format.')
  }
  stats_values_summary <- .data %>% # load data
    group_by({{col_label}}) %>% # group data by `var_group`
    summarise(avg = mean({{target_summarise_col_label}}, na.rm = na.rm), median = median({{target_summarise_col_label}}, na.rm = na.rm))  # get the median and mean of target_summarise_col_label in col_label group, and users can decide whether remove NA or not.

  return(stats_values_summary)
}
