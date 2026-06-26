# lets join multiple dataset together, we can do so by two main methods
# 1. mutating already existing column
# 2. filtering the data and make it to match with second datasets column

library(tidyverse)
library(nycflights13)

# first we have to understnad primary key and foreign key :


# Primary key: A column (or combination of columns) that uniquely identifies each 
# row in a table and cannot contain duplicate or NA values.
# Foreign key: A column in one table that references the primary key of 
# another table, creating a relationship between the two tables.


# the first cirteria of joining is to check that the value of primary key is 
# duplicated or not

planes |>
  count(tailnum) |>
  filter(n>1)

# we can also check two variables together

weather |>
  count(time_hour, origin) |>
  filter(n>1)
# expected result if FALSE, means there is no duplication


# next step of the pipeline is to check there is any na value in the primary key
planes <- planes



# we can check this condition for two or more variable together

weather |>
  filter(is.na(time_hour) | is.na(origin))


# we have identify how many unique variable are there that can identify the dataframe
# uniquely
# the variable individually can not be used as primary keys
# but when combined them together, they can be used as primary keys
# because their unique combination gives no n>1 counts

flights <- flights
flights |>
  count(time_hour,carrier, flight) |>
  filter(n>1)

# lets check about airport alt and lat

airports |>
  count(alt, lat) |>
  filter(n>1)
airlines <- airlines

#---------------------------------------------------------------------------

# lets try left join, just make a subjet of first df, and join with second df


flights2 <- flights |>
  select(year, time_hour, origin, dest, tailnum, carrier)

flights2<- flights2 |>
  left_join(airlines)

flights2 |>
  left_join(weather) |>
  select(origin, time_hour, temp)
flights2 |>
  left_join(planes, join_by(tailnum)) |>
  select(origin, dest, carrier, year.y)

# we can specify the value of first df using filter
# after applying filter and left jon, we see that for that criteria there are a 
# lots of NA values


flights2 |>
  filter(tailnum == "N3ALAA") |>
  left_join(planes, join_by(tailnum)) |>
  select(tailnum, type, engines,seats)


# if the both the primary and secondary key contains same info but the name is 
# only different then we can use join_by(primary_key = secondary_key)
# here destination airport in flight2 are matched with faa in airports df
view(airports)
flights2 |>
  left_join(airports, join_by(dest == faa))

# lets match origin airport in flight2 with faa in the airports df, and leftjoin

flights2 |>
  left_join(airports, join_by( origin == faa))


# semi_join() is used to filter rows from the left table (x) based on whether a
#matching row exists in the right table
# it does not add any columns from the right table

view(flights2 |>
  semi_join(airports, join_by( origin == faa)))

# Anti-joins are the opposite: they return all rows in x that don’t have a match in y
flights2 |>
  anti_join(airports, join_by( dest == faa))

# we can also find out distinct value of x or left table that are not present in 
# the left table

flights2 |>
  anti_join(airports, join_by(dest == faa)) |>
  distinct(dest)


