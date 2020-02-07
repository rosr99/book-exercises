# Author: Ryan Ros
# Exercise 5: dplyr grouped operations

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")  # should be done already
library("nycflights13")
library("dplyr")


# What was the average departure delay in each month?
# Save this as a data frame `dep_delay_by_month`
# Hint: you'll have to perform a grouping operation then summarizing your data
View(flights)
summary(flights)

dep_delay_by_month <- group_by(flights, month) %>%
  summarise(avg_dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  select(month, avg_dep_delay)

print(dep_delay_by_month) # Prints list of each month with the average departure delay

# Which month had the greatest average departure delay?

month_greatest_avg_dep_delay <- group_by(flights, month) %>%
  summarise(avg_dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  filter(avg_dep_delay == max(avg_dep_delay)) %>%
  select(month, avg_dep_delay)

print(month_greatest_avg_dep_delay) # Prints the month with the greatest average departure delay, Month: 7 avg_dep_delay: 21.7

# If your above data frame contains just two columns (e.g., "month", and "delay"
# in that order), you can create a scatterplot by passing that data frame to the
# `plot()` function

plot(month_greatest_avg_dep_delay)

# To which destinations were the average arrival delays the highest?
# Hint: you'll have to perform a grouping operation then summarize your data
# You can use the `head()` function to view just the first few rows

destination_highest_avg_arrival_delay <- group_by(flights, dest) %>%
  summarise(avg_arrival_delay = mean(arr_delay, na.rm = TRUE)) %>%
  filter(avg_arrival_delay == max(avg_arrival_delay, na.rm = TRUE)) %>%
  select(dest, avg_arrival_delay)
  
print(destination_highest_avg_arrival_delay) # Prints out the destination where the average arrival delays are the highest, CAE with 41.8 avg arrival delay



# You can look up these airports in the `airports` data frame!

View(airports)

look_up_airport_CAE <- filter(airports, faa == "CAE")
print(look_up_airport_CAE) # Prints out information of destination CAE, Columbia Metropolitan airport.





# Which city was flown to with the highest average speed?

city_highest_avg_speed <- group_by(flights, dest) %>%
  summarise(avg_speed = mean(distance/air_time, na.rm = TRUE)) %>%
  filter(avg_speed == max(avg_speed, na.rm = TRUE))

print(city_highest_avg_speed) # Prints ANC with avg speed of 8.17



