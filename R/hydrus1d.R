#' hydrus1d: A package for calling the Hydrus 1-D soil model
#'
#' @docType package
#' @name hydrus1d
#' @useDynLib hydrus1d, .registration=TRUE
NULL

#' hydrus1d
#'
#' A function to call the Hydrus 1-D model from R
#'
#' @export
#'
#' @examples
#'
#' hydrus1d()
#'
hydrus1d <- function(hydrus_wd) {
  # Store current working directory and restore on exit
  curr_wd <- getwd()
  on.exit(setwd(curr_wd))

  # write the hydrus working directory to LEVEL_01.DIR
  write(hydrus_wd, file.path(hydrus_wd, "LEVEL_01.DIR"))

  # set working directory to the hydrus working directory
  setwd(hydrus_wd)

  # Call Hydrus-1D
  .Call(hydrus1d_c)

}
