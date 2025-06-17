# client - R for Data Science 2e
# project - 3: Data transformation
# task - Learn how to transform data in R.
# date - 6/5/2025
# author - Jason Entingh


# load working directory
setwd("~/Jason/R Sandbox/R for Data Science 2e")


# load libraries
library(nycflights13)
library(tidyverse)


# set dataframe
flights <- flights


# 3.2.5 Exercises
# 1. In a single pipeline for each condition, find all flights that meet the condition:
   # Had an arrival delay of two or more hours
flights |>
  filter(arr_delay >= 120) |>
  arrange(arr_delay, desc = TRUE) # could also do 'arrange(desc(arr_delay))'
   # Flew to Houston (IAH or HOU)
flights |>
  filter(dest %in% c("IAH", "HOU"))
   # Were operated by United, American, or Delta
flights |>
  filter(carrier %in% c("UA", "AA", "DL"))
   # Departed in summer (July, August, and September)
flights |>
  filter(month %in% c(7, 8, 9))
   # Arrived more than two hours late but didn’t leave late
flights |>
  filter(dep_delay <= 0 & arr_delay > 120)
   # Were delayed by at least an hour, but made up over 30 minutes in flight
flights |>
  filter(dep_delay >= 60 & dep_delay - arr_delay > 30)

# 2. Sort flights to find the flights with the longest departure delays. Find the flights that left earliest in the morning.
flights |>
  arrange(desc(dep_delay)) |>
  arrange(sched_dep_time)

# 3. Sort flights to find the fastest flights. (Hint: Try including a math calculation inside of your function.)
flights |>
  mutate(speed = distance / (air_time / 60)) |>
  arrange(desc(speed)) |>
  relocate(speed)

# 4. Was there a flight on every day of 2013?
flights |>
  distinct(month, day)
# yes, the tibble produced shows 365 rows of month x day

# 5. Which flights traveled the farthest distance? Which traveled the least distance?
flights |>
  arrange(desc(distance)) |>
  distinct(origin, dest)
# flights from JFK-HNL, EWR-HNL, and EWR-ANC traveled the farthest.
flights |>
  arrange(distance) |>
  distinct(origin, dest)
# flights from EWR-LGA, EWR-PHL, and JFK-PHL traveled the least.

# 6. Does it matter what order you used filter() and arrange() if you’re using both? Why/why not? 
# Think about the results and how much work the functions would have to do.
# does not matter, filter works on rows and arrange works on columns.


# 3.3.5 exercises
# 1. Compare dep_time, sched_dep_time, and dep_delay. How would you expect those three numbers to be related?
# I'd expect dep_delay = dep_time - sched_dep_time

# 2. Brainstorm as many ways as possible to select dep_time, dep_delay, arr_time, and arr_delay from flights.
flights |>
  select(dep_time, dep-delay, arr_time, arr_delay)

flights |>
  select(starts_with(c("arr", "dep")))

flights |>
  select(dep_time:arr_delay, -contains("sched"))

# 3. What happens if you specify the name of the same variable multiple times in a select() call?
flights |>
  select(dest, dest)
# nothing, just selects that variable once.

# 4. What does the any_of() function do? Why might it be helpful in conjunction with this vector?
# the any_of() function checks multiple variables (in a vector) for something.

# 5. Does the result of running the following code surprise you? How do the select helpers deal with upper and lower case by default? 
# How can you change that default?
flights |> select(contains("TIME"))
# suprises me that it isn't case-sensitive. the 'contains()' helper ignores case by default.

# 6. Rename air_time to air_time_min to indicate units of measurement and move it to the beginning of the data frame.
flights |>
  rename(air_time_min = air_time) |>
  relocate(air_time_min)

# 7. Why doesn’t the following work, and what does the error mean?
flights |> 
  select(tailnum) |> 
  arrange(arr_delay)
# this doesn't work because in our pipe, we've already selected tailnum as the only variable, so we can't arrange arr_delay because it's gone.

# 3.5.7 exercises

# 1. Which carrier has the worst average delays? Challenge: can you disentangle the effects of bad airports vs. bad carriers? Why/why not?
flights |>
  group_by(carrier) |>
  summarize(avg_delay = mean(dep_delay, na.rm = TRUE)) |>
  arrange(desc(avg_delay))

flights |>
  group_by(carrier, dest) |>
  summarize(n())

# 2. Find the flights that are most delayed upon departure from each destination.
flights |>
  group_by(dest) |>
  arrange(desc(dep_delay), .by_group = TRUE) |>
  slice_head(n = 1) |>
  relocate(dest, dep_delay)

# 3. How do delays vary over the course of the day? Illustrate your answer with a plot.
flights |>
  group_by(hour) |>
  summarize(avg_delay = mean(dep_delay, na.rm = TRUE)) |>
  relocate(hour, avg_delay) |>
  ggplot(aes(x = hour, y = avg_delay)) +
  geom_smooth()

# 4. What happens if you supply a negative n to slice_min() and friends?
flights |>
  group_by(dest) |>
  slice_max(dep_delay, n = -1) |>
  relocate(dest, dep_delay)

# supplying negative n arranges data in ascending or descending order (depending on slice_min or slice_max), but doesn't actually slice.

# 5. Explain what count() does in terms of the dplyr verbs you just learned. What does the sort argument to count() do?
# count() returns the unique values of a variable. It does the same thing as distinct(), but returns the n counts. setting the sort argument
# to TRUE sorts data by n counts.
flights |>
  count(dest)

flights |>
  distinct(dest)

# a handy tool - same as stata's tab function:
flights |>
  count(dest) |>
  mutate(p = n / sum(n)) |>
  arrange(desc(p))

# 6. Suppose we have the following tiny data frame:
df <- tibble(
  x = 1:5,
  y = c("a", "b", "a", "a", "b"),
  z = c("K", "K", "L", "L", "K")
)

# a. Write down what you think the output will look like, then check if you were correct, and describe what group_by() does.
df |>
  group_by(y)
# this will group the data by values of y, returning a tibble that displays the number of distinct groups.

# b. Write down what you think the output will look like, then check if you were correct, and describe what arrange() does. 
# Also, comment on how it’s different from the group_by() in part (a).
df |>
  arrange(y)
# this sorts the data, in ascending order, by values of y. it's different from group_by() because it doesn't actually group the data, just sorts.

# c. Write down what you think the output will look like, then check if you were correct, and describe what the pipeline does.
df |>
  group_by(y) |>
  summarize(mean_x = mean(x))
# this will summarize the average values of x for each value of y.

# d. Write down what you think the output will look like, then check if you were correct, and describe what the pipeline does. 
# Then, comment on what the message says.
df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x))
# this will summarize the average values of x for each distinct group of y and z.

# e. Write down what you think the output will look like, then check if you were correct, and describe what the pipeline does. 
# How is the output different from the one in part (d)?
df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x), .groups = "drop")
# this does the same thing as part d, but does not group the resulting data frame

# f. Write down what you think the outputs will look like, then check if you were correct, and describe what each pipeline does. 
# How are the outputs of the two pipelines different?
df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x))

df |>
  group_by(y, z) |>
  mutate(mean_x = mean(x))

# these two pipes do the same thing - they group the data by distinct groups of y and z, then calculate the mean value of x for each group.
# the first pipe transforms the data into one row per group, while the second pipe keeps the same number of rows as the original dataset.

# test: create a plot showing the average delay by destination airport

# order y axis by average departure time, descending
flights |>
  group_by(dest) |>
  summarize(avg_dep_delay = mean(dep_delay, na.rm = TRUE)) |>
  slice_max(avg_dep_delay, n = 10) |>
  ggplot(aes(x = avg_dep_delay, y = fct_reorder(dest, avg_dep_delay))) +
  geom_col() +
  labs(
    title = "Top Ten Average Departure Delay Times of Destination Airports from NYC",
    subtitle = "From 2013 NYC Flight Data",
    x = "Average Departure Delay Time",
    y = "Destination Airport"
  )

# order y axis by destination airport name, descending
flights |>
  group_by(dest) |>
  summarize(avg_dep_delay = mean(dep_delay, na.rm = TRUE)) |>
  slice_max(avg_dep_delay, n = 10) |>
  ggplot(aes(x = avg_dep_delay, y = fct_rev(dest))) + # orders y axis alphabetically from top to bottom
  geom_col()
