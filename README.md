<<<<<<< 6369b94d6628bda06539aacfa35be067ecdfd749
# packagemetrics
=======
# packagemetrics

This repo is for a package to obtain a collection of metrics on R packages which are intended to inform the decision which package you choose for a certain task.

This is based on issues [#78 Avoiding redundant / overlapping packages](https://github.com/ropensci/unconf17/issues/78) and [#69 A framework for reproducible tables](https://github.com/ropensci/unconf17/issues/69) for the unconf 17.


## TO DO

Collection of ideas for metrics:

- Dependencies
    - Reverse dependencies - are others depending on this?
    - Dependencies - is it built on a solid stack?
- Is the package being maintained?
    - Last commit?
    - How many users have committed in the last [interval of time]?
    - Issue tracker?
    - When was the last issue closed?
- Does the package have tests? / test coverage
- Does it have continuous integration?
- User-friendliness - is it modular, “tidy”, clean syntax, coherent theory, not flexible, not trying to do too much
- Does it have a vignette (how many?)
- Analysis of help pages 
    - Keywords
    - Similarity of multiple pkgs
- Popularity in stackoverflow answers (?)
- Are there any/many blog posts on/which mention a pkg?
- What % of function man pages have an example?
- What packages are commonly co-mentioned with it:
    - Could be in its own documentation/vignette; or StackOverflow; or on GitHub scripts where it is mentioned
>>>>>>> added links to issues for #runconf17
