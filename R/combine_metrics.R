#' @title Combines metrics on a package from CRAN and Github
#'
#' @description
#' Combines metrics on a package from CRAN and Github
#'
#' @param package_name name of CRAN package - case-sensitive.
#'
#' @return a tibble of package information.
#' @export
#' @examples
#'
#' combine_metrics("dplyr")
#'
combine_metrics <- function(package_name) {
  c_pkg <- cran_metrics(package_name)
  git_pkg <- scrape_github_package_page(package_name)
  dplyr::full_join(c_pkg, git_pkg, by="package")
}


