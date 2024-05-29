
<!-- README.md is generated from README.Rmd. Please edit that file -->

# InSituASProfile

<!-- badges: start -->
<!-- badges: end -->

The goal of InSituASProfile is to provide an easy way to calculate the
insitu sprint acceleration-speed profile based on gps data from the
concept described by Morin et al. 2021 published in Journal of
Biomechanics, DOI: 10.1016/j.jbiomech.2021.110524

## Installation

You can install the development version of InSituASProfile from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("LasseIshoi/ASProfile")
```

## Example

This is a basic example of how to use the InSituASProfile Package:

Import data (csv files) from folder and combine in single data frame for
analysis.

``` r
library(InSituASProfile)

library(here)
#> here() starts at C:/Users/lasse/OneDrive/Documents/R/Packages/ASProfile

InSituASProfile::import_data(here("./data/"), "speed", "acc")
#> Rows: 58871 Columns: 10
#> ── Column specification ────────────────────────────────────────────────────────
#> Delimiter: ","
#> dbl (10): speed, acc, Odometer, Latitude, Longitude, Heart Rate, Player Load...
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

## Prepare data

This step cleans the data frame by 1) omitting all acceleration values
below 0, 2) identify the two highest acceleration values for every
consecutive 0.2 m/s cut starting from 3 m/s, and 3) create an initial
regression line and associated preliminary plot (if not FALSE)

``` r

InSituASProfile::prepare_data(data_import, print_plot = TRUE)
#> `geom_smooth()` using formula = 'y ~ x'
```

<img src="man/figures/logo.pngprepare data-1.png" width="100%" />

## Calculate the AS Profile

Calculate the A-S Profile. This step uses the data exported from
prepare_data, and to calculate the A-S Profile. It plots the A-S Profile
as default (TRUE), while a plot showing the regression line is not
printed by default (FALSE).

``` r

InSituASProfile::get_AS_Profile(print_plot_regression_line = FALSE, print_AS_plot = TRUE)
```

<img src="man/figures/logo.pngcalculate AS Profile-1.png" width="100%" />
