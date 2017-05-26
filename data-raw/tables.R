tables <- c("arsenal", "ascii", "condformat", "desctable",
  "DT", "expss", "ezsummary", "formattable",
  "gmodels", "gtable",
  "Hmisc", "htmlTable", "huxtable", "janitor", "knitr",
"kableExtra", "pander", "pixiedust", "ReporteRs", "stargazer",
"tableone", "tables", "tangram", "texreg", "xtable", "ztable")


saveRDS(tables, file="data/tables.rds")

# Notes:
# - kable in a function in knitr
# - where did this come form "Tabular"?
