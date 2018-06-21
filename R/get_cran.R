get_memoise_cran <- memoise::memoise({
  function() {
    cran <- tools::CRAN_package_db()
    # remove first instance of column name MD5Sum
    cran <- cran[, -dplyr::first(which(names(cran) == "MD5sum"))]

    # make it a tibble
    cran <- dplyr::tbl_df(cran)

    if (packageVersion("janitor") > "0.3.1") {
      cran <- cran %>%
        janitor::clean_names(case = "old_janitor") %>%
        janitor::remove_empty("cols")
    } else {
      cran <- cran %>%
        janitor::clean_names() %>%
        janitor::remove_empty_cols()
    }
    cran
  }}
)

#' Get CRAN Packages
#'
#' Returns a tibble containing the current CRAN pacakges.
#' For efficiency reasons, the tibble is cached, so future calls will just return
#' the original tibble.
#' @param forget logical, default \code{FALSE}. Reset the CRAN package cache.
#' @export
#' @importFrom memoise memoise forget
#' @examples
#' cran <- get_cran()
get_cran <- function(forget = FALSE) {
  if(forget)
    memoise::forget(get_memoise_cran)
  get_memoise_cran()
}

