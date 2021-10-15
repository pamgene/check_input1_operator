library(tercen)
library(dplyr)
library(pgCheckInput)

# Set appropriate options
#options("tercen.serviceUri"="http://tercen:5400/api/v1/")
#options("tercen.workflowId"= "050e773677ecc404aa5d5a7580016b7d")
#options("tercen.stepId"= "6a509b68-33a3-4397-9b9c-12696ce2ffac")
#options("tercen.username"= "admin")
#options("tercen.password"= "admin")

do.check <- function(df) {
  check(MultipleValuesPerCell, df)
  check(NonUniqueDataMapping, df, openUrlOnError = TRUE)
  
  df %>% rename(checked_input = .y) 
}

ctx = tercenCtx()

ctx %>% 
  select(.ci, .ri, .sids, .tlbIdx, .y) %>%
  do(do.check(.)) %>%
  select(-c(.sids, .tlbIdx)) %>%
  ctx$addNamespace() %>%
  ctx$save()
