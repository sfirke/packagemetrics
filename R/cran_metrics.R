library(tidyverse)

count_packages <- function(x){
  ifelse(!is.na(x), map_int(x, ~str_split(., ", ")[[1]] %>% length(.)), NA)
}

cran_metrics <- function(package_name) {
  cran %>%
  filter(package %in% package_name) %>%
  select(package, author,
         imports, depends, suggests, #enhances,
         reverse_imports, reverse_depends, reverse_suggests, reverse_enhances,
         vignettebuilder, published,
        title
         ) %>%
  mutate_each(
    funs(count = count_packages), depends:reverse_enhances) %>%
  mutate(
    author_new = map(author, ~gsub("aut, cre", "", .)),
    author_count = map(author_new, count_packages), #number of authors
    tidyverse_happy = ifelse(str_detect(imports, paste(tidyverse::tidyverse_packages(), collapse="|")), 1, 0),
    has_vignette_build = ifelse(is.na(vignettebuilder), 1, 0)
    ) %>%
  select(-author_new, -(imports:reverse_enhances), -vignettebuilder)
}




