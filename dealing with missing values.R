# dealing with missing values

library(tidyverse)
treatment <- tribble(
  ~person,           ~treatment, ~response,
  "Derrick Whitmore", 1,         7,
  NA,                 2,         10,
  NA,                 3,         NA,
  "Katherine Burke",  1,         4
)


# we can fill the missing value by fill(everything())
# missing values are filled with the previous values
treatment |>
  fill(everything())


# we can also use a dplyr coalease()

treatment |>
  mutate(response = coalesce(response,0))

# sometimes some concrete values may also represents missing values
# such as "99" or "999" or "-99"
# we can use if_na()

a <- c(1,3,5,6,-99)

na_if(a, -99)

# in this case we can even specify the missing vale while reading the dataframe
read_csv(path, na = "99")


#---------------------------------------------------------------------------

stocks <- tibble(
  year  = c(2020, 2020, 2020, 2020, 2021, 2021, 2021),
  qtr   = c(   1,    2,    3,    4,    2,    3,    4),
  price = c(1.88, 0.59, 0.35,   NA, 0.92, 0.17, 2.66)
)


stocks |>
  pivot_wider(
    names_from = qtr,
    values_from = price
  )
# sometimes we can use values.drop.na = true to remove the missing values


# complete() creates all possible combinations of the specified variables 
# and fills in missing combinations with NA. it automatically assign NA value in 
# newly created variable




stocks |>
  complete(year = 2019:2024, qtr)

# we can use coalesce() to fill na with mean price value,
# that means we can create the missing value and we can resolve the missing value

stocks |>
  complete(year = 2019:2024, qtr) |>
  mutate(price = coalesce(price,mean(price, na.rm = TRUE)))


# distinct() and anti_join() work together to find values that don't have
# a match in another table
library(nycflights13)
nycflights13::flights
nycflights13::airports
view(flights)

# in the flights df, rename the dest to faa to match with the airports df,
# calculate the unique value in faa, then find out what are the extra value
# resent in the airports data than the calulated unique values
flights |>
  rename(faa = dest) |>
  distinct(faa) |>
  anti_join(airports)

# lets check it for tailnum

flights |>
  distinct(tailnum) |>
  anti_join(planes)

# here group by a catagorical variable and calculate a contineous variable
cnm <- flights |>
  group_by(carrier, month) |>
  summarise(
    n = n(),
    mean_dist = mean(distance),
    max_dist = max(distance),
    min_dist = min(distance)
  ) 
