library(datapasta)

tables <- c("Arsenal", "ascii", "condformat", "Desctable",
  "DT", "expss", "ezsummary", "formattable",
  "gmodels", "Gtable",
  "Hmisc", "htmlTable", "huxtable", "janitor", "kable",
"kableExtra", "pander", "pixiedust", "ReporteRs", "stargazer",
"Tableone", "tables", "tangram", "texreg", "xtable", "Ztable", "Tabular")


saveRDS(tables, file="data/tables.rds")
