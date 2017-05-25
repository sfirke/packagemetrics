#' @title Get package metrics from a GitHub repo URL.
#'
#' @description
#' Looks at metadata of the badge graphic URLs to determine if a package uses continuous integration and test coverage.
#'
#' @param repo_url character string in the format "https://github.com/username/packagename"
#'
#' @return a data.frame with metric info
#' @export
#' @examples
#'
#'scrape_github_package_page("https://github.com/tidyverse/dplyr")


scrape_github_package_page <- function(repo_url){

  package_name <- sub('.*\\/', '', repo_url)
  image_info <- repo_url %>%
    xml2::read_html() %>%
    rvest::html_nodes("p img") %>%
    purrr::map(xml_attrs) %>%
    purrr::map_df(~as.list(.))

  if(! "data-canonical-src" %in% names(image_info)){
    return(
      data.frame(ci = "NONE",
                 test_coverage = FALSE
      )
    )
  }

  travis <- sum(str_detect(image_info$`data-canonical-src`, "travis-ci"), na.rm = TRUE) >0
  appveyor <- sum(str_detect(image_info$`data-canonical-src`, "appveyor"), na.rm = TRUE) > 0
  codecov <- sum(str_detect(image_info$`data-canonical-src`, "codecov"), na.rm = TRUE) > 0
  ci <- case_when(
    !travis & !appveyor ~ "NONE",
    travis & appveyor ~ "Travis, Appveyor",
    travis ~ "Travis",
    appveyor ~ "Appveyor"
  )

  data.frame(package = package_name,
             ci = ci,
             test_coverage = codecov
  )

}


