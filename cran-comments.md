## Resubmission
This is a resubmission. In this version I have:

* Remove the code that changes the user's options.

* Use package-global environment instead of 
  the user's options to store variables used in
  the package.


## Test environments
- ubuntu 18.04 (local), R 3.6.3
- win-builder (devel: 2020-08-10 r79000 and 
  release: R version 4.0.2)

## R CMD check results
There were 1 NOTE on win-builder:
  * checking CRAN incoming feasibility ... NOTE
  Maintainer: 'Yongfu Liao <liao961120@gmail.com>'
  
  New submission
  
  Possibly mis-spelled words in DESCRIPTION:
    Onload (3:31)

The possibly mis-spelled word "Onload" is correct.


## Reverse Dependency Check
No ERRORs or WARNINGs found
