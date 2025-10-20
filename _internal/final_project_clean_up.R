# Clean up Final Project listing. Note the need to save the file as tab
# delimitted since many students will have commas in their one-sentence
# summaries.

library(tidyverse)
library(janitor) 

x <- read_tsv("~/Downloads/final-projects-bootcamp-june-2025 - Final Projects.tsv", skip = 6, show_col_types = FALSE) |>  
  janitor::clean_names() |> 


  mutate(output = paste0("[", name, "](", github_account, "): [",
                         project_name, "](", project_url, "). ", 
                         one_sentence_takeaway_of_project)) |>  
  select(output) |> 
  sample_frac()



writeLines(x$output, "_internal/new_projects.Rmd", sep = "  \n\n")

