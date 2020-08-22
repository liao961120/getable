.pkgenv <- new.env(parent = emptyenv())

.onLoad <- function(libname, pkgname) {
  .pkgenv[['dataFromWebCounter']] <- 0
}
