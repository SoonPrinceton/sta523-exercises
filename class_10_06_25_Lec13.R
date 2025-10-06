library(rvest)
library(tidyverse)


url = "https://www.rottentomatoes.com/"

(session = polite::bow(url))

page = polite::scrape(session)

df = tibble(
  name = page |>
    html_elements(
      ".ordered-layout__list--carousel:nth-child(1) .p--small"
    ) |>
    html_text(),
  critic_score = page |>
    html_elements(
      ".ordered-layout__list--carousel:nth-child(1) rt-text:nth-child(2)"
    ) |>
    html_text2() |>
    str_remove("%$") |>
    as.numeric(),
  url = page |>
    html_elements(
      ".ordered-layout__list--carousel:nth-child(1) a[href]"
    ) |>
    html_attr("href") |>
    purrr::discard(~str_detect(.x, "https")) |>
    (\(x) paste0(url, x))()
) 


get_rating = function(page) {
  polite::nod(
    session, 
    page
  ) |>
    polite::scrape() |>
    html_elements(
      "#hero-wrap rt-text:nth-child(7)"
    ) |>
    html_text()
}

df |>
  mutate(
    map_chr(url, get_rating),
    .progress = TRUE
  )



