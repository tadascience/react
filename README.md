
<!-- README.md is generated from README.Rmd. Please edit that file -->

# react

<!-- badges: start -->

[![R-CMD-check](https://github.com/tadascience/react/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/tadascience/react/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of `react` is to help with reactivity, instead of calling the
`foo` reactive expression `foo()` you can call `react$foo` similar to
how one calls `input$bar` for inputs.

The benefit is that it makes it easier to identify calls to reactive
expressions in your server code.

## Installation

You can install the development version of react from
[GitHub](https://github.com/) with:

``` r
pak::pak("tadascience/react")
```
