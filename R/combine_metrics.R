combine_metrics <- function(package_name) {
  c_pkg <- cran_metrics(package_name)
  git_pkg <- scrape_github_package_page(package_name)
  dplyr::full_join(c_pkg, git_pkg, by="package")
}


