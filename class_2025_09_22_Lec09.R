library(tidyverse)

draw_points = function(n) {
  list(
    x = runif(n),
    y = runif(n)
  )
}

in_unit_circ = function(d) {
  sqrt(d$x^2 +d$y^2) <= 1
}

n = 1e6
draw_points(n) |>
  in_unit_circ() |>
  sum() |>
  (\(x) (4*x / n))()


tibble(
  n = 10^(1:7)
) |>
  mutate(
    draws = purrr::map(n, draw_points),
    n_in_unit_circ = purrr::map_int(draws, ~ sum(in_unit_circ(.x))),
    pi_approx = 4*n_in_unit_circ / n,
    error = abs(pi - pi_approx)
  )
