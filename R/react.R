#' Reactivity helper
#'
#' The `react` object gives alternative syntax to call
#' shiny reactive expressions.
#'
#' The benefit is that it makes them easier to spot in your code.
#'
#' @examples
#' # This works by invoking the function from the parent environment
#' # with no arguments ...
#' foo <- function() {
#'   42
#' }
#' react$foo
#' react[foo]
#' react[foo()]
#'
#' \dontrun{
#'   # ... but it only becomes relevant when used in shiny
#'   # server code, e.g. this app from the shiny page
#'   # with react$dataInput instead of dataInput()
#'   server <- function(input, output) {
#'
#'     dataInput <- reactive({
#'       getSymbols(input$symb, src = "yahoo",
#'           from = input$dates[1],
#'             to = input$dates[2],
#'             auto.assign = FALSE)
#'     })
#'
#'     output$plot <- renderPlot({
#'        chartSeries(react$dataInput, theme = chartTheme("white"),
#'               type = "line", log.scale = input$log, TA = NULL)
#'     })
#'   }
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
