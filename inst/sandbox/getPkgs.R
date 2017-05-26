library(devtools)

install_github("lshep/stackr")

library(stackr)
library(tidyr)
library(tidytext)
library(dplyr)



getPkgs <- function(topic, tag, pagesize, numpage, repos){

  
    results <- stack_search(tagged = tag, body = topic, filter="withbody",
        pagesize=pagesize, num_pages=numpage)
    
    body <- results[, "body", drop = FALSE]
    tidyResults <-  body %>% unnest_tokens_(output_col = "word",  input_col = "body",
                                           token="words")
    pkgs = as.data.frame(available.packages(repos=repos)[,"Package"])
    names(pkgs) = "word"
    
    mm = match(as.character(pkgs[,1]), as.character(tidyResults[,1]))
    as.character(pkgs[which(!is.na(mm)),1])

}


#  getPkgs(topic="table", tag="r", pagesize=100, numpage=2, repos="https://cran.rstudio.com")
