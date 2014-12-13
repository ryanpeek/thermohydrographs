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
library(dplyr)
library(caTools) # for 7 day means

# create colors and scale for thermohydrograph

## FOR COLD TEMPS
breaks.cold<-(c(0,2,4,6,8,10,12,14)) # for color scale
palette.cold<-c("black","dark blue","blue","light blue","darkgreen","green","yellow","orange")

## STANDARD 1
breaks<-(c(0,3,6,9,12,15,18,21,24,27,30)) 
palette<-c("black","midnightblue","blue","deepskyblue2",
           "green4","green","yellow","orange","red","darkviolet", "maroon") # orange orangered brown4

## STANDARD 2
breaks.4<-(c(0,4,8,12,16,20,24,28)) 
palette.4<-c("dark blue","blue","light blue","green","yellow","orange","orangered","brown4")


## FOR WARMER TEMPS
breaks.warm<-(c(0,4,8,12,16,20,24,28,32,36)) # for color scale
palette.warm<-c("dark blue","blue","light blue","green","yellow","orange","orangered","darkred","maroon","gray40","gray5")

# load data
load("2011-2014_solinst_mainstem_hourly_compensated.RData")
#load("2011-2013_solinst_mainstem_hourly_compensated.RData")
load("2011-2014_solinst_mainstem_daily_compensated.RData")

## make a daily "Datetime" category
daily$Datetime<-as.POSIXct(strptime(paste0(daily$year,"-",daily$mon,"-",daily$yday),format="%Y-%m-%j"))

# MAKE DAILY W DPLYR ------------------------------------------------------
# df<- hrly %>%
#   group_by(site,year,yday,mon)%>%
#   summarize("temp.avg"=mean(Temperature,na.rm=TRUE),
#             "temp.sd"= sd(Temperature,na.rm=TRUE),
#             "temp.cv"= (temp.sd/temp.avg),
#             "temp.min"=min(Temperature,na.rm=TRUE),
#             "temp.max"=max(Temperature,na.rm=TRUE),
#             "temp.rng" = (max(Temperature)-min(Temperature)),
#             "lev.avg"=mean(Level,na.rm=TRUE),
#             "lev.sd"= sd(Level,na.rm=TRUE),
#             "lev.cv"= (lev.sd/lev.avg),
#             "lev.min"=min(Level,na.rm=TRUE),
#             "lev.max"=max(Level,na.rm=TRUE))%>%
#   transform("lev.delt" = (lag(lev.avg)-lev.avg)/lev.avg,
#             "temp.7.avg"= runmean(temp.avg, k=7, endrule="mean",align="center"),
#             "temp.7.avg_L"= runmean(temp.avg, k=7, endrule="mean",align="left"),
#             "lev.7.avg"= runmean(lev.avg, k=7, endrule="mean",align="center"))#%>%
# 
# filter(mon>3, mon<8)
# s(df)
# daily<-df
