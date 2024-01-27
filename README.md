
<!-- README.md is generated from README.Rmd. Please edit that file -->

# react

<!-- badges: start -->

[![R-CMD-check](https://github.com/tadascience/react/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/tadascience/react/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of `react` is to help with reactivity, instead of calling the
`foo` reactive expression `foo()` you can call `react$foo` similar to
how one calls `input$bar` for inputs, or alternatively `react[foo]` or
`react[foo()]`.

The benefit is that it makes it easier to spot calls to reactive
expressions in your server code.

## Installation

You can install the development version of react from
[GitHub](https://github.com/) with:

``` r
pak::pak("tadascience/react")
```

## Examples

Take this from the shiny example:

``` r
server <- function(input, output) {

  dataInput <- reactive({
    getSymbols(input$symb, src = "yahoo",
               from = input$dates[1],
               to = input$dates[2],
               auto.assign = FALSE)
  })

  output$plot <- renderPlot({
    chartSeries(dataInput(), theme = chartTheme("white"),
                type = "line", log.scale = input$log, TA = NULL)
  })

}
```

With `react` you can rewrite the `plot` output as one of these,
depending on your taste.

``` r
  # react$ is similar conceptually to how input$ works
  output$plot <- renderPlot({
    chartSeries(react$dataInput, theme = chartTheme("white"),
                type = "line", log.scale = input$log, TA = NULL)
  })
  
  # react[] 
  output$plot <- renderPlot({
    chartSeries(react[dataInput], theme = chartTheme("white"),
                type = "line", log.scale = input$log, TA = NULL)
  })
  
  # react[()] so that you still have the calling a function feel
  #           and you just sourround it
  output$plot <- renderPlot({
    chartSeries(react[dataInput()], theme = chartTheme("white"),
                type = "line", log.scale = input$log, TA = NULL)
  })
  
```
