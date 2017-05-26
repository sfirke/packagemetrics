getGitHub <- function(packages){
  load('data/cran.rda')

  cran_urls <- cran %>%
    filter(package %in% packages) %>%
    select(package, url, bugreports)

  url <- cran_urls$url[2] #temp
  find_github <- function(url){
    url <- gsub("\n", ",", url)
    url <- gsub(" ", "", url)
    url <- gsub("https", "http", url)
    url <- gsub("http", "https", url)
    url_list <- str_split(url, ",")[[1]]
    github_url <- url_list[str_detect(url_list, "//github.com")]
    github_url <- ifelse(length(github_url) == 0, NA, github_url)
    github_url <- ifelse(str_sub(github_url, -1) == "/", str_sub(github_url, 1, -2), github_url)
    return(github_url)
  }


  cran_urls %>%
    mutate(url_git = map_chr(url, find_github),
           bug_git = map_chr(bugreports, find_github) %>% str_replace("/issues",""),
           github_url = ifelse(is.na(url_git), bug_git, url_git)
    ) %>%
    select(package, github_url) %>%
    mutate(ongithub = !is.na(github_url))

}


