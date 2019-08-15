#load packages for mapping
#
library(sf)
library(raster)
library(ggplot2)
library(dplyr)
library(readxl)

#load data from excel sheet into data frame - non clean
Pm25_Point_source_df_full <- read_xlsx( "~/AQET/raw_data/NAEI_PM25PointsSources_2016.xlsx", sheet = 2)

#Load subset of full data
Pm25_Point_source_df <- Pm25_Point_source_df_full[,c(3,5,6,7,8,11,12)]

#make uk map

#plot emission sources on map



