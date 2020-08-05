#' @title Get CRAN-related metrics for a package.
#'
#' @description
#' Searches CRAN database to pull information like dependencies, reverse dependencies, etc.
#'
#' @param package_name name of CRAN package - case-sensitive.
#' @inheritParams get_cran
#'
#' @return a tibble of package information.
#' @export
#' @examples
#'
#' cran_metrics("dplyr")

cran_metrics <- function(package_name, forget = FALSE) {
  tv_packages <- tidyverse::tidyverse_packages(include_self = TRUE)
  cran = get_cran(forget)

  if (!(package_name %in% cran$package)) {
    return(tibble::tibble(package = package_name,
                   published = NA, title = NA, depends_count = NA,suggests_count = NA,
                   tidyverse_happy = NA, has_vignette_build = NA, has_tests = NA,
                   reverse_count = NA, dl_last_month = NA))
  }

  cran %>%
  dplyr::filter(package %in% package_name) %>%
  dplyr::select(package,
         imports, depends, suggests,
         reverse_imports, reverse_depends,
         vignettebuilder, published, title
         ) %>%
  dplyr::mutate(dplyr::across(depends:reverse_depends, count_packages, .names = "{col}_count")) %>%
  dplyr::mutate(
    tidyverse_happy = ifelse(stringr::str_detect(imports, paste(tv_packages, collapse = "|")), TRUE, FALSE),
    has_vignette_build = ifelse(is.na(vignettebuilder), FALSE, TRUE),
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


