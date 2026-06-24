# Data transformation in R
# dplyr and tidyverse both packages are used for data transformation

install.packages("nycflights13")
library(tidyverse)
library(dplyr)
flight <- nycflights13::flights


# get the brids eye view of the data

view(flight)
glimpse(flight)

# data filter using tidyverse and pipeline, the pipeline can be done by %>% or |>
# calculate average every day flight delay only for flight destination to IAH

flight %>%
  filter(dest == "IAH") %>%
  group_by(year, month, day) %>%
  summarise( arr_delay = mean(arr_delay, na.rm = TRUE))


# we can use filter by conditional operator in one or more than one variable
# find all the flight traveled more than equal 1000km and arrival delay of more than 10 min

flight %>%
  filter(distance >=1000 & arr_delay > 10)



# select all the flight departed on 1st January 2013

flight %>%
  filter(year == 2013, month == 1, day == 1)

# arrange() is used to arrange the column value in assending or descending order
# for arranging in descending order
flight %>%
  arrange(desc(arr_delay))


# for arranging in assending order, by default arrnge() order in assending

flight %>%
  arrange(arr_delay)


# more than one variables are used break the tie in the precedding variables

flight %>%
  arrange(arr_delay, day)

# TO check how many unique values are there in the row, we can use distinct()

flight %>%
  distinct(year)
# find all unique origin and destination pairs
flight %>%
  distinct( origin, dest)
# find total origin and destination pair
flight %>%
  count(origin, dest) # it automatically creates a third variable, measures how 
# many flight in each origin and dest pair, how many times this origin and 
# desination combo appears in the datasets


# sort it, arrange the count value dessending order

flight %>%
  count( origin, dest, sort = TRUE)

#---------------------------------------------------------------------------

# we can mutate new column originated from the already existing column

new_flight <- flight %>%
  mutate((speed = distance / arr_time)*60)
new_flight$speed

# from hundreds and tausends of variables, just select desired subsets of variable
# and assign them into one new data frame
# select by mention
flight %>%
  select(year,month,day)

# select my range

flight %>%
  select(year : dep_delay)

# select by skip, just not select these range and select rest of all

flight %>%
  select(! year: day)

# select all column start with, end with, and contains criteria
flight %>%
  select(starts_with('a'))
  
flight %>%
  select(ends_with('time'))
flight %>%
  select(contains('time'))

# rename existing variable, new_name = oldname 

flight %>%
  rename(departure_time=dep_time)

# bring the related variable together, by using relocalte()

flight %>%
  select(contains('time'))%>%
  relocate()
#----------------------------------------------------------------------------


# group by, calculate the average filght duration for every month, thats why group by month

flight %>%
  group_by(month) %>%
  summarise(avr_fligh_dura = mean(air_time, na.rm =TRUE),
            n = n()) %>%
  ggplot(aes(x=avr_fligh_dura, y = n))+
  geom_point()+
  geom_smooth()
# here n represent number of rwo in each group


# lets explore slice function, we can select specific row number from entire dataframe
# slice head = 1st row
flight %>%
  slice_head()


# slice tail = last row

flight %>%
  slice_tail()

# slice max, take the row with maximum value in the arrival detay variable

flight %>%
  slice_max(arr_delay)


# take the row with the minimum value in the arrival delay variable

flight %>%
  slice_min(arr_delay)

# take a any random row

flight %>%
  slice_sample( n=1)


# grouping data by multiple variables

flight %>%
  group_by(year,month, day) %>%
  summarise(max_arr_delay = max(arr_delay),
            n= n())

# try to filter na value in avariable

flight %>%
  filter(is.na(arr_delay))
