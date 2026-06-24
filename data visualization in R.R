# data visualization in R

# install the required packages

install.packages("tidyverse")
install.packages("palmerpenguins")
library(tidyverse)
library(palmerpenguins)

# see the data set in the console
penguins

# use the glimpse and get a bids eye view

glimpse(penguins)

# if want to learn more details about penguins run ?penguins

?penguins

# just create a simple scatter plot, fliffer length vs body mass

penguins %>%
  ggplot(aes(x= flipper_length_mm, y= body_mass_g))+
  geom_point()


# if we need to add color, add it in aesthetic segment,add color = a variable

penguins %>%
  ggplot(aes(x = flipper_length_mm, y = body_mass_g, colour = sex)) +
  geom_point()
# sex is a catagorical variable placed in aesthetic segment, for this reason
# the value are displayed properly in the sidebar


# take another geom argument and fit a linear model here

penguins %>%
  ggplot(aes(x = flipper_length_mm, y = body_mass_g, colour = species))+
  geom_point()+
  geom_smooth(method = 'lm')
# multiple line are seen due to aesthetic argument in the global level

# now assign aesthetic argument in the local level, by assigning a mapping argument
# add mapping argument only at the geom_point, so that color argument become local only

penguins %>%
  ggplot(aes(x = flipper_length_mm, y = body_mass_g))+
  geom_point(mapping = aes(colour = species, shape = species))+
  geom_smooth(method = 'lm')
# now see, the color = species do not dominate over geom_smooth, shape is also added along with color


# now it is time to add label to the graph with labs() layer, we can add this 
# below the geom_smooth as additoinal layer

penguins %>%
  ggplot(aes(x = flipper_length_mm, y = body_mass_g))+
  geom_point(mapping = aes( colour = species, shape = species))+
  geom_smooth(method = 'lm')+
  labs(
    title = "Body mass vs flipper length",
    subtitle = " Correlation Curve",
    x = 'Flipper Length (mm)',
    y = 'Body mass (gm)',
    colour = 'species',
    shape = 'species'
  )

# create flipper length vs body mass but keep bill depth in color
penguins %>%
  ggplot(aes(x = flipper_length_mm, y = body_mass_g))+
  geom_point(mapping = aes( colour = bill_depth_mm))+
  geom_smooth(method = '')+
  labs(
    title = "Body mass vs flipper length",
    subtitle = " Correlation Curve",
    x = 'Flipper Length (mm)',
    y = 'Body mass (gm)',
    
  )


# create distribution of a catagorical variable 

penguins %>%
  ggplot(aes(x = species))+
  geom_bar()

# By default, alphabetically ordered here, but wee need to bring highest value first

penguins %>%
  ggplot(aes(x = fct_infreq(species)))+
  geom_bar(fill = 'red')+
  labs(
    title = ' The bar plot of species'
  )
# colour does not work here, fil works

penguins %>%
  ggplot(aes(x = fct_infreq(species)))+
  geom_bar(fill = 'red')


# create a histogram

penguins %>%
  ggplot(aes(x = body_mass_g))+
  geom_histogram()
           
 # set the binwidth to make x axis more aesthetic and presentable

penguins %>%
  ggplot( aes(x = body_mass_g))+
  geom_histogram(binwidth = 500)

# the distribution of a neumerical variable can also be visualized by geom density
penguins %>%
  ggplot( aes(x = body_mass_g))+
  geom_density()


# the relationship between a neumerical and catagorical variable : boxplot

penguins %>%
  ggplot(aes(x = sex, y= body_mass_g))+
  geom_boxplot()

# the same information of the boxpolt can also be visualized by density plot

penguins %>%
  ggplot(aes( x = body_mass_g, colour = sex))+
  geom_density(linewidth = 1)


# we can also fill the density plot with different color, alpha is used to control
# opacity
penguins %>%
  ggplot(aes( x = body_mass_g, colour = species, fill = species))+
  geom_density(alpha= 0.3)



# we can also use bar plot to visualize two catagorical variable, one in x axis
# another in fill 

penguins %>%
  ggplot(aes(x = island, fill = species))+
  geom_bar()

penguins %>%
  ggplot(aes(x = island))+
  geom_bar(position = "fill")

# position = "fill" means y = proportion

penguins %>%
  ggplot(aes(x = island, fill = sex))+
  geom_bar(position = "fill")+
  labs(y = 'Proportion')


# just scatter plot of two neumerical variable 

penguins %>%
  ggplot( aes(x = body_mass_g, y= bill_depth_mm))+
  geom_smooth()+
  geom_point()

# what if visualizing 3 or more variables
# two variables are in ggplot, rest of the catagorical variables are in geom

penguins %>%
  ggplot(aes(x = body_mass_g, y= flipper_length_mm))+
  geom_point(aes(colour = sex, shape = species))



# putting too many variables makes it difficult to observe, facet_wrap(~) is used


penguins %>%
  ggplot(aes(x= body_mass_g, y= flipper_length_mm))+
  geom_point( aes(colour = sex))+
  facet_wrap(~species)

# for saving any graph, we can use ggsave
penguins %>%
  ggplot(aes(x= body_mass_g, y= flipper_length_mm))+
  geom_point( aes(colour = sex))+
  facet_wrap(~species)
ggsave(height = 8, width = 8, dpi = 300, filename = 'test.plot.jpg')

