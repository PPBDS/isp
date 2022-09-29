library(tidyverse)
library(gapminder)
library(gganimate)

# Getting this warning when building:

# The `negative_parens` argument of `dollar()` is deprecated as of scales 1.2.0.
# Please use the `style_negative` argument instead.
# This warning is displayed once every 8 hours.
# Call `lifecycle::last_lifecycle_warnings()` to see where this warning was generated. 

gap_anim <- gapminder %>%
  filter(continent != "Oceania") %>%
  ggplot(aes(gdpPercap, lifeExp, color = continent)) +
  geom_point(show.legend = FALSE, alpha = 0.7) +
  facet_wrap(~continent, nrow = 1) +
  scale_size(range = c(2, 12)) +
  scale_x_log10(breaks = c(500, 5000, 50000),
                labels = scales::dollar_format(accuracy = 1)) +
  labs(subtitle = "Life Expectancy and GDP per Capita (1952-2007)",
       x = "GDP per Capita, USD",
       y = "Life Expectancy, Years") +
  theme_linedraw() +
  transition_time(year) +
  labs(title = "Year: {frame_time}") +
  shadow_wake(wake_length = 0.1, alpha = FALSE)

gap_anim

write_rds(gap_anim, file = "animation.rds")
