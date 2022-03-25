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
hydrus1d <- function() {
  .Call(hydrus1d_c)
}
