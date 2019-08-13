
# Air Quality Population Mapping Tool

Data Accelerator project mapping air pollution and population.

# PollData1: Pollution Conc. Maps


-- 1x1 km gridded pollutant concentrations of the whole UK.
-- Yearly data files for 7 pollutants: PM2.5, PM10, NO2 + NOx, CO, Ozone, SO2, Benzene
-- 2001 - 2017
-- Format: CSV


#  Tasks/Operations
-- Understand coordinate system for data source
-- Consider how 1x1 km grid will fit into local authority or other boundary area.
-- Create UK map of PollData1 for PM2.5
-- Consider target/limit values to calculate zones/areas where limit values exceeded
-- Repeat for other pollutants


#  Linkages/Outputs
-- RecepData1 to quantify population exposed within a certain area 
-- RecepData1 to visualise population exposed within a certain area.






# PollData2: Air pollution monitoring stations (point measurements)


-- 148 sites around the UK with continuous measurement coverage
-- Time series of hourly concentrations of pollutants
-- 6 Pollutants PM2.5, PM10, NO2 + NOx, CO, Ozone, SO2
-- 1973 - 2019
-- Format: CSV or other


# Tasks/operations: uncertain


# Linkages/Outputs: uncertain 


# PollData3: NAEI Point Source Maps
-- Data showing grid location (eastings and northings) and emission volume form large pollution sources.
-- Various pollutants depending on the source.
-- 2016 
-- Format: XLS


# Tasks/operations: 
-- Consider coordinate system in relation to other data   
-- Create UK map for PM2.5
-- Repeat for other pollutants


# Linkages/Outputs:
-- RecepData1: quantify population living within preset radius from source (or other way of measuring)
-- RecepData1: visual representation of population living within preset radii of source
-- RecepData2: Schools/Schoolchildren close to source
-- RecepData3: Health organisations close to source






# PollData4: NAEI Area Source Maps
-- Data showing emission volume by pollutant on UK map
-- GIS map.


# Tasks/operations: uncertain
 
# Linkages/Outputs: uncertain 


# RecepData1: Mid Year Population Estimates


-- ONS estimate of UK population broken down by country and administrative area (Local Authority) and broken down by age and gender.
-- 2001 - 2017/18


# Tasks/Operations:
-- Find UK shapefiles to transform MYPE into maps
-- Produce population map for single year
-- Produce population map for all years.
-- Age disaggregated data set
-- Look into whether to gender aggregate?


# Linkages/Outputs: 
-- Links to PollData1, PollData2, PollData3 to quantify and visualise population exposed to air pollution.
    


# RecepData2: Get Info About Schools


-- Data set of all schools and other children's centres in the UK
-- Closed and open
-- Organised by postcode
-- Number of pupils


# Tasks/operations:
-- Map school location on UK local authority shapefile


# Linkages/Outputs
-- PollData3: proximity to pollution point sources
-- PollData1: Number of days spent in exceedance of target values within
-- Other:


# RecepData3: NHS Organisation Data 


-- Data sets showing locations of health organisations (e.g. Care homes, GPs)

# Tasks/operations:
-- Check whether includes hospitals


# RecepData4: English Indices of Multiple Deprivation


-- Data showing relative economic deprivation in UK
