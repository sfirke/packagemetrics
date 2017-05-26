# List of table packages


  tables <- c("arsenal", "ascii", "condformat", "desctable",
              "DT", "expss", "ezsummary", "formattable",
              "gmodels", "gtable",
              "Hmisc", "htmlTable", "huxtable", "janitor", "knitr",
              "kableExtra", "pander", "pixiedust", "ReporteRs", "stargazer",
              "tableone", "tables", "tangram", "texreg", "xtable", "ztable", "compareGroups")

  devtools::use_data(tables, overwrite = TRUE) # for interactive use
  #devtools::use_data(tables, internal = TRUE) # for internal functions

