library("ggplot2")

test_that("can compare svg with svgz", {
  local_edition(3)

  # create objects & functions
  set.seed(1)
  df <- data.frame(x = rnorm(500), y = rnorm(500))
  # To use expect_snapshot_file() you'll typically need to start by writing
  # a helper function that creates a file from your code, returning a path
  save_svg <- function(code, compress = FALSE, width = 10, height = 8, ...) {
    extn <- ifelse(compress, ".svgz", ".svg")
    path <- tempfile(fileext = extn)
    svglite::svglite(path, width = width, height = height, ...)
    on.exit(dev.off())
    code

    path
  }

  # tests
  expect_snapshot_file(
    save_svg(plot(1:10), compress = TRUE),
    name = "svg-with-10-points.svgz",
    compare = compare_file_text_svg
  )

  expect_snapshot_file(
    save_svg(plot(1:5), compress = TRUE),
    name = "svg-with-10-points-again.svgz",
    compare = compare_file_text_svg
  )

  expect_snapshot_file(
    save_svg(plot(1:10), compress = FALSE),
    name = "svg-with-10-points.svg",
    compare = compare_file_text_svg
  )

  expect_snapshot_file(
    save_svg(
      print(
        df |> ggplot(aes(x = x, y = y)) + geom_point()
      ),
      compress = TRUE),
    name = "svg-ggplot-with-500-points.svgz",
    compare = compare_file_text_svg
  )

  expect_snapshot_file(
    save_svg(
      print(
        df |> ggplot(aes(x = x, y = y)) + geom_point()
      ),
      compress = FALSE),
    name = "svg-with-500-points.svg",
    compare = compare_file_text_svg
  )

  expect_snapshot_file(
    save_svg(
      print(
        df[1:40, ] |> ggplot(aes(x = x, y = y)) + geom_point()
      ),
      compress = TRUE),
    name = "svg-with-500-points-again.svgz",
    compare = compare_file_text_svg
  )

}
)
