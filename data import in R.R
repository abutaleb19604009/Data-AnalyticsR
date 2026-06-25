# data import 
library(tidyverse)

# how to import csv data
# first check your current directory
getwd()

# set new working directory

setwd("C:\\Users\\abuta\\Downloads")

student_data <- read.csv('students.csv')
student_data

# specify what should be recognised as na

student_data<- read.csv('students.csv', na= c('N/A',''))

#  Student ID and Full Name  contain brackticks, because they contain space
# lets rename them

student_data %>%
  rename(
    student_id = Student.ID,
    full_name = Full.Name
  )

# an alternative way to clean name is that, janitor::clean_names()
install.packages('janitor')
library(janitor)
student_data <- student_data %>%
  janitor::clean_names()

student_data
student_data <- student_data %>%
  mutate(
    meal_plan = factor(meal_plan),
    age = parse_number(ifelse(age == "five","5", age))
  )

# if your data have header name, then specify it in the read.csv argument

read.csv("students.csv", na = c('NA'), header = TRUE)

# read semicolon-separated files

read.csv2()


# read tab delimited, 
read_tsv()

# read the file with any delimeter, allow R to guess

read.delim()

# read apache style log file

read_log()

# read table

read.table()
