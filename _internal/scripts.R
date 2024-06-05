# Collection of scripts I use for managing the course

library(tidyverse)

homework <- function(pattern = "."){
  
  
  x <- process_submissions("~/Downloads/submissions", 
                           pattern = pattern, 
                           key_vars = c("information-name", 
                                        "information-email", 
                                        "download-answers"), 
                           verbose = 2, 
                           keep_file_name = "Space")
  
  
  ret_df <- x |> 
    janitor::clean_names() |> 
    distinct(source, information_email, .keep_all = TRUE) |> 
    arrange(source, information_email)

  cat("\n\n")
  cat(paste(sort(unique(z$information_email)), collapse = ","))
  cat("\n\n")
  cat(paste(sort(unique(z$information_name)), collapse = " # "))
  
  return(ret_df)  
}
