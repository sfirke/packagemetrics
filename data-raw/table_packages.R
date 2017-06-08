# List of table packages
table_packages <- c("arsenal", "ascii", "compareGroups","condformat", "desctable",
            "DT", "expss", "ezsummary", "formattable",
            "gmodels", "gtable",
            "Hmisc", "htmlTable", "huxtable", "janitor", "knitr",
            "kableExtra", "pander", "pixiedust", "ReporteRs", "stargazer",
            "tableone", "tables", "tangram", "texreg", "xtable", "ztable")

devtools::use_data(table_packages, overwrite = TRUE) # for interactive use
#devtools::use_data(tables, internal = TRUE) # for internal functions

