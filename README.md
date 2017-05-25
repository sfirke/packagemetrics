# packagemetrics

This repo is for a package to obtain a collection of metrics on R packages which are intended to inform the decision which package you choose for a certain task.

This is based on issues [#78 Avoiding redundant / overlapping packages](https://github.com/ropensci/unconf17/issues/78) and [#69 A framework for reproducible tables](https://github.com/ropensci/unconf17/issues/69) for the unconf 17.


## TO DO

Collection of ideas for metrics:


### CRAN

- Does it have a public repo?
- Does it have an issue tracker or similar?
- Dependencies
    - Reverse dependencies - are others depending on this?
    - Dependencies - is it built on a solid stack?
- Is the package being maintained?
    - Date of first release?
    - Date of latest release
- Does it have a vignette (how many?)


### GitHub

- Is the package being maintained?
    - Last commit?
    - How many users have committed in the last [interval of time]?
    - Issue tracker?
    - When was the last issue closed?
- Tests    
    - Does the package have tests?
    - What's the test coverage?
    - Does it have continuous integration?
- Analysis of help pages 
    - Keywords
    - Similarity of multiple pkgs
    - What % of function man pages have an example?
- What packages are commonly co-mentioned with it?  Could be in its own documentation/vignette or on GitHub scripts where it is mentioned


### StackOverflow

- Popularity in stackoverflow answers 
- What packages are commonly co-mentioned with it?



### Other

- User-friendliness - is it modular, “tidy”, clean syntax, coherent theory, not flexible, not trying to do too much
- Are there any/many blog posts on/which mention a pkg?
