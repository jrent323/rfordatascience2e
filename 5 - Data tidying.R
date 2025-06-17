# client - R for Data Science 2e
# project - 5: Data tidying
# task - Learning basic data tidying in R.
# date - 6/9/2025
# author - Jason Entingh


# load working directory
setwd("C:/Users/entingja/Documents/R/R for Data Science 2e")


# load libraries
library(tidyverse)


# 5.2.1 exercises
# 1. For each of the sample tables, 
# describe what each observation and each column represents.

# Table 1 - each observation represents the TB cases and population in a given
# country in a given year. each column represents a variable. tidy!

# Table 2 - each observation represents a type of count in a given country
# in a given year. 'country' and year are variables, 'type' represents count type,
# and 'count' contains values for the 'type' column.

# Table 3 - each observation represents a TB rate in a given country 
# in a given year. 'country' and 'year' are variables, while 'rate' displays
# the number of TB cases divided by the number of the total population.


# 2. Sketch out the process you’d use to calculate the rate for table2 and table3. 
# You will need to perform four operations:

  # Extract the number of TB cases per country per year.
  # Extract the matching population per country per year.
  # Divide cases by population, and multiply by 10000.
  # Store back in the appropriate place.

# table2
  # filter 'type' for only 'cases'
  # filter 'type' for only 'population', then join back on to the first table
  # divide cases by population, * 10000

# table3
  # split 'rate' by the '/' symbol, store in two separate variables
  # same as above

