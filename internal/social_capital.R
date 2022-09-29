# Rough notes for working with social capital data. Source:
# https://www.socialcapital.org/

library(tidyverse)

x <- read_csv("internal/social_capital_data/social_capital_county.csv") |> 
  select(county, county_name, pop2018, ec_county)

write_rds(x, file = "internal/ec.rds")


# ec_county seems like the key explanatory variable. Baseline definition of
# economic connectedness: two times the share of high-SES friends among low-SES
# individuals, averaged over all low-SES individuals in the county.

# What is the relevant income variable? Seems like it is not in the main data
# set. Argg!

income <- read_csv("internal/county_outcomes.csv")

y <- income |> 
  select(state, county, kir_pooled_pooled_mean, kfr_pooled_pooled_mean)
