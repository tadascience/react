#' Reactivity helper
#'
#' The `react` object gives alternative syntax to call
#' shiny reactive expressions.
#'
#' The benefit is that it makes them easier to spot in your code
#'
#' @examples
#' \dontrun{
#'   # imagine you have some shiny reactive
#'   foo <- reactive({
#'     whatever() + something()
#'   })
#'
#'   # react allows you to call it in 3 different ways
#'   # instead of the usual foo() form
#'   react$foo
#'   react[foo]
#'   react[foo()]
#' }
#' @export
react <- structure(list(), class = "react")

`%or%` <- function(x, y) {
  tryCatch(x, error = function(e) y)
}

#' @export
`$.react` <- function(x, name) {
  get(substitute(name), parent.frame())()
}

#' @importFrom rlang abort
#' @export
`[.react` <- function(x, i) {
  expr <- substitute(i)
  frame <- parent.frame()
  reactive <- switch(typeof(expr),
    symbol = get(as.character(expr, frame)),
    language = get(as.character(expr[[1L]], frame)),

    abort(c(
      "Unsupported react[<i>] form",
      i = "Use react[foo] or react[foo()]"
    ))
  )

  reactive()
}

#' @export
print.react <- function(x, ...) {
  code <- function(txt) {
    cli::col_silver(cli::style_italic(txt))
  }
  writeLines(glue::glue(
    "\U1F4A1 : use {code('react$foo')}, {code('react[foo]')}, or {code('react[foo()]')} instead of {code('foo()')} to call the foo reactive."
  ))

  writeLines("\U1F914 : so that you can easily recognise reactive calls")

  invisible(x)
}
