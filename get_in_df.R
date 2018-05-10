rm(list=ls())

source("functions.R")
symbol_list <- read.csv("rawdata/nse_symbols.csv")

data <- get2yeardata("L&TFH")



