![InSituASProfile](https://user-images.githubusercontent.com/98103290/153732197-a9744cff-857e-40d2-bfcc-05ecba893076.png)


<!-- README.md is generated from README.Rmd. Please edit that file -->

# InSituASProfile

<!-- badges: start -->
<!-- badges: end -->

The goal of InSituASProfile is to provide an easy way to calculate the
insitu sprint acceleration-speed profile based on gps data using the
method described by Morin et al. 2021 published in Journal of
Biomechanics, DOI: 10.1016/j.jbiomech.2021.110524

## Installation

You can install the development version of InSituASProfile from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("LasseIshoi/ASProfile")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(InSituASProfile)

# Import data (csv files) from folder and combine in single data frame for analysis.  
InSituASProfile::import_data("C:/Users/lasse/OneDrive/skrivebord/gps_data", Velocity, Acceleration)

# Prepare data. This step cleans the data frame by 1) omitting all acceleration
values below 0, 2) identify the two highest acceleration values for every 
consecutive 0.2 m/s cut starting from 3 m/s, and 3) create an initial regression
line and associated preliminary plot (if not FALSE) 
InSituASProfile::prepare_data(data_import, print_plot = TRUE)

# Calculate the A-S Profile. This step uses the data exported from prepare_data,
and to calculate the A-S Profile. It plots the A-S Profile as default (TRUE), 
while a plot showing the regression line is not printed by default (FALSE).
InSituASProfile::get_AS_Profile(print_plot_regression_line = FALSE, print_AS_plot = TRUE)
```
