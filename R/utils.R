#' Simplify internal use of `cat`
#' @noRd
#' @param vec
#' @param sep
#'
#' @return
#' @export
#'
#' @examples
cat_wrapper <- function(vec, sep = " ") {
  res <- capture.output(cat(vec, sep = sep))
}

input_warn <- function(w, about, tab, from) {
  warning(glue("A warning occurred in {from} when assessing the provided {about}:"))
  print(w)
  if (is.data.table(tab)) {
    warning(glue("A data.table was still returned from {from} and will be processed."))
    return(tab)
  } else {
    instead <- class(tab)[length(class(tab))]
    warning(glue("Instead, {from} returned {instead}. Input discarded."))
    return(NULL)
  }
}

input_err <- function(err, about, from) {
  warning(glue("An error occurred in {from} when assessing the provided {about}:"))
  print(err)
  return(NULL)
}

#' Determine if `in.file` input is usable
#' @noRd
#' @param file
#' @param has.rownames
#'
#' @return
#' @export
#'
#' @examples
check_is_file <- function(file,
                          has.rownames = FALSE,
                          nrows = 10000,
                          use.sample = FALSE) {
  tryCatch({
    if (isFALSE(use.sample)) {
      tab <- fread(file = file, nrows = nrows)
      return(tab)
    } else {
      tab <- fread(file = file)
      len <- nrow(tab)
      tab <- tab[sample(x = (len), size = (nrows)), ]
      return(tab)
    }
  }, error = function(e) {
    input_err(err = e, about = "file",
              from = "data.table::fread")
  }, warning = function(w) {
    input_warn(warn = w, about = "file", tab = tab,
               from = "data.table::fread")
  }
  )
}

#' Determine if `in.table` input is usable
#' @noRd
#' @param tab
#'
#' @return
#' @export
#'
#' @examples
check_is_table <- function(tab,
                           has.rownames = FALSE,
                           nrows = 10000,
                           use.sample = FALSE) {
  tryCatch({
    given <- class(tab)[length(class(tab))]
    about <- glue("table input (of {given})")
    if (is.data.frame(tab)) {
      from <- "data.table::setDT"
      setDT(tab, keep.rownames = has.rownames)
      return(tab)
    } else {
      from <- "data.table::as.data.table"
      tab <- as.data.table(tab, keep.rownames = has.rownames)
      return(tab)
    }
  }, error = function(e) {
    input_err(err = e, about = about,
              from = from)
  }, warning = function(w) {
    input_warn(warn = w, about = about, tab = tab,
               from = from)
  })
}

#' Get basic information
#' @noRd
#' @param dt
#'
#' @return
#' @export
#'
#' @examples
check_basics <- function(dt) {
  col_names <- colnames(dt)
  col_classes <- sapply(dt, class)
  res <- data.frame(cols = col_names, classes = col_classes)
}

#' Check a column for unique values
#' @noRd
#' @param vec
#' @param limit
#' @param sep
#'
#' @return
#' @export
#'
#' @examples
check_uniques <- function(vec, limit = 25, sep = " ||| ") {
  un <- unique(vec)
  len <- length(vec)
  unlen <- length(un)
  if (unlen == 0 || (unlen == 1 && is.na(un))) {
    res <- "No values found in this column."
  } else if (len == unlen) {
    res <- glue("All {len} values inspected are unique.")
  } else {
    res <- glue("{unlen} of {len} values inspected are unique.")
  }
  if (unlen <= limit && limit > 0) {
    uniques <- cat_wrapper(un, sep = sep)
    res <- cat_wrapper(c(res, uniques), sep = "\n")
  }
  res
}


