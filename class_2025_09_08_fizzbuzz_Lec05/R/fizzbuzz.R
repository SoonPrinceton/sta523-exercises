#' @title Hello function
#'
#' @description A short description...
#'
#' @param name Character value of persons name to say hello to
#'
#' @returns Returns a character vector saying hello
#'
#' @examples
#' say_hello("Colin")
#' say_hello("Jane Doe")
#'
#'
#' @export

say_hello = function(name) {
  paste0("Hello, ",name,"!!!!")
}


#' @export
lag_vec = function(vec) {
  dplyr::lag(vec)
}


print_summary = function(data) {
  cat("Data summary:\n")
  cat("  Rows:", nrow(data), "\n")
  cat("  Columns:", ncol(data), "\n")
  cat("  Column names:", paste(names(data), collapse = ", "), "\n")
}
