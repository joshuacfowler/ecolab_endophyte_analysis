# Title: Endophyte Prevalence Analysis
# Purpose: Download and analyze endophyte scores from populations of Texas grasses collected across Texas Ecolab sites
# Authors: Ava Johnson, Ali Campbell, Josh Fowler
# Updated: April 12, 2021

# At the start of the script, we load in R packages that we use for loading data, running statistical models, and plotting our results
library(tidyverse) # has nice functions for data manipulation and visualization
library(readxl) # to read in excel spreadsheets

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
