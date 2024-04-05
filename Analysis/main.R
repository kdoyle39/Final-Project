## Run all code for the project

##Download Neccesary packages
source("./Renv/activate.R")

## Get raw data
source("./Data/data_download.R")

## Run Analysis
source("./Analysis/run_data.r")

## Make Figures
source("./Analysis/make_figures.R")

## Run Tests
testthat::local_edition(3)
testthat::test_dir("Tests")
