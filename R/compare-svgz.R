# functions for testthat compare

#' Read an SVG file that may be compressed
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

#' 
compare_file_text_svg <- function(old, new) {
  old <- read_svg(old)
  new <- read_svg(new)
  identical(old, new)
}