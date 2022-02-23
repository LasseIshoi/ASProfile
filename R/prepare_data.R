#' Prepare data
#'
#' Prepares dataframe and provide a preliminary analysis
#'
#' This function prepares the input dataframe by: filtering acc >= 0, filtering speed >= 3, creating speed bins by 0.2, and indentifying the highest two acc values in each speed bin.
#' The function outputs an initial linear regression analysis and associated scatterplot for initial data inspection.
#'
#' @param x a dataframe with two numeric columns named "speed" and "acc". speed values should be m/s. If import function has been used, the columns will automatically bw named "speed" and "acc"
#' @param print_plot A logical to control if a preliminary plot is printed, by default TRUE. This plot show the initial fit of the model and may serve to determine if the quality of the GPS data sufficient.
#' @import dplyr
#' @import ggplot2
#' @import ggeasy
#' @import ggpubr
#' @export prepare_data
#' @examples prepare_data(sample_data)

prepare_data <- function(x, print_plot = TRUE) {

  data_selected <- x %>% dplyr::select(speed, acc)

  AS_data <- data_selected %>% dplyr::filter(acc >= 0)

  gps_data_filtered <- AS_data %>% dplyr::filter(speed > 3)

  gps_data_filtered$cuts <- cut(gps_data_filtered$speed,
                                seq(3.00, max(gps_data_filtered$speed, na.rm = FALSE),
                                    by = 0.2))

  as_insitu_initial_lm <- gps_data_filtered %>%
    arrange(desc(acc)) %>%
    group_by(cuts) %>%
    top_n(2, acc)

  as_insitu_initial_lm_df <- as.data.frame(as_insitu_initial_lm)

  .GlobalEnv$as_insitu_initial_lm <- as_insitu_initial_lm_df

  if(print_plot) {

  reduced_data_prepare <- AS_data[-sample(1:nrow(AS_data), (nrow(AS_data)*0.95)), ]

  as_plot_initial <- ggplot() +
    geom_point(reduced_data_prepare, mapping = aes(speed, acc), alpha = 0.1, size = 0.5) +
    geom_point(as_insitu_initial_lm_df, mapping = aes(speed, acc, color = "red1"), size = 3) +
    geom_smooth(data = as_insitu_initial_lm_df, aes(speed, acc), method="lm") +
    ggpubr::theme_pubr() +
    ggeasy::easy_remove_legend() +
    coord_cartesian(expand = FALSE) +
    ggplot2::ggtitle("Preliminary AS profile before removing observations outside the 95% CI of \n the regression line")
  ylim(0, NA)


  .GlobalEnv$as_plot_initial <- as_plot_initial

  print(as_plot_initial)

  }

  .GlobalEnv$AS_data <- AS_data


}
