library(rvest)
library(tidyverse)
library(jsonlite)

url = "https://www.wyndhamhotels.com/laquinta/locations"

x = read_html(url) |>
  html_elements(".property a:nth-child(1)") |>
  html_attr("href") |>
  (\(x) fs::path(dirname(dirname(url)), x))()

x[1]

dir.create("data/lq", showWarnings = FALSE, recursive = TRUE)

out = fs::path(
  "data/lq/",
  paste0(basename(dirname(x[1])), ".html")
)

message("Downloading ", out)
download.file(x[1], out, quiet=TRUE)


## Dennys location API

url = paste0(
  "https://www.dennys.com/restaurants/near?",
  "lat=35.779557&long=-78.638148",
  "&radius=250&limit=1000",
  "&nomnom=calendars&nomnom_calendars_from=20251007&nomnom_calendars_to=20251015&nomnom_exclude_extref=999"
)

jsonlite::read_json(url) |> View()



    