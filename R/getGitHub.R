library(dplyr)

getGitHub <- function(package){
  dd <- tools::CRAN_package_db()
  out <- dd[ !duplicated(names(dd)) ] %>%
    filter(Package %in% package) %>%
    mutate(onGitHub = I(!is.na(BugReports)),
           GitHub = ifelse(is.na(BugReports), NA, stringr::str_replace(BugReports,'/issues',''))) %>%
    select(Package, GitHub, onGitHub)

  return(out)
}


