#' Create a dual axis plot using ggplot2
#'
#' Creates a ggplot2 plot with two y axes. The second y axis is scaled to match
#' the range of the first y axis.
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
daplot <- function(dat, x_val, y1_val, y2_val, y1_label = NULL, y2_label = NULL, y1_geom = ggplot2::geom_line, y2_geom = NULL, ...) {
  stopifnot(is.data.frame(dat))
  xq <- rlang::enquo(x_val)
  y1q <- rlang::enquo(y1_val)
  y2q <- rlang::enquo(y2_val)
  verify_columns(dat, xq, y1q, y2q)

  # y-labels
  if(is.null(y1_label)){
    y1_label <- rlang::as_name(rlang::enquo(y1_val))
  }
  if(is.null(y2_label)){
    y2_label <- rlang::as_name(rlang::enquo(y2_val))
  }

  if(is.null(y2_geom)){
    y2_geom <- y1_geom
  }


  # get the minimum and maximum of y1 and y2
  y1_min <- min(dat[[rlang::as_name(rlang::enquo(y1_val))]], na.rm = TRUE)
  y1_max <- max(dat[[rlang::as_name(rlang::enquo(y1_val))]], na.rm = TRUE)
  y2_min <- min(dat[[rlang::as_name(rlang::enquo(y2_val))]], na.rm = TRUE)
  y2_max <- max(dat[[rlang::as_name(rlang::enquo(y2_val))]], na.rm = TRUE)

  # Create transformation functions
  scale_factor <- (y1_max - y1_min) / (y2_max - y2_min)


  plot_dat <- dat |>
    dplyr::mutate(
      scaled_y2 = (({{y2_val}} - y2_min) * scale_factor) + y1_min
    )

  pl <- plot_dat |>
    ggplot2::ggplot(ggplot2::aes(x = {{ x_val }})) +
    y1_geom(ggplot2::aes(y = {{ y1_val }}, color = y1_label, fill = y1_label)) +
    y2_geom(ggplot2::aes(y = scaled_y2, color = y2_label, fill = y2_label)) +
    ggplot2::scale_y_continuous(
      # Features of the first axis
      name = y1_label,
      # Add a second axis and specify its features
      sec.axis = ggplot2::sec_axis(
        # inverse transformation of values for secondary y-axis
        ~ (. - y1_min)/scale_factor + y2_min,
        name = y2_label
      )
    ) +
    ggplot2::labs(color = "", fill = "")

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


# Suppress undefined global variable notes
scaled_y2 <- NULL
