rm(list = ls())

# Libraries ---------------------------------------------------------------

library(shiny)
library(shinythemes)
library(lubridate)
library(dplyr)
library(plotly)
library(DT)
library(ggplot2)

# Read data ---------------------------------------------------------------

# UFO Sightings Data
ufo_orig <- read.csv("data/scrubbed.csv", stringsAsFactors = FALSE, header = TRUE)

ufo <- ufo_orig %>%
    dplyr::select(
        .data$latitude, 
        .data$longitude, 
        .data$shape, 
        .data$country,
        .data$datetime, 
        .data$date.posted, 
        .data$city, 
        .data$state,
        duration_sec = .data$duration..seconds.)

# Clean data --------------------------------------------------------------

ufo$latitude <- as.numeric(as.character(ufo$latitude)) # Warning message: on row 43783 the value "33q.200088" exist !
ufo$longitude <- as.numeric(as.character(ufo$longitude))
ufo$country <- as.factor(ufo$country)
ufo$datetime <- lubridate::mdy_hm(ufo$datetime)
ufo$date.posted <- lubridate::mdy(ufo$date.posted)
ufo$duration_sec <- as.numeric(as.character(ufo$duration_sec)) # Warning message: on row 27823, 35693, and 58592 the values "2`"   "8`"   "0.5`" exist !

# Filter data for USA -----------------------------------------------------

ufo <- na.omit(ufo)
ufo <- filter(ufo, .data$country == "us" & !(.data$state %in% c("ak", "hi", "pr")))

head(ufo_orig)
head(ufo)
print(str(ufo))
