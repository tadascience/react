#' Reactivity helper
#'
#' The `react` object allow you to use the `react$foo` syntax
#' instead of calling `foo()`.
#'
#' The benefit is that it makes it easier to identify calls to reactive
#' expressions and take them apart from calls to functions.
#'
#' @export
react <- structure(list(), class = "react")

#' @export
`$.react` <- function(x, name) {
  eval(get(substitute(name), parent.frame())(), parent.frame())
}

#' @export
print.react <- function(x, ...) {
  writeLines(glue::glue(
    "\U1F4A1 : use {y} instead of {z} to call the foo reactive.",
    y = cli::col_silver(cli::style_italic("react$foo")),
    z = cli::col_silver(cli::style_italic("foo()"))
  ))

  writeLines("\U1F914 : so that you can easily recognise reactive calls")

  invisible(x)
}
