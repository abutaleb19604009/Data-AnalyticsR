# general statistics in R

library(tidyverse)
diamonds<- diamonds

# the first step is the generation of summary of the data

summary(diamonds)

# we can get summary of particular variable

summary(diamonds$cut)

# we can create contingency table for two or more facrors
# Testing catagorical variable for independency: Chi sqr

table(diamonds$cut, diamonds$color)
# we can check the summary statistics for this contingency table

summary(table(diamonds$cut, diamonds$color))

# Null hypothesis (H₀): cut and color are independent.
# Alternative hypothesis (H₁): cut and color are associated.

# The result shows that: Chisq = 310.32, df = 24, p-value = 1.395e-51

# since p value is extreamly smaller than the level of significance 0.05
# Reject the Null Hypothesis

#------------------------------------------------------------------------

# calculating quantiles of the datasets

quantile(diamonds$price)

# identify the low 10 percent of the data

quantile(diamonds$price, 0.1)

# identify the middle 90% of the data, lower 5% and above 5% omit

quantile(diamonds$price, c(0.05,0.95))



#-------------------------------------------------------------------------

# Converting data to z-scores (standardization) means transforming the data so that:
#   
# Mean = 0
# Standard deviation = 1
# lets standarize one variable

diamonds$price_z <- scale(diamonds$price)
sd(diamonds$price_z)

# this scalling or z value is only possible for numerical variables
# and it is important for machine learning process
# we can simply do it for the numerical variables
# first select the numeric variable and convert them to as numeric and scale
# the whole df, the all numeric variables of df are normalized 
diamonds |>
  mutate(across(where(is.numeric), ~ as.numeric(scale(.x))))



#------------------------------------------------------------------------------

# now perform t test

# compare the mean between fair and good diamond

diamonds %>%
  filter(cut %in% c('Fair','Good')) %>%
  t.test(price~cut, data=.)
# compare mean of two sample by t test
# compare the mean of good and premium

diamonds %>%
  filter(cut %in% c("Good","Premium")) %>%
  t.test(price~cut, data=., conf.level = 0.95)

#---------------------------------------------------------------------------

# performing wilcox test for investigating both sample come from same 
# Population or not, this is nonparametric test
# H0: two group are from the same distribution
diamonds %>%
  filter(color %in% c('E','J')) %>%
  wilcox.test(price~color, data=.)
  

#-----------------------------------------------------------------------------

# testing correlation for significance

# correlation between two variable if data are normally distributed
# decision, if p value less than LOS then reject null hypotheisis

cor.test(diamonds$price, diamonds$depth, method = 'pearson')


# if data is not normally distributed, then go for spearman 
cor.test(diamonds$price, diamonds$carat, method = 'spearman')
# if the relationship btn two variables are linear then pearson test
# if the relationship btn two variables are non linear then only go for
# spearman, that why before going for correlation test, data visualization is mandatory

#--------------------------------------------------------------------------------------

# testing groups for equal properties, success or failure
# test for equality of proportions (also called a two-proportion z-test or proportion test)
#It is used when the outcome is binary:
# this test can be used only for: Categorical (success/failure) data

# for two groups: here
# x = no of success
# n = total number of observation
# this is like 2x2 contigency table for chi-squre
x <- c(200,178)
n <- c(300,300)
prop.test(x,n)

#------------------------------------------------------------------------------
# for more than two groups (drug)
x = c(80, 65, 72)
n = c(100, 100, 100)
prop.test(x,n)

#-------------------------------------------------------------------------------

# for one sample

prop.test(
  x = 91,
  n = 100,
  p = 0.90
)

#-------------------------------------------------------------------------------

# performing pairwise compairison btn group mean, this is performed after anova
# ANOVA tells atleast one group mean is different from others
# it tells yes or no, not tells which one is differerent

# the first step is the anova test

anovamodel<- diamonds %>%
  aov(price~cut, data=.) 

# step 2: Tukey's Honest Significant Difference
TukeyHSD(anovamodel)
# decision for these test: if p adj < 0.05, those two group means are significantly different.

#--------------------------------------------------------------------------------------

# one sample t test
# is the sample mean different from a known population mean um?

t.test(diamonds$price, mu = 4000)

#-----------------------------------------------------------------------------------------
# two samples t test
# is the mean of two independent group different

new_diamonds <- diamonds %>%
  filter(cut %in% c('Ideal','Good'))
t.test(price~cut, new_diamonds)

#-------------------------------------------------------------------------------
# paired t test: when data is collected from the same object
# before and after of the treatment
before <- c(120,130,140,135,150)
after  <- c(110,125,138,130,142)

t.test(before,
       after,
       paired = TRUE)

#-------------------------------------------------------------------------------

# z test
# one sample z test, population mean and population std are known

install.packages("BSDA")
library(BSDA)
z.test(diamonds$price,
       mu = 4000,
       sigma.x = 800)


# ------------------------------------------------------------------------------

# two sample z test
# mean and std for both the sample groups are known
# first create two sample groups
Fair <-diamonds %>%
  subset(cut == 'Fair', price)

Good <- diamonds %>%
  subset(cut == 'Good', price)

z.test(Fair1,
       Good,
       sigma.x = 800,
       sigma.y = 900)

# in real life we almost never know population's standard deviation, that's why
# we never use z test in real life
#------------------------------------------------------------------------------
