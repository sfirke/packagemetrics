# install.packages("devtools")
devtools::install_github("dgrtwo/stackr")

library("stackr")

Sys.setenv(STACK_EXCHANGE_KEY = "5Ib89*ZRQgg2kKogWgS3)g((")


## get # hits for a given pkg
hits <- function(pkg, sotag = "r", pagesize = 100, num_pages = 200, ...){
    res <- stack_search(body = pkg, tagged = sotag,  pagesize = pagesize,
                        num_pages = num_pages, ...)
    nrow(res)
}

foobar <- hits(pkg = "trackeR")
foo <- stack_search(body = "trackeR", tagged = "r", pagesize = 100, num_pages = 200)


















## get questions with [r] tag and "table" in the body 
results <- stack_search(tagged = "r", body = "table", filter = "withbody",
                        pagesize = 100, num_pages = 200)
save(results, file = "results_table.rda")
names(results)
results[1,"body"]


library("tidytext")
body <- results[, "body", drop = FALSE]
str(body)

tidyResults <- body %>% unnest_tokens(output = word, input = body, token = "words")
str(tidyResults)
head(tidyResults, 20)
foo <- tidyResults %>% anti_join(stop_words)
head(foo, 20) ## hu?

availPkg <- available.packages(repos="https://cran.rstudio.com")
class(availPkg)

library("tibble")
apkg <- as.tibble(availPkg)

fooInner <- tidyResults %>% inner_join(select(apkg, Package), by = c("word" = "Package"))
head(fooInner)
fooSemi<- tidyResults %>% semi_join(select(apkg, Package), by = c("word" = "Package"))
head(fooSemi)



###--------------------------------
## get df with posts with "table" in the title
posts <- stack_search(intitle = "table")

names(posts)
head(posts)

## get more info on those questions

qs <- stack_questions(id = posts$question_id)

names(qs)
head(qs)

as <- stack_questions(id = posts$question_id, special = "answers")

names(as)
head(as)

##---
