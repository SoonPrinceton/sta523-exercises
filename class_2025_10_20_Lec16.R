library(tidyverse)


## Demo 1

jsonlite::read_json(
  "https://api.github.com/users/rundel"
) |> 
  str()



jsonlite::read_json(
  "https://api.github.com/orgs/sta523-fa25/repos"
) |>
  map_chr("full_name")



jsonlite::read_json(
  "https://api.github.com/orgs/tidyverse/repos"
) |>
  map_chr("full_name")


jsonlite::read_json(
  "https://api.github.com/orgs/tidyverse/repos?per_page=30&page=2"
) |>
  map_chr("full_name")


jsonlite::read_json("https://api.github.com/user")

## Demo 2

library(httr2)

request("https://api.github.com/users/rundel")


request("https://api.github.com/orgs/tidyverse/repos") |>
  req_url_query(per_page=100, page=1) |>
  #req_dry_run()
  req_perform()

last_response() |>
  resp_body_json()

last_response() |>
  resp_body_string()

request("https://api.github.com/user") |>
  req_auth_bearer_token(gitcreds::gitcreds_get()$password) |>
  req_perform()

last_response() |>
  resp_body_json() |>
  str()


request("https://api.github.com/orgs/sta523-fa25/repos") |>
  req_auth_bearer_token(gitcreds::gitcreds_get()$password) |>
  req_perform() |>
  resp_body_json() |>
  map_chr("full_name")



## Create a gist

gist = request("https://api.github.com/gists") |>
  req_auth_bearer_token(gitcreds::gitcreds_get()$password) |>
  req_body_json( list(
    description = "Testing 1 2 3 ...",
    files = list("test.R" = list(content = "print('hello world')\n1+1\n2/3\n")),
    public = TRUE
  ) ) |>
  req_perform()

resp_body_json(gist) |>
  str()

resp_body_json(gist)$html_url





