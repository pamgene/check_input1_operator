library(tercen)
library(dplyr)
library(pgCheckInput)

do.check <- function(df) {
  check(MultipleValuesPerCell, df)
  check(NonUniqueDataMapping, df, openUrlOnError = TRUE)
  
  df %>% rename(checked_input = .y) 
}

ctx = tercenCtx()

ctx %>% 
  select(.ci, .ri, .sids, .y) %>%
  do(do.check(.)) %>%
  select(-.sids) %>%
  ctx$addNamespace() %>%
  ctx$save()
