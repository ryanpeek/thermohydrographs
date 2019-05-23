## SHINY API: Thermohydrographs

# load packages
library(shiny)
library(lubridate) # time manipulation
library(scales) # better scales 
library(grid) # don't remember
library(ggplot2) # plotting
library(dplyr) # everything
library(caTools) # for 7 day means
library(leaflet) # making a dynamic map
library(viridis)

# widgets 
# if(!require("htmlwidgets")) {install.packages("htmlwidgets", lib="/Rpackages/")}
# library(htmlwidgets, lib.loc="/Rpackages/")
# 
# # spatial 
# if(!require("sf")) {install.packages("sf", lib="/Rpackages/")}
# library(sf, lib.loc="/Rpackages/")

library(sf) # for shapefiles
library(markdown)
library(knitr)

source("f_doy.R") # function to make water year calendar

# CREATE COLORS & SCALES FOR THERMOHYDROGRAPHS ----------------------------

## STANDARD 1
breaks<-seq(0,30,3) 
palette<-c("black","midnightblue","blue","deepskyblue2",
           "green4","green","yellow","orange","red","darkviolet", "maroon") # orange orangered brown4


# LOAD DATA ---------------------------------------------------------------
load("2011_2018_solinst_hourly_master.rda")

load("daily_flow_cfs_data_6sites.rda") 
flowdf <- flowdf %>%
  mutate("flow_cms"=flow_cfs*0.028316847)

#load("2011-2015_solinst_mainstem_hourly_compensated.rda")

hrly  <- master_updated # rename to simple name

# TEST PLOTS --------------------------------------------------------------
# 
# # compensated/adj STAGE:
# ggplot() +
#   geom_line(data=hrly,
#             aes(x=datetime, y=level_comp, color=site, group=WY)) +
#   facet_grid(site~., scales="free")
# 
# # uncompensated/adj STAGE:
# ggplot() + 
#   geom_line(data=hr.df2, 
#             aes(x=datetime, y=level, color=site, group=WY)) +
#   facet_grid(site~., scales="free")
# 
# # daily flow
# ggplot() + 
#   geom_line(data=flowdf[flowdf$WY>2009,], 
#             aes(x=date, y=log(flow_cfs), color=site, group=WY)) +
#   facet_grid(site~., scales="free_y")


# MAKE DAILY W DPLYR ------------------------------------------------------

# daily<- hrly %>%
#   mutate(date = floor_date(datetime, unit = "day")) %>% 
#   group_by(site, date) %>%
#   summarize("temp.avg"=mean(temp_C,na.rm=TRUE),
#             "temp.sd"= sd(temp_C,na.rm=TRUE),
#             "temp.cv"= (temp.sd/temp.avg),
#             "temp.min"=min(temp_C,na.rm=TRUE),
#             "temp.max"=max(temp_C,na.rm=TRUE),
#             "temp.rng" = (max(temp_C)-min(temp_C)),
#             "lev.avg"=mean(level_comp,na.rm=TRUE),
#             "lev.sd"= sd(level_comp,na.rm=TRUE),
#             "lev.cv"= (lev.sd/lev.avg),
#             "lev.min"=min(level_comp,na.rm=TRUE),
#             "lev.max"=max(level_comp,na.rm=TRUE))%>%
#   transform("lev.delt" = (lag(lev.avg)-lev.avg)/lev.avg,
#             "temp.7.avg"= runmean(temp.avg, k=7, endrule="mean",align="left"),
#             "temp.7.avg_L"= runmean(temp.avg, k=7, endrule="mean",align="left"),
#             "lev.7.avg"= runmean(lev.avg, k=7, endrule="mean",align="left")) %>%
#   add_WYD(., "date")

load("2011_2018_solinst_daily_master.rda")
daily <- master_daily

# QUICK PLOT --------------------------------------------------------------

# daily stage
#ggplot(daily) + geom_line(aes(date, lev.avg, group=WY, color=site)) + viridis::scale_color_viridis(discrete = T) + facet_grid(site~.)


# daily flow
# ggplot(flowdf[flowdf$WY>2010,]) + geom_line(aes(date, flow_cms+1, color=site)) + viridis::scale_color_viridis("Site", discrete = T) + facet_grid(site~.) + scale_y_log10() + ylab("Log(Flow) (cms)") + xlab("")

