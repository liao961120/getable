# GETable

<!-- badges: start -->
[![Support R
Version](https://img.shields.io/badge/R-≥%203.4.0-blue.svg)](https://cran.r-project.org/)
[![License:
MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
<!-- badges: end -->

**GETable** lets you insert dynamic HTML tables in R Markdown documents. "Dynamic" in the sense that the data are not hard-coded into output HTML documents but are requested from **Google Spreadsheets** or **hosted JSON/CSV files** when the user visit the web page. This mean that you can update the data without recompiling the `.Rmd` document!

![GETable Demo](https://img.yongfu.name/posts/getable.gif)


## Installation

``` r
remotes::install_github("liao961120/getable")
```


## Usage

[**Demo**](https://yongfu.name/getable/demo/)


### Import R Markdown Template 

1. Import R Markdown template in RStudio: `File > New File > R Markdown > From Template > HTML Tables with Dynamic Data {GETable}`.
1. Compile and Enjoy!


## Under the hood

**GETable** uses JavaScript to asynchronously request data from a web server. You can host your data on the web, for example, in a [Google Spreadsheet](https://docs.google.com/spreadsheets/d/1KV8XOlBcax3gca5s6Wl7M06nVrpui39hHGXDv-K6gM8), in a [GitHub repo](https://github.com/liao961120/getable/blob/master/inst/rmarkdown/templates/tablefromweb/skeleton/data/df.json), or on static site services such as [GitHub Pages](https://pages.github.com) and [Netlify](https://www.netlify.com).

