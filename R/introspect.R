#' Title
#'
#' @description
#'
#'
#' @details
#'
#'
#' @param in.file String: file path leading to a CSV you want to evaluate, ending in `.csv`.
#'    Can be either absolute or relative to your current working directory.
#' @param in.table A data.frame, tibble, data.table, or other input which can
#'    be coerced to such a format. Provide one of `file` or `table`, not both.
#' @param to.out String: name or file path for the output file, ending in `.md` or `.txt`.
#'    Defaults to writing `introspector_findings.md` to the working directory.
#'    Unless `verbose = TRUE`, must not be null.
#' @param nrows Numeric: maximum number of rows to use from the input while evaluating.
#'    Defaults to 10,000; set to Inf or NULL for no ceiling.
#' @param limit Numeric: maximum number of unique values to reproduce verbatim when
#'    identifying foreign key candidate columns. Defaults to 25; set to 0 to turn off.
#' @param sep String: separator to distinguish unique values when reproduced verbatim.
#'    Defaults to ` ||| `. Unused when `limit` is zero.
#' @param use.sample Experimental. Boolean: reads the entire input before selecting a
#'    random subset of its contents. Defaults to `FALSE`. May cause performance issues.
#' @param progress Experimental. Boolean: logs progress updates in the console. Default `FALSE`.
#' @param verbose Boolean: write the `inspect()` output to the console?
#'    Default `FALSE`. Must be `TRUE` if `out` is null.
#' @param has.rownames Experimental. Boolean: assume the input has a column of row names to keep?
#'    Default `FALSE`.
#' @return Silently writes to the output file.
#'    Optionally, duplicate or substitute that output in the console/stdout
#'    with `verbose = TRUE`.
#' @export
#'
#' @examples
introspect <- function(in.file = NULL,
                    in.table = NULL,
                    out = "introspector_findings.md",
                    nrows = 10000,
                    limit = 25,
                    sep = " ||| ",
                    use.sample = FALSE,
                    progress = FALSE,
                    verbose = FALSE,
                    has.rownames = FALSE) {
  if ((!is.character(out) || length(out) <= 3) && isFALSE(verbose)) {
    stop() #stop if there's no viable way to register the output
  }
  if (is.null(list(in.file, in.table))) {
    stop() #stop if there's nothing to examine
  }

  if (!is.numeric(limit)) {
    limit <- 25 #proceed with default value
    warning() #warn that a non-numeric limit has been received and discarded
  }
  if (!is.numeric(nrows)) {
    nrows <- 10000 #proceed with the default value
    warning() #warn that a non-numeric nrows has been received and discarded
  }
}

#' @describeIn introspect Introspect a CSV file.
introspect_csv <- function(file = NULL,
                        out = "introspector_findings.md",
                        nrows = 10000,
                        limit = 25,
                        use.sample = FALSE,
                        progress = FALSE,
                        verbose = FALSE) {

}

#' @describeIn introspect Introspect a data.frame, data.table, or tibble.
introspect_table <- function(table = NULL,
                          out = "introspector_findings.md",
                          nrows = 10000,
                          limit = 25,
                          use.sampling = FALSE,
                          progress = FALSE,
                          verbose = FALSE) {

}
