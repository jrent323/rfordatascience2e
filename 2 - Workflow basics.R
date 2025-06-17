# client - R for Data Science 2e
# project - 2: Workflow: basics
# task - Learning foundations of running R code
# date - 6/5/2025
# author - Jason Entingh


# load working directory
setwd("C:/Users/entingja/Documents/R/R for Data Science 2e")


# load libraries
library(tidyverse)


# 2.5 Exercises
# 1. Why does this code not work?
# (see book for code)
# This code doesn't work because my_variable is not correctly typed in the second line.

# 2. Tweak each of the following R commands so that they run correctly:
# (see book for code)
# library(todyverse) should be library(tidyverse)
# ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) + geom_smooth(method = "lm")

# 3. Press Option + Shift + K / Alt + Shift + K. What happens? How can you get to the same place using the menus?
# this displays R keyboard shortcuts. You can get to the same place in Tools > Keyboard Shortcuts Help

# 4. Let’s revisit an exercise from the Section 1.6. Run the following lines of code. Which of the two plots is saved as mpg-plot.png? Why?
# (see book for code)
# this code will save my_bar_plot because it is specified using "plot = "