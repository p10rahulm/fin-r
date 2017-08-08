rm(list=ls())

source("functions.R")
symbol_list <- read.csv("rawdata/nse_symbols.csv")

data <- get2yeardata("RELIANCE")
data$risege1pct <- (data$Close.Price-data$Open.Price)/data$Open.Price > 0.01
data$window.max.30 <- running_window_function(data$Close.Price,30,T)
data$window.max.30 <- running_window_function(data$Close.Price,30,T)
data$window.max.30 <- running_window_function(data$Close.Price,30,T)
data$window.max.30 <- running_window_function(data$Close.Price,30,T)
data$window.max.30 <- running_window_function(data$Close.Price,30,T)


