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
Pm25_Point_source_df <- Pm25_Point_source_df_full[,c(1,3,5,6,7,8,10,11,12)]

#convert to eastings and northings
## rename columns (redundant as columns already have correct names)
#colnames(Pm25_Point_source_df)[c(3, 4)] <- c('Easting', 'Northing')

## libraries
require(rgdal) # for spTransform
require(stringr)

### shortcuts
ukgrid <- "+init=epsg:27700"
latlong <- "+init=epsg:4326"

### Create coordinates variable
coords <- cbind(Easting = as.numeric(as.character(Pm25_Point_source_df$Easting)),
                Northing = as.numeric(as.character(Pm25_Point_source_df$Northing)))

### Create the SpatialPointsDataFrame
dat_SP <- SpatialPointsDataFrame(coords,
                                 data = Pm25_Point_source_df,
                                 proj4string = CRS("+init=epsg:27700"))

### Convert
dat_SP_LL <- spTransform(dat_SP, CRS(latlong))

## replace Lat, Long
dat_SP_LL@data$Long <- coordinates(dat_SP_LL)[, 1]
dat_SP_LL@data$Lat <- coordinates(dat_SP_LL)[, 2]

## optionally write out as shapefile
# Error:proj_create: init=epsg:/init=IGNF: syntax not supported in non-PROJ4 emulation mode
writeOGR(obj = dat_SP_LL, dsn = '.', layer = 'BNGpoints', driver = 'ESRI Shapefile')

