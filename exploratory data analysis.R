# EXPLORITORY DATA ANALYSIS

# Steps of EDA are:
#   genereates question about your data
#   answer these question about your data
#   by visualizaing, tranforming, analysing
# 
# first set of question about the data will be
# What type of variation occurs within my variables?
#   
# What type of covariation occurs between my variables?
# the best ways to understand variation is to visualize the data

library(tidyverse)

diamonds

# lets check the distribution of one contineous variable

diamonds |>
  ggplot(aes(x = carat))+
  geom_histogram(binwidth = 0.5)+
  scale_x_continuous(
    breaks = seq(0,3,0.5)
  )+
  scale_y_continuous(
    breaks = seq(0,30000,5000)
  )
# distribution of diamond for 1.5 - 3 carat

diamonds |>
  filter(carat >1 & carat < 3) |>
  ggplot(aes(x = carat))+
  geom_histogram()+
  scale_x_continuous(
    breaks = seq(0,3,0.3)
  )

diamonds |>
  distinct(y)


# if we find unusual value in some row, we can use filter to omit these rows and 
# contineu with other exceeding data 

diamonds |>
  filter(between(y,3,15)) # greater than 3 and less than 15

# filter the value taht contains price more than 300 and less than 350

diamonds |>
  filter(between(price, 300, 350))

# based on this between condition we can drop the entire row,
# we can do an if else statement in the mutate to ckeck the condition and check
# unusual vaules, after that these values are replaced with NA  

diamonds |>
  mutate( y = ifelse(y<3 | y >15, NA, y)) 

#after reoming the missing value, now plot x and y 

diamonds |>
  ggplot(aes(x = x, y=y))+
  geom_point(na.rm = TRUE)


# covariable analysis between a numerical and a catagorical variable

diamonds |>
  ggplot(aes(x = price))+
  geom_freqpoly(aes(colour = cut ), linewidth = 0.5)


# now do a boxplot

diamonds |>
  ggplot(aes(x = fct_reorder(median), y = price))+
  geom_boxplot()
