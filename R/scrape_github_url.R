#' @title Get package metrics from a GitHub repo URL.
#'
#' @description
#' Looks at metadata of the badge graphic URLs to determine if a package uses continuous integration and test coverage.
#'
#' @param package_name name of package
#'
#' @return a data.frame with metric info
#' @export
#' @importFrom httr http_status GET
#' @examples
#'
#'scrape_github_package_page("dplyr")
#'# don't run:
#'# table_packages[1:5] %>% purrr::map_df(scrape_github_package_page)


scrape_github_package_page <- function(package_name){
  if(in_cran(package_name)) {
    gh_info <- getGitHub(package_name)
    repo_url <- gh_info$github_url
  }

  if(!in_cran(package_name) || is.na(repo_url) || http_status(GET(repo_url))$category != "Success"){
    return(tibble::tibble(package = package_name,
                      ci = NA,
                      test_coverage = NA,
                      forks = NA,
                      stars = NA,
                      watchers = NA,
                      last_commit = NA,
                      last_issue_closed = NA,
                      contributors = NA
                      )
          )
  }

  page_html <- repo_url %>%
    xml2::read_html()

  image_info <- page_html %>%
    rvest::html_nodes("p img") %>%
    purrr::map(xml2::xml_attrs) %>%
    purrr::map_df(~as.list(.))

  if(! "data-canonical-src" %in% names(image_info)) { # if no images, don't try to crawl badges
    ci <- "NONE"
    codecov <- NA
  } else {
    travis <- sum(stringr::str_detect(image_info$`data-canonical-src`, "travis-ci"), na.rm = TRUE) > 0
    appveyor <- sum(stringr::str_detect(image_info$`data-canonical-src`, "appveyor"), na.rm = TRUE) > 0
    codecov <- sum(stringr::str_detect(image_info$`data-canonical-src`, "codecov"), na.rm = TRUE) > 0
    ci <- dplyr::case_when(!travis & !appveyor ~ "NONE",
                           travis & appveyor ~ "Travis, Appveyor",
                           travis ~ "Travis",
                           appveyor ~ "Appveyor")
  }

  tibble::tibble(package = package_name,
             ci = ci,
             test_coverage = ifelse(codecov, "CodeCov", "NONE")
  ) %>%
    dplyr::bind_cols(get_social_stats_from_html(page_html),
                     get_last_commit(page_html),
                     get_last_issue_closed(repo_url),
                     get_num_contributors(page_html))
}


get_social_stats_from_html <- function(page_html){
  page_html %>%
    rvest::html_nodes(".social-count") %>%
    purrr::map(xml2::xml_attrs) %>%
    purrr::map_df(~as.list(.)) %>%
    dplyr::select(`aria-label`) %>%
    dplyr::mutate(github_social = stringr::str_extract(`aria-label`, "[[:digit:]]+"),
                  action = c("watchers", "stars", "forks")) %>%
    dplyr::select(action, github_social) %>%
    dplyr::mutate(github_social = as.numeric(github_social)) %>%
    tidyr::spread(action, github_social)

}

get_last_commit <- function(page_html){
  dateLastCommit <- page_html %>%
    rvest::html_nodes("relative-time") %>%
    purrr::map(xml2::xml_attrs) %>%
    purrr::map_df(~as.list(.)) %>%
    dplyr::slice(1) # as of Aug 2020, first value is most recent commit, second is latest release


  if(nrow(dateLastCommit) == 0){
    # dateLastCommit <- dplyr::tibble(last_commit = NA_character_)
    dateLastCommit <- dplyr::tibble(last_commit = NA)
  } else{
    dateLastCommit <- dateLastCommit %>%
      dplyr::mutate(date = gsub("T.*", "", datetime)) %>%
      dplyr::transmute(last_commit = as.numeric(Sys.Date() - as.Date(date))/30)
  }

  dateLastCommit

}

get_last_issue_closed <- function(repo_url){
  result <- paste0(repo_url, "/issues?q=is%3Aissue+is%3Aclosed+sort%3Aupdated-desc") %>%
    xml2::read_html() %>%
    rvest::html_nodes(".opened-by") %>%
    rvest::html_text() %>%
    tibble::tibble(last_issue_closed=.) %>%
    dplyr::mutate(last_issue_closed = gsub("\n|updated","",last_issue_closed) %>%
                    stringr::str_extract(., "(?<=was closed )(.*)") %>%
                    as.Date(., format = "%B %d, %Y")) %>%
    dplyr::mutate(last_issue_closed = as.numeric(Sys.Date() - last_issue_closed)/30) %>%
    dplyr::slice(1)
  if(nrow(result) == 0){
    result <- dplyr::tibble(last_issue_closed = as.numeric(NA))
  }
  result
}

get_num_contributors <- function(page_html){
  no_of_contributors <- page_html %>%
    rvest::html_nodes(".Counter") %>%
    rvest::html_text() %>%
    dplyr::last() %>% as.numeric()

  if(length(no_of_contributors) == 0L) no_of_contributors = NA

  tibble::tibble(contributors = no_of_contributors)
}
