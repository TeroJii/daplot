#' Title
#'
#' @param dat input data frame
#'
#' @returns returns a data frame
#' @export
#'
#' @examples
daplot <- function(dat, x_val, y1_val, y2_val, y1_label = NULL, y2_label = NULL) {
  stopifnot(is.data.frame(dat))

  # Capture column names as strings for checking
  x_col <- rlang::as_name(rlang::enquo(x_val))
  y1_col <- rlang::as_name(rlang::enquo(y1_val))
  y2_col <- rlang::as_name(rlang::enquo(y2_val))

  stopifnot(x_col %in% names(dat))
  stopifnot(y1_col %in% names(dat))
  stopifnot(y2_col %in% names(dat))


  plot_dat <- dat

  pl <- plot_dat |>
    ggplot2::ggplot(ggplot2::aes(x = {{ x_val }})) +
    ggplot2::geom_line(ggplot2::aes(y = {{ y1_val }}, color = "y1")) +
    ggplot2::geom_line(ggplot2::aes(y = {{ y2_val }}, color = "y2"))

  return(pl)
}
