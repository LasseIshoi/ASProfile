#' data simulation data set
#'
#'Simulation data to illustrate the function. Use with prepare_data function. This will add a several data frames to the global environment, which is used in the sa_profile function
#'
#' @format a data.frame from a raw GPS file output, which contains two relevant columns, instantaneous speed and acceleration measures.
#' \describe{
#' \item{speed}{Instantaneous sprint speed in m/s}
#' \item{acc}{instantaneous acceleration in m/s^2}
#' }
#' @source Data from a soccer training session using 10hz Catapult Vector 7
#'
"sample_data"
