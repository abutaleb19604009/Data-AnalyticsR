# read excel file
install.packages('writexl')
library(tidyverse)
library(readxl)
library(writexl)
getwd()
data <- read_xlsx("C://Users//abuta//Downloads//ftir.xlsx")
# read_xls() reads Excel files with xls format.
# read_xlsx() reads Excel files with xlsx format.
# read_excel() can read files with both xls and xlsx 
# format. It guesses the file type based on the input.

data |>
  colnames()
# we can specify the colname while reading the data in a consistant way

student <- read_excel("C://Users//abuta//Downloads//students.xlsx",
                      col_names = c('student_id','full_name','fov_food', 'meal_plan'
                                    ,'age'))

student
# but the previous header now went back to row no 1 and presented as data
# use skip =1 for this
student <- read_excel("C://Users//abuta//Downloads//students.xlsx",
                      col_names = c('student_id','full_name','fov_food', 'meal_plan'
                                    ,'age'), skip = 1)
student <-student |>
  rename(fav_food = fov_food)
# we can specify which character strings should be recognized as NA

student <- read_excel("C://Users//abuta//Downloads//students.xlsx",
                      col_names = c('student_id','full_name','fov_food', 'meal_plan'
                                    ,'age'), skip = 1, na = c('N/A',''))
student

# age was written as charater variable, we can specify it while reading the file or 
# we can fix it by a pipeline

student <- read_excel("C://Users//abuta//Downloads//students.xlsx",
                      col_names = c('student_id','full_name','fov_food', 'meal_plan'
                                    ,'age'), skip = 1, na= c('N/A'))
student |>
  mutate(age = ifelse( age == 'five',5,age)) |>
  mutate(age = as.numeric(age))


# how to configure through different worksheets

penguin <- read_excel("C://Users//abuta//Downloads//penguins.xlsx", sheet = 'Dream Island',
                      na = 'N/A')

# we can check how many exel sheet are there before reding them
excel_sheets("C://Users//abuta//Downloads//penguins.xlsx")

# and then we can store each and every sheet in an individual variable, later 
# we can join them together if necessary

Torgersen <- read_excel("C://Users//abuta//Downloads//penguins.xlsx", 
                        sheet = "Torgersen Island")
Biscoe <- read_excel("C://Users//abuta//Downloads//penguins.xlsx",
                     sheet = "Biscoe Island")
Dream <- read_excel("C://Users//abuta//Downloads//penguins.xlsx",
                    sheet = "Dream Island")

# lets check thir dimention

dim(Torgersen)
dim(Biscoe)
dim(Dream)

# as the number of column is same number(8) for them, we can do rowbind()
Torgersen

new_penguins <- bind_rows(Torgersen,Biscoe,Dream)


# reading parts of the spreedseet by  read_excel()

read_excel("C://Users//abuta//Downloads//penguins.xlsx", range = 'A01:H20')

# can write data back to disk as an Excel file using the write_xlsx() 

write_xlsx(penguin,path ="C://Users//abuta//Downloads//penguinsWritten.xlsx"  )



#------------------------------------------------------------------------------


# lets start with google sheet
# the main function for reading google sheet is read_sheet()
install.packages('googlesheets4')
library(googlesheets4)
google <- read_sheet("https://docs.google.com/spreadsheets/d/1h2owESQWp8fu79d0BrQRrWO4agMI18R2/edit?gid=1678924928#gid=1678924928")

                     