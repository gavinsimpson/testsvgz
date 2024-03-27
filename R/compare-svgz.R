#' Read an SVG file that may be compressed
#'
#' @param f character; path to SVG file to be read.
#'
#' @returns A character vector of length the number of lines read.
#'
#' @export
#' @importFrom tools file_ext
read_svg <- function(f) {
  f <- if (identical(tools::file_ext(f), "svgz")) {
    fc <- gzfile(f)
    on.exit(close(fc))
    base::readLines(fc)
  } else {
    base::readLines(f)
  }
  f
}

#' Compare an SVG file that may be compressed
#'
#' @param old character; path to SVG file to be used as reference
#' @param new character; path to SVG file to compare with `old`
#'
#' @returns A logical vector of length 1.
#'
#' @export
compare_file_text_svg <- function(old, new) {
  old <- read_svg(old)
  new <- read_svg(new)
  identical(old, new)
}
