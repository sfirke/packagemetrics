# Grabs latest CRAN data, updates the file in the package's /data directory

refresh_cran_database <- function(overwrite = FALSE){ # to be safe - specify TRUE to actually update the data
  cran <- tools::CRAN_package_db()


  # remove first instance of column name MD5Sum
  cran <- cran[, -dplyr::first(which(names(cran) == "MD5sum"))]

  # make it a tibble
  cran <- tbl_df(cran)


  cran <- cran %>%
    janitor::clean_names() %>%
    janitor::remove_empty_cols()

  devtools::use_data(cran, overwrite = overwrite)
}
