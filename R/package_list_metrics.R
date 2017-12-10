#' @title Get metrics for a list of packages.
#'
#' @description
#' wrapper for combine_metrics for list of packages
#'
#' @param package_names_list list of CRAN packages - case-sensitive.
#' @inheritParams get_cran
#'
#' @return a tibble of package information
#' @export
#' @examples
#'
#' package_list_metrics(list("dplyr", "tidyr", "ggplot2"))

package_list_metrics <- function(package_names_list, forget = FALSE) {
  purrr::map_df(package_names_list, combine_metrics, forget)
}


