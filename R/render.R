#' Render HTML Table in R Markdown with Data from Web
#'
#' This function is expected to work with \code{getable}'s R Markdown
#' template, which contains an \code{.html} file, a \code{.js} file,
#' and a \code{.css} file in addition to the \code{.Rmd} source file.
#' The function creates an HTML string and insert it into the HTML file
#' rendered from Rmd. The code in the \code{.js} file then process the
#' HTML string and retrieve data from web to create an HTML table dynamically
#' when users view the rendered HTML file in the browser (a server is needed to
#' served the file).
#'
#' @param url A string. The URL to the source data of the table to be
#'   created. Could be a relative path (relative to the \code{.Rmd} src
#'   file) or an URL to a JSON or CSV file. \code{url} could also be an URL
#'   to a publicly viewable Google Spreadsheet. Defaults to \code{./data/df.csv}
#'   (see the template's structure).
#' @param isjson Boolean. Whether the format of the self-hosted file is
#'   json. Defaults to \code{FALSE}. Works only when the data is self-hosted
#'   (i.e. not from Google Spreadsheet).
#' @return A string representing an HTML div tag.
#' @examples
#' renderTable("https://raw.githubusercontent.com/liao961120/getable/master/docs/demo/data/df.csv")
#' @export
renderTable <- function(url="./data/df.csv", isjson=FALSE) {

  # Update counter
  .pkgenv[['dataFromWebCounter']] <- 1 + .pkgenv[['dataFromWebCounter']]

  # div id for table
  id <- paste0('data-from-web-', .pkgenv[['dataFromWebCounter']])

  # Parse as google spreadsheet
  if (grepl('docs.google.com/spreadsheets/d/', url, fixed = T)) {
    pat <- 'docs.google.com/spreadsheets/d/([a-zA-Z0-9_-]+).*'
    parseURL <- regmatches(url, regexec(pat, url))[[1]]
    if (length(parseURL) == 0)
      stop("Invalid Google sheet URL")
    gid <- parseURL[2]
    url <- paste0('https://docs.google.com/spreadsheets/d/',
                  gid, '/export?format=tsv')

    html <- paste0('<div id="', id, '" data-url="', url,
                   '" class="data-from-web-gsheet df-from-web"></div>')

  # Parse as JSON
  } else if (grepl('.json', url, fixed = T) || isjson) {
    html <- paste0('<div id="', id, '" data-url="', url,
                   '" class="data-from-web-json df-from-web"></div>')
  # Parse as CSV (auto-detect delimiter)
  } else {
    html <- paste0('<div id="', id, '" data-url="', url,
                   '" class="data-from-web-csv df-from-web"></div>')
  }

  # Render table on R Markdown
  class(html) <- 'getable.html.tag'
  return(html)
}



#' Build URL to a file from GitHub Repository
#'
#' This function builds a URL in the form:
#' \code{https://raw.githubusercontent.com/<username>/<repo>/<branch>/<path>}.
#'
#' @param username A string. The owner of the repo.
#' @param repo A string. The name of the repo.
#' @param branch A string. The branch the file is on.
#' @param path A string. The path to the file.
#' @return An URL to the path.
#' @examples
#' from_repo(
#'     username = "liao961120",
#'     repo = "getable",
#'     path = "docs/demo/data/df.json",
#'     branch = "master")
#' renderTable(
#'   from_repo(
#'     username = "liao961120",
#'     repo = "getable",
#'     path = "docs/demo/data/df.json",
#'     branch = "master")
#' )
#' @export
from_repo <- function(username, repo, path, branch='master') {
  paste('https://raw.githubusercontent.com',
        trimws(username, whitespace = "[\t\r\n/]"),
        trimws(repo, whitespace = "[\t\r\n/]"),
        trimws(branch, whitespace = "[\t\r\n/]"),
        trimws(path, whitespace = "[\t\r\n/]"),
        sep='/')
}


#' Convert Data Frame to Valid JSON Format for Serving
#'
#' @param df A data frame.
#' @param output A string. The path to the exported data frame.
#' @param ... Additional arguments arguments passed on to
#'   \link[jsonlite]{toJSON}.
#' @export
df2json <- function(df, output = "./data/df.json", ...) {
  writeLines(jsonlite::toJSON(df, dataframe = "rows", ...), output)
}


#' @importFrom knitr asis_output knit_print
#' @export
knit_print.getable.html.tag <- function(x, ...) {
    structure(x, class = 'knit_asis')
}
registerS3method("knit_print", "getable.html.tag", knit_print.getable.html.tag)
