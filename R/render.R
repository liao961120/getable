#' Render HTML Table in R Markdown with Data from Web
#'
#' This function is expected to work with \code{GETable}'s R Markdown
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
#'   file) or an URL to a JSON file. \code{url} could also be an URL to
#'   a public Google Spreadsheet. Defaults to \code{./data/df.json} (see
#'   the template's structure).
#' @return A string representing an HTML div tag.
#' @export
renderTable <- function(url="./data/df.json") {

  # Update counter
  if (is.null(options()[['dataFromWebCounter']]))
    options('dataFromWebCounter' = 1)
  else
    options('dataFromWebCounter' = 1 + options()[['dataFromWebCounter']])

  # div id for table
  id <- paste0('data-from-web-', options()[['dataFromWebCounter']])

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
  } else {
    html <- paste0('<div id="', id, '" data-url="', url,
                   '" class="data-from-web-json df-from-web"></div>')
  }

  # Render table on R Markdown
  cat(html)
  return(invisible(html))
}


#' Convert Data Frame to Valid JSON Format for Serving
#'
#' @param df A data frame.
#' @param output A string. The path to the exported data frame.
#' @param ... Additional arguments arguments passed on to
#'   \link[jsonlite]{toJSON()}.
#' @export
df2file <- function(df, output = "./data/df.json", ...) {
  writeLines(jsonlite::toJSON(df, dataframe = "rows", ...), output)
}





