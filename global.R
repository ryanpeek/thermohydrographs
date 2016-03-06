## SHINY API: Thermohydrographs

# load packages
library(shiny)
library(lubridate)
library(grid)
library(scales)
library(ggplot2)
library(dplyr)
library(caTools) # for 7 day means
library(maptools)
library(leaflet)
library(rgdal)
library(markdown)
library(knitr)

# CREATE COLORS & SCALES FOR THERMOHYDROGRAPHS ----------------------------

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


# LOAD DATA ---------------------------------------------------------------

load("2011-2015_solinst_mainstem_hourly_compensated.rda")

# load water year day, water year functions
source("doy.R")
hrly <- add_WYD(hrly2, "Datetime")  # add DOY, WY, WYD cols

## remove old cols and re-add/rename:
hrly<-select(hrly, Datetime:WY, DOY, DOWY, grp) %>% as.data.frame()

# convert to numeric from list
hrly[,c("WY","DOY","DOWY")]<-apply(hrly[,c("WY","DOY","DOWY")], 2,FUN =  as.numeric)

# make a daily "Datetime" category
# daily$Datetime<-as.POSIXct(strptime(paste0(daily$year,"-",daily$mon,"-",daily$yday),format="%Y-%m-%j"))

# MAKE DAILY W DPLYR ------------------------------------------------------

daily<- hrly %>%
  group_by(site,year, DOY, DOWY, WY, mon)%>%
  summarize("temp.avg"=mean(Temperature,na.rm=TRUE),
            "temp.sd"= sd(Temperature,na.rm=TRUE),
            "temp.cv"= (temp.sd/temp.avg),
            "temp.min"=min(Temperature,na.rm=TRUE),
            "temp.max"=max(Temperature,na.rm=TRUE),
            "temp.rng" = (max(Temperature)-min(Temperature)),
            "lev.avg"=mean(Level,na.rm=TRUE),
            "lev.sd"= sd(Level,na.rm=TRUE),
            "lev.cv"= (lev.sd/lev.avg),
            "lev.min"=min(Level,na.rm=TRUE),
            "lev.max"=max(Level,na.rm=TRUE))%>%
  transform("lev.delt" = (lag(lev.avg)-lev.avg)/lev.avg,
            "temp.7.avg"= runmean(temp.avg, k=7, endrule="mean",align="center"),
            "temp.7.avg_L"= runmean(temp.avg, k=7, endrule="mean",align="left"),
            "lev.7.avg"= runmean(lev.avg, k=7, endrule="mean",align="center")) %>%
  mutate("Datetime" = as.POSIXct(strptime(paste0(year,"-", mon,"-", DOY), format="%Y-%m-%j")))


daily<-df
