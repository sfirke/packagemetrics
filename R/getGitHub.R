#' @title Get GitHub URLs for a set of package names (if they exist).
#'
#' @description
#' Looks at both Package URL and BugReports URL, returns GitHub URL if present in either.
#'
#' @param packages character vector of CRAN package names - case-sensitive.
#'
#' @return a vector of URLs.
#' @export
#' @examples
#'
#' getGitHub("dplyr")

getGitHub <- function(packages){

  inCran(packages)
  
  cran_urls <- cran %>%
    dplyr::filter(package %in% packages) %>%
    dplyr::select(package, url, bugreports)

  url <- cran_urls$url[2] #temp
  find_github <- function(url){
    url <- gsub("\n", ",", url)
    url <- gsub("^ | $", "", url)
    url <- gsub(" ", ",", url)
    url <- gsub("https", "http", url)
    url <- gsub("http", "https", url)
    url_list <- stringr::str_split(url, ",")[[1]]
    github_url <- url_list[stringr::str_detect(url_list, "//github.com")]
    github_url <- ifelse(length(github_url) == 0, NA, github_url)
    github_url <- ifelse(stringr::str_sub(github_url, -1) == "/", stringr::str_sub(github_url, 1, -2), github_url)
    return(github_url)
  }


  cran_urls %>%
    dplyr::mutate(url_git = purrr::map_chr(url, find_github),
           bug_git = purrr::map_chr(bugreports, find_github) %>% stringr::str_replace("/issues",""),
           github_url = ifelse(is.na(url_git), bug_git, url_git)
    ) %>%
    dplyr::select(package, github_url) %>%
    dplyr::mutate(ongithub = !is.na(github_url))

}

inCran <- function(package){
  #stopifnot(package %in% cran$package)
  if(! (package %in% cran$package )) stop("Package ",  package, " not in CRAN.  Only supply packages that exists in CRAN")
}


