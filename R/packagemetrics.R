#' janitor
#'
#' packagemetrics gathers information about a package from CRAN, StackOverflow, and GitHub (if applicable).
#'
#' @docType package
#' @name packagemetrics
#' @importFrom dplyr %>%
#' @keywords internal
NULL
## quiets concerns of R CMD check re: the .'s that appear in pipelines
if(getRversion() >= "2.15.1")  utils::globalVariables(c("."))
