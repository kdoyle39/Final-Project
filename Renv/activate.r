##the project directory
project <- getwd()

library(renv)
library(tidyr)
install.packages("WDI")
library(WDI)
library(tidyverse)
library(readxl) #for excel files
install.packages("devtools")
devtools::install_github("WIDworld/wid-r-tool")
library(wid)
library(dplyr)
install.packages("testthat")
library(testthat)
library(dplyr)
library(tidyr)
library(ggplot2)
