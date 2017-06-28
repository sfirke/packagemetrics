#' @title Get CRAN-related metrics for a package.
#'
#' @description
#' Searches CRAN database to pull information like depnedencies, reverse dependencies, etc.
#'
#' @param package_name name of CRAN package - case-sensitive.
#'
#' @return a tibble of package information.
#' @export
#' @examples
#'
#' cran_metrics("dplyr")

cran_metrics <- function(package_name) {
  tv_packages <- c("broom",     "dplyr",     "forcats",   "ggplot2",   "haven",     "httr",      "hms",
                   "jsonlite",  "lubridate", "magrittr",  "modelr",    "purrr",     "readr",     "readxl",
                   "stringr",   "tibble",    "rvest",     "tidyr",     "xml2",      "tidyverse")
  cran %>%
  dplyr::filter(package %in% package_name) %>%
  dplyr::select(package,
         imports, depends, suggests,
         reverse_imports, reverse_depends,
         vignettebuilder, published, title
         ) %>%
  dplyr::mutate_at(dplyr::vars(depends:reverse_depends), dplyr::funs(count = count_packages)) %>%
  dplyr::mutate(
    tidyverse_happy = ifelse(stringr::str_detect(imports, paste(tv_packages, collapse="|")), TRUE, FALSE),
    has_vignette_build = ifelse(is.na(vignettebuilder), TRUE, FALSE),
    has_tests = ifelse(stringr::str_detect(suggests, "testthat|RUnit"), TRUE, FALSE),
    has_tests = ifelse(is.na(has_tests), FALSE, has_tests),
    reverse_count = ifelse(is.na(reverse_imports_count), 0, reverse_imports_count) + ifelse(is.na(reverse_depends_count), 0, reverse_depends_count)
    ) %>%
  dplyr::select(-(imports:reverse_depends), -vignettebuilder, -reverse_imports_count, -reverse_depends_count) %>%
  cbind(get_cran_downloads(package_name))
}

count_packages <- function(x){
  ifelse(!is.na(x), purrr::map_int(x, ~stringr::str_split(., ", ")[[1]] %>% length(.)), NA)
}


get_cran_downloads <- function(package_name){
  cranlogs::cran_downloads(packages = package_name, when = "last-month") %>%
    dplyr::summarise(dl_last_month = sum(count))
}


