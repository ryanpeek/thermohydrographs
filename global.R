## SHINY API: Thermohydrographs

library(shiny)
pkgs <- c("lubridate","grid","scales","ggplot2") # list packages

# install packages
pkgs <- pkgs[!(pkgs %in% installed.packages()[,"Package"])]
if(length(pkgs)) install.packages(pkgs,repos="http://cran.cs.wwu.edu/")
library(lubridate)
library(grid)
library(scales)
library(ggplot2)

# create colors and scale for thermohydrograph
breaks<-(c(0,4,8,12,16,20,24,28)) 
palette<-c("dark blue","blue","light blue","green","yellow","orange","orangered","brown4")

# load data
load("2011-2013_solinst_mainstem_hourly_compensated.RData")
load("2011-2013_solinst_mainstem_daily_compensated.RData")
