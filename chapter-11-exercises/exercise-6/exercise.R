# Author: Ryan Ros
# Exercise 6: dplyr join operations

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")  # should be done already
library("nycflights13")
library("dplyr")

# Create a dataframe of the average arrival delays for each _destination_, then 
# use `left_join()` to join on the "airports" dataframe, which has the airport
# information
# Which airport had the largest average arrival delay?

avg_arrival_delays_dest_df <- group_by(flights, dest) %>%
  summarise(avg_arrival_delay = mean(arr_delay, na.rm = TRUE)) %>%
  rename(faa = dest)

print(avg_arrival_delays_dest_df)

avg_arr_delay_df <- left_join(avg_arrival_delays_dest_df, airports, by = "faa") %>%
  filter(avg_arrival_delay == max(avg_arrival_delay, na.rm = TRUE))
print(avg_arr_delay_df)

# Create a dataframe of the average arrival delay for each _airline_, then use
# `left_join()` to join on the "airlines" dataframe
# Which airline had the smallest average arrival delay?

avg_arrival_delay_airline <- group_by(flights, carrier) %>%
  summarise(avg_arrival_delay = mean(arr_delay, na.rm = TRUE)) %>%
  left_join(airlines, by = "carrier") %>%
  arrange(avg_arrival_delay)

print(avg_arrival_delay_airline) # Prints Alaska Airlines
