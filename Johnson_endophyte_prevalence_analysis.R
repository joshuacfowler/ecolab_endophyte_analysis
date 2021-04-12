# Title: Endophyte Prevalence Analysis
# Purpose: Download and analyze endophyte scores from populations of Texas grasses collected across Texas Ecolab sites
# Authors: Ava Johnson, Ali Campbell, Josh Fowler
# Updated: April 12, 2021

# At the start of the script, we load in R packages that we use for loading data, running statistical models, and plotting our results
library(tidyverse) # has nice functions for data manipulation and visualization
library(readxl) # to read in excel spreadsheets
library(glm) # use to run generalized linear models
library(prism) # package for downloading PRISM climate data
library(raster) # working with raster data to get climate data out of PRISM
library(reshape) #for data manipulation
################################################################################
##### Load Data ################################################################
################################################################################

# We will load in our data here. This can be weird between different computers, but we need to download the data from the google drive into this project folder, and then read in those files.
# you can figure this out a bit by running 
# getwd()

# We will create an object for each dataset and assign it to the filename of the data we are uploading
scores_2018 <- read_excel(path = "Ecolab2.0.xlsx", sheet = "Plants Scored")
locations_2018 <- read_excel(path = "Ecolab2.0.xlsx", sheet = " Sites") #This is annoying, but the spreadsheet has a space in front of that sheet

scores_2019 <- read_excel(path = "Endophyte_field_collections_2019.xlsx", sheet = "Endophyte_scoring_2019")
locations_2019 <- read_excel("Endophyte_field_collections_2019.xlsx", sheet = "Collection Locations")

scores_2020 <- read_excel(path = "Endophyte_field_collections_2020.xlsx", sheet = "Endophyte_scoring_2020")
locations_2020 <- read_excel(path = "Endophyte_field_collections_2020.xlsx", sheet = "Collection Locations")

# Now we can merge all of this into one dataframe
# Ideally, we want one dataframe where each plant has a score, a location, and it's year
colnames(scores_2018)
colnames(scores_2019)
colnames(scores_2020)

endo_scores <- 

################################################################################
##### Run generalized linear model for longitude ###############################
################################################################################
# Here we can run a model to test for the effect of longitude on endophyte prevalence
# We can also use AIC to help choose our model
# It's good to start by visualizing our data in general, so let's start with a histogram of scores or maybe a map of our locations









################################################################################
##### Plot model estimates #####################################################
################################################################################




################################################################################
##### Pulling in climate data ##################################################
################################################################################
# this downloads a raster file for 30-year normal climate for precipitation and temperature
# you can use other commands, like get_prism_annual to get annual or monthly data from PRISM
get_prism_normals(type="ppt",resolution = "800m",mon = 1, keepZip=FALSE) 
get_prism_normals(type="tmean",resolution = "800m",mon = 1, keepZip=FALSE)

ls_prism_data(name = TRUE)

# Grab the prism data and compile the files
climate_data <- ls_prism_data() %>%   
  prism_stack(.)  

# Extract projection coordinates from raster stack
climate_crs <- climate_data@crs@projargs


# Now we will extract the climate data from the raster files and save to a dataframe.
# This takes a while, so uncomment following lines and then you should save the output as an R data object

point_df <- data.frame(rasterToPoints(climate_data)) ##creates a dataframe of points (This step takes a bit of time)
year.df <- melt(point_df, c("x", "y")) %>% # This makes the data frame "long: so the temp and ppt values are in one column
  separate(variable, into = c("PRISM", "Variable", "Year", "Normal", "Resolution", "Month", "file")) %>% # this is separating the big file name variable into different columns.
  dplyr::rename("lon" = "x", "lat" = "y")

#Now we can save this dataframe so we can just load it in the future and use it again without redownloading the data
saveRDS(year.df, file = "PRISM_climate_normal_df.Rda")

year.df <- readRDS(file = "PRISM_climate_normal_df.Rda")


