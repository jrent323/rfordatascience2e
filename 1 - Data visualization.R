# client - R for Data Science 2e
# project - 1: Data visualization
# task - Exploring data visualization with ggplot2
# date - 6/5/2025
# author - Jason Entingh


# load working directory
setwd("C:/Users/entingja/Documents/R/R for Data Science 2e")


# load libraries
library(tidyverse)
library(palmerpenguins)
library(ggthemes)


# 1.2.1 The penguins data frame
penguins
glimpse(penguins)


# 1.2.4 Adding aesthetics and layers
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species"
  ) +
  scale_color_colorblind()


### 1.2.5 Exercises
# 1. How many rows are in penguins? How many columns?
penguins
# 344 rows and 8 columns

# 2. What does the bill_depth_mm variable in the penguins data frame describe? Read the help for ?penguins to find out.
?penguins
# a number denoting bill depth (millimeters)

# 3. Make a scatterplot of bill_depth_mm vs. bill_length_mm.
# That is, make a scatterplot with bill_depth_mm on the y-axis and bill_length_mm on the x-axis.
# Describe the relationship between these two variables.
scatter_length_depth <- penguins |>
  ggplot(aes(x=bill_length_mm, y=bill_depth_mm)) +
  geom_point()
scatter_length_depth
# these variables do not appear to have a relation to one another, but may show patterns if differentiated by species.

# 4. What happens if you make a scatterplot of species vs. bill_depth_mm? What might be a better choice of geom?
scatter_depth_species <- penguins |>
  ggplot(aes(x=bill_depth_mm, y=species)) +
  geom_point()
scatter_depth_species
# a scatterplot is not effective at displaying the relationship between a categorical (discrete) variable and a numeric (continuous) variable.

#5. Why does the following give an error and how would you fix it?
# ggplot(data = penguins) + 
#   geom_point()
# this gives an error because 'geom_point()' requires x and y to be specified. 

#6. What does the na.rm argument do in geom_point()? What is the default value of the argument? 
# Create a scatterplot where you successfully use this argument set to TRUE.

# na.rm removes missing values with a warning if FALSE and silently if TRUE.
scatter_length_depth <- penguins |>
  ggplot(aes(x=bill_length_mm, y=bill_depth_mm)) +
  geom_point(na.rm=TRUE)
scatter_length_depth

# 7. Add the following caption to the plot you made in the previous exercise: 
# “Data come from the palmerpenguins package.” 
# Hint: Take a look at the documentation for labs().
scatter_length_depth <- penguins |>
  ggplot(aes(x=bill_length_mm, y=bill_depth_mm)) +
  geom_point(na.rm=TRUE) +
  labs(caption="Data come from the palmerpenguins package")
scatter_length_depth

# 8. Recreate the following visualization. What aesthetic should bill_depth_mm be mapped to? 
# And should it be mapped at the global level or at the geom level?
scatter_length_mass <- penguins |>
  ggplot(aes(x=flipper_length_mm, y=body_mass_g)) +
  geom_point(aes(color = bill_depth_mm)) +
  geom_smooth()
scatter_length_mass
# bill_depth_mm is mapped at the local level because it is used only for the point geom and not the smooth geom.
# anything mapped at the global level will be passed down to following geoms.

# 9. Run this code in your head and predict what the output will look like. Then, run the code in R and check your predictions.
scatter_length_mass <- penguins |>
  ggplot(aes(x = flipper_length_mm, y = body_mass_g, color = island)
) +
  geom_point() +
  geom_smooth(se = FALSE)
scatter_length_mass
# I predict that this will create a scatterplot with flipper length on the x axis and body length on the y axis, where
# point colors are differentiated by species, and curve lines are created for each species (and their color differentiated by species) without
# a grey area for standard error.

# 10. Will these two graphs look different? Why/why not?
# (see code in book)
# I predict these two graphs will not look different. The first code passes the aesthetic arguments down to point and smooth anyway.
# The second code contains all the same aesthetic arguments, but they are repeated for each geom.


### 1.4.3 Exercises
# 1. Make a bar plot of species of penguins, where you assign species to the y aesthetic. How is this plot different?
bar_species <- penguins |>
  ggplot(aes(y=species)) +
  geom_bar()
bar_species
# This bar chart is horizontal rather than vertical.

# 2. How are the following two plots different? Which aesthetic, color or fill, is more useful for changing the color of bars?
# (see book for code)
# The first code colors the outlines of each bar red, whereas the second code colors the entirety of each bar red.

# 3. What does the bins argument in geom_histogram() do?
# The bins argument in geom_histogram() specifies the number of bins for the histogram.

# 4. Make a histogram of the carat variable in the diamonds dataset that is available when you load the tidyverse package. 
# Experiment with different binwidths. What binwidth reveals the most interesting patterns?
hist_carat <- diamonds |>
  ggplot(aes(x=carat)) +
  geom_histogram(binwidth = 0.01)
hist_carat


# 1.5.5 Exercises
# 1. The mpg data frame that is bundled with the ggplot2 package contains 234 observations collected by the US Environmental Protection Agency 
# on 38 car models. Which variables in mpg are categorical? Which variables are numerical? 
# (Hint: Type ?mpg to read the documentation for the dataset.) How can you see this information when you run mpg?
mpg
# The variables 'manufacturer', 'model', 'trans', 'drv', 'fl', and 'class' are categorical, while the others are numeric.

# 2. Make a scatterplot of hwy vs. displ using the mpg data frame. 
# Next, map a third, numerical variable to color, then size, then both color and size, then shape. 
# How do these aesthetics behave differently for categorical vs. numerical variables?
scatter_disp_hwy <- mpg |>
  ggplot(aes(x=displ, y=hwy)) +
  geom_point()
scatter_disp_hwy

scatter_disp_hwy <- mpg |>
  ggplot(aes(x=displ, y=hwy, color=cty)) +
  geom_point()
scatter_disp_hwy

scatter_disp_hwy <- mpg |>
  ggplot(aes(x=displ, y=hwy, size=cty)) +
  geom_point()
scatter_disp_hwy

scatter_disp_hwy <- mpg |>
  ggplot(aes(x=displ, y=hwy, color=cty, size=cty)) +
  geom_point()
scatter_disp_hwy

#scatter_disp_hwy <- mpg |>
#  ggplot(aes(x=displ, y=hwy, shape=cty)) +
#  geom_point()
#scatter_disp_hwy
# Mapping a numeric variable to color adds a gradient color to each point. Mapping a numeric variable to size increases or decreases
# each point's size based on the value of the variable. Mapping a numeric variable to both color and size does both of the previous
# at the same time. Attempting to map a numeric variable to shape produces an error code, as shape can only be used with categorical variables.

# 3. In the scatterplot of hwy vs. displ, what happens if you map a third variable to linewidth?
scatter_disp_hwy <- mpg |>
  ggplot(aes(x=displ, y=hwy, linewidth=cty)) +
  geom_point()
scatter_disp_hwy
# nothing happens as there is no line to map linewidth to.

# 4. What happens if you map the same variable to multiple aesthetics?
test <- mpg |>
  ggplot(aes(x=displ, y=displ, color=displ)) +
  geom_point()
test
# ggplot allows us to map the same variable to multiple aesthetics, but it's not useful.

# 5. Make a scatterplot of bill_depth_mm vs. bill_length_mm and color the points by species. 
# What does adding coloring by species reveal about the relationship between these two variables? What about faceting by species?
scatter_depth_length <- penguins |>
  ggplot(aes(x=bill_depth_mm, y=bill_length_mm, color=species)) +
  geom_point()
scatter_depth_length
# Adding coloring by species reveals 'clusters' of data points for each species.
scatter_depth_length <- penguins |>
  ggplot(aes(x=bill_depth_mm, y=bill_length_mm)) +
  geom_point() +
  facet_wrap(~species)
scatter_depth_length

# 6. Why does the following yield two separate legends? How would you fix it to combine the two legends?
example_6 <- penguins |>
  ggplot(aes(x=bill_length_mm, y=bill_depth_mm, color=species, shape=species)) +
  geom_point() +
  labs(color="Species")
example_6
# this code produces two legends because the legend for 'color' is named "Species" while the legend for 'shape' is named "species".
# We can change this by adding 'shape="Species" to 'labs()'
example_6 <- penguins |>
  ggplot(aes(x=bill_length_mm, y=bill_depth_mm, color=species, shape=species)) +
  geom_point() +
  labs(color="Species", shape="Species")
example_6

# 7. Create the two following stacked bar plots. 
# Which question can you answer with the first one? Which question can you answer with the second one?
bar_1 <- penguins |>
  ggplot(aes(x=island, fill=species)) +
  geom_bar(position="fill")
bar_1

bar_2 <- penguins |>
  ggplot(aes(x=species, fill=island)) +
  geom_bar(position="fill")
bar_2
# bar_1 displays the percentage of each island populated by different penguin species.
# bar_2 displays the percentage of each penguin species that are on different islands.


# 1.6.1 Exercises
# 1. Run the following lines of code. Which of the two plots is saved as mpg-plot.png? Why?
# (see book for code)
# ggsave() will save the second line of code, as this is the plot most recently saved.

# 2. What do you need to change in the code above to save the plot as a PDF instead of a PNG? 
# How could you find out what types of image files would work in ggsave()?

# you would need to change the file extension. you could find out what types of image files would work in ggsave using ?ggsave
