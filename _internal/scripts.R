# Collection of scripts I use for managing the course

library(tidyverse)
library(tutorial.helpers)

homework <- function(pattern = "."){
  
  
  x <- process_submissions("~/Downloads/submissions", 
                           pattern = pattern, 
                           key_vars = c("information-name", 
                                        "information-email", 
                                        "download-answers"), 
                           verbose = 2, 
                           keep_file_name = "Underscore")
  
  
  ret_df <- x |> 
    janitor::clean_names() |> 
    distinct(source, information_email, .keep_all = TRUE) |> 
    arrange(source, information_email)
  
  emails <- sort(unique(ret_df$information_email))
  names <- sort(unique(ret_df$information_name))
    
  cat("\n")
  cat(paste0("There are ", length(emails), " unique emails."))
  cat("\n")
  cat(paste(emails, collapse = ","))
  cat("\n\n")
  cat(paste0('"', paste(names, collapse = " # "), '"'))
  
  
  return(ret_df)  
}




assignments <- 
  c("getting-started",
    "introduction",
    "data-visualization",
    "rstudio-and-code", 
    "data-transformation", 
    "rstudio-and-github",
    "data-tidying",
    "terminal",
    "data-import",
    "getting-help",
    "layers",
    "exploratory-data-analysis",
    "communication",
    "an-introduction-to-tidycensus",
    "logical-vectors",
    "quarto-websites",
    "numbers",
    "strings",
    "regular-expressions",
    "factors",
    "dates-and-times")


z |> 
  janitor::clean_names() |> 
  filter(source %in% assignments) |> 
  mutate(source = factor(source, levels = assignments)) |> 
  group_by(source) |> 
  summarize(avg = median(as.numeric(download_answers)),
            N = n())


z |> 
  select(information_name, information_email) |> 
  distinct(information_name, .keep_all = TRUE) |> 
  distinct(information_email, .keep_all = TRUE) |> 
  arrange(information_name) |> 
  write_csv("rough-list-demo-day.cvs")

