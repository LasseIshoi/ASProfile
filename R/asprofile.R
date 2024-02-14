#' Compute acceleration-speed profile
#'
#' Computes the sprint acceleration profile using the Confidence Interval Filtering, e.g. removal of points outside of the 95 % CI of the regression line from the initial fit.
#'
#' @param print_plot_regression_line A logical to print the AS profile with regression line, by default FALSE
#' @param print_AS_plot A logical to print the AS profile as a publication ready plot, by default TRUE
#' @import dplyr
#' @import ggplot2
#' @import ggeasy
#' @import ggpubr
#' @export get_AS_Profile


get_AS_Profile <- function(print_plot_regression_line = FALSE, print_AS_plot = TRUE) {

  lm_initial <- lm(acc ~ speed, as_insitu_initial_lm)

  summary_lm_initial <- summary(lm_initial)

  .GlobalEnv$summary_lm_initial <- summary_lm_initial

  predicted_values <- predict.lm(lm_initial, newdata = as_insitu_initial_lm, interval = "confidence", level = 0.95)

  predicted_values_df <- as.data.frame( predicted_values)

  as_insitu_initial_lm_predicted <- cbind(as_insitu_initial_lm, predicted_values_df)

  as_insitu_clean <- as_insitu_initial_lm_predicted  %>%
    dplyr::filter(acc <= upr & acc >= lwr)

  .GlobalEnv$as_insitu_clean <- as_insitu_clean

  lm_as_insitu_fit <- lm(acc ~ speed, as_insitu_clean)

  summary_as <- summary(lm_as_insitu_fit)

  .GlobalEnv$summary_as <- summary_as

  r.square <- summary_as[[8]]
  a0 <- coef(lm_as_insitu_fit)[[1]]
  slope <- coef(lm_as_insitu_fit)[[2]]
  vmax <- a0/abs(slope)

  .GlobalEnv$r.square <- round(r.square,3)
  .GlobalEnv$a0 <-  round(a0,2)
  .GlobalEnv$vmax <- round(vmax,2)

  reduced_data <- AS_data[-sample(1:nrow(AS_data), (nrow(AS_data)*0.90)), ]

  x_limit <- vmax + 0.5
  y_lim <- a0 + 1

  if(print_plot_regression_line) {

  as_plot_regression <- ggplot() +
    geom_point(data = reduced_data, aes(speed, acc), color = "slategray4", alpha = 0.3, size = 0.7) +
    geom_point(data = as_insitu_clean, aes(speed, acc), color = "red", size = 3) +
    geom_smooth(data = as_insitu_clean, aes(speed, acc), method="lm") +
    ggeasy::easy_remove_legend() +
    ggpubr::theme_pubr() +
    ggplot2::ggtitle("In-situ Acceleraion speed profile (regression line)") +
    ylim(0, y_lim) +
    xlim(0, x_limit) +
    ylab(bquote("Acceleration in m/s"^2)) +
    xlab("Sprinting velocity in m/s") +
    coord_cartesian(expand = FALSE)

  .GlobalEnv$as_plot_regression <- as_plot_regression
  }

  if(print_AS_plot){

  as_plot_publish <- ggplot() +
    geom_point(data = reduced_data, aes(speed, acc), color = "slategray4", alpha = 0.3, size = 0.7) +
    geom_abline(intercept = a0, slope = slope, color = "blue", size = 2) +
    geom_point(data = as_insitu_clean, aes(speed, acc), color = "red", size = 3) +
    ggpubr::theme_pubr() +
    ggeasy::easy_remove_legend() +
    ggplot2::ggtitle("In-situ Acceleration Speed Profile") +
    ylim(0, y_lim) +
    xlim(0, x_limit) +
    ylab(bquote("Acceleration in m/s"^2)) +
    xlab("Sprinting velocity in m/s") +
    coord_cartesian(expand = FALSE) +
    geom_label(x = vmax - 4.6, y = a0 - 0.6, hjust = 0, aes(label=paste0("Max acceleration:", " ", round(a0,2), " m/s^2", "\n", "\n", "Max velocity:", " ", round(vmax,2), " m/s", "\n", "\n", "Fit (r-sqaured):", " ", round(r.square,4))))

  .GlobalEnv$as_plot_publish <- as_plot_publish

  print(as_plot_publish)
  }

  Maximal.Acceleration <- c(round(a0,2))
  Maximal.Velocity <- c(round(vmax,2))
  R.Squared <- c(round(r.square,3))
  Number.Observations <- c(count(as_insitu_clean))

  Data_summary <- data.frame(Maximal.Acceleration, Maximal.Velocity, R.Squared, Number.Observations) %>%
    rename(Number.Observations = n)

  .GlobalEnv$Data_summary  <- Data_summary

}
