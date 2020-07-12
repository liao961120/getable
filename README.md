# GETable

<!-- badges: start -->
[![Support R
Version](https://img.shields.io/badge/R-≥%203.4.0-blue.svg)](https://cran.r-project.org/)
[![License:
MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
<!-- badges: end -->

**GETable** lets you insert dynamic HTML tables in R Markdown documents. "Dynamic" in the sense that the data are not hard-coded into output HTML documents but are requested from **JSON APIs** or **Google Spreadsheets** when the user visit the web page. This mean that you can update the data without recompiling the `.Rmd` document!

![GETable Demo](https://img.yongfu.name/posts/getable.gif)


## Installation

``` r
remotes::install_github("liao961120/getable")
```


## Usage

Import R Markdown template in RStudio: `File > New File > R Markdown > From Template > HTML Tables with Dynamic Data {GETable}`

Compile and Enjoy!



## Under the hood

**GETable** uses JavaScript to asynchronously request data from a web server. You can serve your data on the web,  for example, on Google Spreadsheet or on static site services such as [GitHub Pages](https://pages.github.com) and [Netlify](https://www.netlify.com).

Hosting data by yourself requires you to first convert the data into JSON formats. This is conveniently provided by the function `GETable::df2file()`:

```r
GETable::df2file(iris, "output-iris.json")
```

You can then push `output-iris.json` to a github repo and serve this file. Then, in your `.Rmd`, simply create an HTML table from the hosted `output-iris.json` by:

````rmd
```{r echo=FALSE, results='asis'}
GETable::renderTable("https://<username>.github.io/<repo>/path/to/output-iris.json")
```
````


