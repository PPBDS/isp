# This is an R script for gathering the Census data which is used during week 2.
# I also include an example of the processing/plot code we use.

library(tidyverse)
library(tidycensus)
library(ggbeeswarm)

# This is take from: https://walker-data.com/census-r/exploring-us-census-data-with-visualization.html#ggbeeswarm

# The below is a bit hacky. But since the this data is used in the second week
# of classes, I wanted to make it as easy to handle as possible, with just three
# variables and no missing data.

x <- get_acs(
  geography = "tract", 
  state = "NY",  
  county = c("New York", "Bronx", "Queens", "Richmond", "Kings"),
  variables = c(White = "B03002_003", 
                Black = "B03002_004", 
                Asian = "B03002_006",
                Hispanic = "B03002_012"), 
  summary_var = "B19013_001",
  year = 2022
) 

z <- x |> 
group_by(GEOID) %>%
  filter(estimate == max(estimate, na.rm = TRUE)) %>%
  ungroup() %>%
  filter(estimate != 0 & ! is.na(summary_est)) |> 
  rename(tract = NAME, race = variable, population = estimate, med_income = summary_est) |> 
  select(tract, race, med_income) |> 
  arrange(tract)


write_csv(z, "nyc_tracts.csv")  

new <- read_csv("nyc_tracts.csv")
  
new |> 
ggplot(aes(x = race, y = med_income, color = med_income)) +
  geom_quasirandom(alpha = 0.5) + 
  coord_flip() + 
  theme_minimal(base_size = 13) + 
  scale_color_viridis_c(guide = "none") + 
  scale_y_continuous(labels = scales::label_dollar()) + 
  labs(x = "Largest group in Census tract", 
       y = "Median household income", 
       title = "Household income distribution by largest racial/ethnic group", 
       subtitle = "Census tracts, New York City", 
       caption = "2022 American Community Survey")
