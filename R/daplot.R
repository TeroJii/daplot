#' Title
#'
#' @param dat input data frame
#' @param x_val a column name in dat for x axis.
#' @param y1_val a column name in dat for y1 axis.
#' @param y2_val a column name in dat for y2 axis.
#' @param y1_label an optional label for y1 axis. The column name for y1_val is
#' used if not provided.
#' @param y2_label an optional label for y2 axis. The column name for y2_val is
#' used if not provided.
#' @returns returns a ggplot object
#' @export
#'
#' @examples
#' mtcars |> daplot(mpg, wt, qsec)
daplot <- function(dat, x_val, y1_val, y2_val, y1_label = NULL, y2_label = NULL) {
  stopifnot(is.data.frame(dat))
  xq <- rlang::enquo(x_val)
  y1q <- rlang::enquo(y1_val)
  y2q <- rlang::enquo(y2_val)
  verify_columns(dat, xq, y1q, y2q)

  plot_dat <- dat

  pl <- plot_dat |>
    ggplot2::ggplot(ggplot2::aes(x = {{ x_val }})) +
    ggplot2::geom_line(ggplot2::aes(y = {{ y1_val }}, color = "y1")) +
    ggplot2::geom_line(ggplot2::aes(y = {{ y2_val }}, color = "y2"))

  return(pl)
}



# Helper fuctions
verify_columns <- function(dat, xq, y1q, y2q){
  x_col <- rlang::as_name(xq)
  y1_col <- rlang::as_name(y1q)
  y2_col <- rlang::as_name(y2q)

  if (!(x_col %in% names(dat))) {
    stop(glue::glue("Column `{x_col}` not found in `dat`."))
  }
  if (!(y1_col %in% names(dat))) {
    stop(glue::glue("Column `{y1_col}` not found in `dat`."))
  }
  if (!(y2_col %in% names(dat))) {
    stop(glue::glue("Column `{y2_col}` not found in `dat`."))
  }
}
