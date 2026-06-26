# using R DBI package to make connection with the SQL Database and 
# retrive database from the database

# con <- DBI::dbConnect(
#   driver,
#   parameter1 = value1,
#   parameter2 = value2,
#   ...
# )

con <- DBI::dbConnect(
  RmariaDB = MariaDB(),
  username = 'abutaleb',
  password = 'taleb'
)

# in this excercise we are going to use duckdb
install.packages("duckdb")
library(duckdb)
con <- DBI::dbConnect(
  duckdb::duckdb(),
  dbdir = 'duckdb'
)
dbWriteTable(con, 'mpg',ggplot2::mpg)
dbWriteTable(con, 'diamonds', ggplot2::diamonds)


# we can check whether the data are loaded correctly or not

dbListTables(con)

# we can load the data from the table 

con |>
  dbReadTable('diamonds') |>
  tibble::as.tibble()


# now use sql command to extract data query, can use dbGetQuery()

sql <- " SELECT carat,cut,color,clarity,price
         FROM diamonds
         WHERE price > 15000
"

tibble::as.tibble(dbGetQuery(con,sql))


# we can use dplyr to execute everything in SQL in the beckend, with dplyr tb1()

library(dplyr)
diamon_db <- tbl(con, 'diamonds')
diamon_db

# in big databases there are some higherarchey maintained, in this case
# table might be present inside a scheme

# then in_schema is used to access the table that is inside a schema
# the diamond table is inside the sales schema

diamon_db <- tbl(con, in_schema('sales','diamond'))

big_diamond <- diamon_db |>
  filter(price >15000) |>
  select(carat:clarity, price) |>
  collect()

# lets work with sql

# import nycflight13

dbplyr::copy_nycflights13(con)

flights <- tbl(con, 'flights')
planes <- tbl(con, 'planes')


flights |>
  filter(dest == 'IAH') |>
  arrange(dep_delay) |>
  show_query()

flights |>
  group_by(dest) |>
  summarise( mean_dip_del = mean(dep_delay)) |>
  show_query()

flights |>
  filter(is.na(dep_delay)) |>
  show_query()

flights |>
  filter(!is.na(dep_delay)) |>
  show_query()


