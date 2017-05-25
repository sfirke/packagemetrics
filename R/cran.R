library(dplyr)
library(janitor)

cran <- tools::CRAN_package_db()

# the returned data frame has two columns with the same name???
cran <- cran[,-65]

# make it a tibble
cran <- tbl_df(cran)

cran <- cran %>%
  clean_names() %>%
  remove_empty_cols()

saveRDS(cran, "data/cran.rds")
