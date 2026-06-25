# lets start with billboard datasets

billboard

# here, the data conrain wk1-wk57, all there wide wk vairable can be brought 
# under one variabel week and all vaues to rank, so data will become long

billboard %>%
  pivot_longer(
    cols = starts_with('wk'),
    names_to = 'wk',
    values_to = 'rank'
  )
# so the width data is converted to long data, can we select column in any other way?

# start with, end with, contains, range

# we can get rid of na value, values_drop_na = true

billboard %>%
  pivot_longer(
    cols = wk1:wk76,
    names_to = 'week number',
    values_to = 'rank of the song',
    values_drop_na = TRUE
  )

# many variable in the column name, problem

who2

glimpse(who2)

who2%>%
  pivot_longer(
    cols = !(country:year),
    names_to = c("diagnosis","sex","age"),
    names_sep = "_",
    values_to = "count",
    values_drop_na = TRUE
  )

# data and variable name in the column header

household
# the column name contains 
# .value = make column name separe based on "_" symbol, as first part is different for all
# the alternative colum, lets not use a variable name for first part, and the value present 
# here is used as a variable name, 
# name_child1 -> name becomes a column name
# dob_child1  -> dob becomes a column name

household%>%
  pivot_longer(
    cols = !(family),
    names_to = c('.value', 'child'),
    names_sep = '_',
    values_drop_na = TRUE
    
  )
#------------------------------------------------------------------------------

# widening data

# convert data to a lots of column data

csm_patient <- cms_patient_experience

# first step is view the data and observe it, each org is spread across multiple rows
# if we can spread them to column
view(csm_patient)
csm_patient %>%
  distinct(org_nm)

wided <- csm_patient %>%
  pivot_wider(
    names_from = measure_cd,
    values_from = prf_rate,
    
  )



