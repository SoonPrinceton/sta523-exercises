library(tidyverse)
library(palmerpenguins)

penguins |>
  filter(!is.na(sex)) |>
  mutate(
    sex = factor(sex, levels = c("male", "female"))
  ) |>
  ggplot(
    aes(x=body_mass_g, fill=species)  
  ) +
  geom_density(alpha=0.5, color=NA) +
  facet_wrap(~sex, ncol=1) +
  labs(
    x = "Body mass (g)",
    fill = "Species"
  )


penguins |>
  ggplot(
    aes(x = flipper_length_mm, y = bill_length_mm, color = species)
  ) +
  geom_point(
    aes(shape = species)
  ) +
  geom_smooth(method="lm", se=FALSE) +
  theme_minimal() +
  scale_color_manual(values=c("darkorange", "purple", "cyan4"))
