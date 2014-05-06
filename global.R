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

## FOR COLD TEMPS
breaks.cold<-(c(0,2,4,6,8,10,12,14)) # for color scale
palette.cold<-c("black","dark blue","blue","light blue","darkgreen","green","yellow","orange")

## STANDARD 1
breaks<-(c(3,6,9,12,15,18,21,24,27)) 
palette<-c("midnightblue","blue","deepskyblue2",
           "green4","green","yellow","orange","red","darkviolet") # orange orangered brown4

## STANDARD 2
breaks.4<-(c(0,4,8,12,16,20,24,28)) 
palette.4<-c("dark blue","blue","light blue","green","yellow","orange","orangered","brown4")


## FOR WARMER TEMPS
breaks.warm<-(c(0,4,8,12,16,20,24,28,32,36)) # for color scale
palette.warm<-c("dark blue","blue","light blue","green","yellow","orange","orangered","darkred","maroon","gray40","gray5")

# load data
load("2011-2013_solinst_mainstem_hourly_compensated.RData")
load("2011-2013_solinst_mainstem_daily_compensated.RData")
