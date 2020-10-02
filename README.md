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

`getable` is now on CRAN, which can be installed with:

```r
install.packages("getable")
```

or, install the latest version from GitHub:

```r
remotes::install_github("liao961120/getable")
```


## Usage

`getable` comes with a template that you can import in RStudio by selecting: `File > New File > R Markdown > From Template > HTML Tables with Dynamic Data {GETable}`.

Or, you can simply run the command below in the R console:

```r
rmarkdown::draft("name_your_file.Rmd", template = "tablefromweb", package = "getable")
```

The template contains several files, of which `dfFromWeb.html`, `dfFromWeb.js`, and `dfFromWeb.css` are required for the compiled HTML to work properly (DO NOT change the RELATIVE PATHs between these files and the source Rmd). Note that you can style the appearance of the HTML tables with CSS in `dfFromWeb.css`, and if you know a lot about JS, you can even modify the code in `dfFromWeb.js` to use other JS libraries to generate the HTML tables. You can see a working example [here](https://yongfu.name/getable/demo/).


### Inserting Tables

Simply use the function `renderTable("<URL>")` in a code chunk to insert a dynamic HTML table:

````rmd
---
title: "Inserting dynamic HTML tables"
output: 
  html_document:
    includes:
      in_header: dfFromWeb.html  # Needed to work properly
---

```{r}
getable::renderTable("https://yongfu.name/getable/demo/data/df.csv")
```
````


## Under the hood

**GETable** uses JavaScript to asynchronously request data from a web server. You can host your data on the web, for example, in a [Google Spreadsheet](https://docs.google.com/spreadsheets/d/1KV8XOlBcax3gca5s6Wl7M06nVrpui39hHGXDv-K6gM8), in a [GitHub repo](https://github.com/liao961120/getable/blob/master/inst/rmarkdown/templates/tablefromweb/skeleton/data/df.json), or on static site services such as [GitHub Pages](https://pages.github.com) and [Netlify](https://www.netlify.com).

