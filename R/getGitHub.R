getGitHub <- function(packages){
  dd <- readRDS('data/cran.rds')

  out <- dd[ !duplicated(names(dd)) ] %>%
    filter(package %in% packages) %>%
    mutate(ongithub = str_detect("github.com", bugreports),
           github = ifelse(is.na(bugreports), NA, stringr::str_replace(bugreports,'/issues',''))) %>%
    select(package, github, ongithub)

  return(out)
}

