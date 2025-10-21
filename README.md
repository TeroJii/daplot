
<!-- README.md is generated from README.Rmd. Please edit that file -->

# daplot

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/TeroJii/daplot/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/TeroJii/daplot/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of daplot is to provide a simplified interface for creating a
plot with a dual axis in ggplot2.

## Installation

You can install the development version of daplot from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("TeroJii/daplot")
```

## Motivation

The package [ggplot2](https://ggplot2.tidyverse.org/) provides an
incredibly rich and extensive functionality for creating a variety of
plots. Let’s take the following visualization as an example:

``` r
library(ggplot2)

mtcars |> 
  ggplot(aes(x = mpg)) +
  geom_line(aes(y = wt)) +
  geom_line(aes(y = qsec)) +
  scale_y_continuous(
    name = "wt",
    sec.axis = sec_axis(~ ., name = "qsec")
  )
```

<img src="man/figures/README-ggplot-example-1.png" width="100%" />

``` r
library(daplot)

mtcars |> 
  daplot(mpg, wt, qsec, y1_label = "test label")
```

<img src="man/figures/README-example-1.png" width="100%" />
