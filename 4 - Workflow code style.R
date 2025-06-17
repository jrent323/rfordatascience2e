# client - R for Data Science 2e
# project - 4: Workflow: Code Style
# task - Practice coding style conventions in R.
# date - 6/9/2025
# author - Jason Entingh


# load working directory
setwd("C:/Users/entingja/Documents/R/R for Data Science 2e")


# load libraries
library(tidyverse)


# 4.6 exercises
# 1. Restyle the following pipelines following the guidelines above.
flights|>filter(dest=="IAH")|>group_by(year,month,day)|>summarize(n=n(),
delay=mean(arr_delay,na.rm=TRUE))|>filter(n>10)

#restyled
flighs |>
  filter(dest == "IAH") |>
  group_by(year, month, day) |>
  summarize(
    n = n(),
    delay = mean(arr_delay, na.rm = TRUE)) |>
  filter(n > 10)

flights|>filter(carrier=="UA",dest%in%c("IAH","HOU"),sched_dep_time> 0900,sched_arr_time<2000)|>group_by(flight)|>summarize(delay=mean(arr_delay,na.rm=TRUE),cancelled=sum(is.na(arr_delay)),n=n())|>filter(n>10))

#restyled
flights |>
  filter(
    carrier == "UA",
    dest %in% c("IAH","HOU"),
    sched_dep_time > 0900,
    sched_arr_time < 2000
    ) |>
  group_by(flight) |>
  summarize(delay = mean(arr_delay, na.rm = TRUE),
            cancelled = sum(is.na(arr_delay)),
            n=n()
            ) |>
  filter(n>10)