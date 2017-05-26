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
  cran %>%
  dplyr::filter(package %in% package_name) %>%
  dplyr::select(package, author,
         imports, depends, suggests, #enhances,
         reverse_imports, reverse_depends, reverse_suggests, reverse_enhances,
         vignettebuilder, published, title
         ) %>%
  dplyr::mutate_each(
    dplyr::funs(count = count_packages), depends:reverse_enhances) %>%
  dplyr::mutate(
    author_new = purrr::map(author, ~gsub("aut, cre", "", .)),
    author_count = purrr::map(author_new, count_packages), #number of authors
    tidyverse_happy = ifelse(stringr::str_detect(imports, paste(tidyverse::tidyverse_packages(), collapse="|")), 1, 0),
    has_vignette_build = ifelse(is.na(vignettebuilder), 1, 0)
    ) %>%
  dplyr::select(-author_new, -(imports:reverse_enhances), -vignettebuilder) %>%
  dplyr::left_join(get_cran_downloads(package_name), by="package")
}

count_packages <- function(x){
  ifelse(!is.na(x), purrr::map_int(x, ~stringr::str_split(., ", ")[[1]] %>% length(.)), NA)
}


get_cran_downloads <- function(package_name){
  cran_dl_last_day <- cranlogs::cran_downloads(packages = package_name, when = "last-day") %>%
    dplyr::rename(dl_last_day = count) %>%
    dplyr::select(package, dl_last_day)
  cran_dl_last_week <- cranlogs::cran_downloads(packages = package_name, when = "last-week") %>%
    dplyr::summarise(dl_last_week = sum(count))
  cran_dl_last_month <- cranlogs::cran_downloads(packages = package_name, when = "last-month") %>%
    dplyr::summarise(dl_last_month = sum(count))
  dplyr::bind_cols(cran_dl_last_day, cran_dl_last_week, cran_dl_last_month)
}

