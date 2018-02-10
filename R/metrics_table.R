#' @title Formatted table of package metrics
#'
#' @description
#' Produce a formatted table of package metrics.
#'
#' @param pkg_df A data.frame of package metrics as returned by \code{package_list_metrics}.
#'
#' @seealso \code{package_list_metrics}
#'
#' @export
#' @examples
#' \dontrun{
#' pkgs <- package_list_metrics(list("dplyr", "tidyr", "ggplot2"))
#' metrics_table(pkgs)
#' }

metrics_table <- function(pkg_df){
  pd <- pkg_df %>%
    dplyr::select(package, published, dl_last_month, stars,
           tidyverse_happy, has_tests, has_vignette_build,
           last_commit, last_issue_closed, contributors,
           depends_count, reverse_count) %>%
    dplyr::mutate(last_commit = round(last_commit, 1),
           last_issue_closed = round(last_issue_closed, 1)) %>%
    dplyr::rename(vignette = has_vignette_build)
  pd[is.na(pd)] <- ""

  # TODO: export (some) of the arguments, e.g., the icon for 'tidyverse_happy'?
  ft <- formattable::formattable(pd, list(
    package=formattable::formatter("span",
                                   style = x ~ formattable::style(font.weight = "bold")),
    contributors = formattable::color_tile("white","#1CC2E3"),
    depends_count = formattable::color_tile("white", "#1CC2E3"),
    reverse_count = formattable::color_tile("white", "#1CC2E3"),
    tidyverse_happy = formattable::formatter("span",
                                             style = x ~ formattable::style(
                                               color = ifelse(x, "purple", "white")),
                                             x ~ formattable::icontext(ifelse(x, "glass", "glass"))),
    vignette = formattable::formatter("span",
                         style = x ~ formattable::style(color = ifelse(x, "green", "white")),
                         x ~ formattable::icontext(ifelse(x, "ok","ok"))),
    has_tests =  formattable::formatter("span",
                           style = x ~ formattable::style(color = ifelse(x, "green", "red")),
                           x ~ formattable::icontext(ifelse(x, "ok", "remove"))),
    dl_last_month = formattable::color_bar(color = "#56A33E", fun = formattable::proportion),
    forks = formattable::color_tile("white", "#56A33E"),
    stars = formattable::color_tile("white", "#56A33E"),
    last_commit = formattable::color_tile("#F06B13", "white", na.rm=TRUE),
    last_issue_closed = formattable::color_tile("#F06B13", "white", na.rm=TRUE)
  ))

  return(ft)
}
