#' Import data
#'
#' Import csv files from folder and combine in dataframe
#'
#' This function imports csv files from folder and combine them into a dataframe.
#'
#' @param file_directory path to folder as character string
#' @param Velocity name of the velocity column, by default "Velocity"
#' @param Acceleration name of the acceleration column, by default "Acceleration"
#' @import dplyr
#' @import readr
#' @export import_data


import_data <- function(file_directory, Velocity, Acceleration) {
  list_files <-  list.files(file_directory, pattern = "*.csv", full.names = TRUE)

  data <- lapply(list_files, read_csv) %>% dplyr::bind_rows()


  data_import <- dplyr::rename(data, speed = Velocity,
                               acc = Acceleration)


  .GlobalEnv$data_import <- data_import

}

