library(tidyverse)
library(gapminder)
library(gganimate)

# When replacing this in the index.qmd file, don't forget to delete the
# index_cache.

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

write_rds(gap_anim, file = "images/animation.rds")
