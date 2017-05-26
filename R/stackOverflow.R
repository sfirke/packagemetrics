devtools::install_github("lshep/stackr")
library(stackr) ## -> DESCRIPTION
library(tidytext)


#' Get a list of CRAN packages associated with a topic
#'
#' @param topic What are you trying to do?
#' @param tag StackOverflow tag.
#' @param pagesize Size of each page to extract (max 100).
#' @param num_pages Number of pages to extract.
#' @param repos Vector of repository URLs passed on to \code{available.packages}.
#' @param ... Passed on to \code{stack_search}.
#'
#' @return A vector of packages mentioned in StackOverflow questions on the \code{topic}.
#' @export
#' @examples
#' get_pkgs(topics = "table", tag = "r", pagesize = 100, num_pages = 2)
#' get_pkgs(topics = c("table", "memory"), tag = "r", pagesize = 100, num_pages = 2)
get_pkgs <- function(topics, tag = "r", pagesize = 100, num_pages = 200, repos =
                     "https://cran.rstudio.com", ...){

    # get the list of packages
    pkgs <- as.data.frame(available.packages(repos = repos)[,"Package"])
    names(pkgs) <- "word"

    if (length(topics) == 1L) {
        get_pkgs_helper(topic=topics, pkgs, tag, pagesize, num_pages, ...)
    }else{
        Reduce(intersect, sapply(topics, FUN=get_pkgs_helper, pkgs = pkgs, tag =
                                 tag, pagesize = pagesize, num_pages = num_pages, ...))
    }

}

get_pkgs_helper<- function(topic, pkgs, tag = "r", pagesize = 100, num_pages = 200, ...){

    # get the questions from StackOverflow
    questions <- stackr::stack_search(tagged = tag, body = topic, filter = "withbody",
                                      pagesize = pagesize, num_pages = num_pages, ...)

    # tokenize the body text of the questions
    body <- questions[, "body", drop = FALSE]
    tidyResults <-  tidytext::unnest_tokens_(body, output_col = "word", input_col = "body",
                                             token = "words")

    # match words in question text with available packages
    mm <- match(as.character(pkgs[,"word"]), as.character(tidyResults[,"word"]))
    as.character(pkgs[which(!is.na(mm)),1])

}



#' Get number of search results on StackOverflow
#'
#' @param pkg Which package are you intersted in?
#' @param tag StackOverflow tag.
#' @param pagesize Size of each page to extract (max 100).
#' @param num_pages Number of pages to extract.
#' @param ... Passed on to \code{stack_search}.
get_hits <- function(pkg, tag = "r", pagesize = 100, num_pages = 200, ...){
    res <- stackr::stack_search(body = pkg, tagged = tag,  pagesize = pagesize,
                                num_pages = num_pages, ...)
    nrow(res)
}
