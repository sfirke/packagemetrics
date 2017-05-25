library(datapasta)

tables <- c("Arsenal", "ascii", "condformat", "Desctable", 
  "DT", "expss", "ezsummary", "formattable", 
  "gmodels", "Gtable", 
  "Hmisc::latex", "htmlTable", "huxtable", "janitor", "kable",
"kableExtra", "pander", "pixiedust", "ReporteRs", "stargazer", 
"Tableone", "tables", "tangram", "texreg", "xtable", "Ztable", "Tabular")


save(tables, file="data/tables.rdata")
