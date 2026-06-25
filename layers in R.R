# lets explore layers in R

library(tidyverse)

# we are going to use mpg dataset here
mpg

# x and y two numerical variables, and another catagorical variable in aesthetics
mpg %>%
  ggplot( aes(x = displ, y = hwy, colour = class))+
  geom_point()

# ggplot2 will only use six shapes at a time, the additional class will go unplotted

mpg %>%
  ggplot(aes(x = displ, y = hwy, shape = class)) +
  geom_point()




# what if mapping size in the aesthetics, class values are presented based on size

mpg %>%
  ggplot(aes(x = displ, y = hwy, size = class)) +
  geom_point()

# what if we use alpha, the class is presented as gradient of opacity

mpg %>%
  ggplot(aes(x = displ, y = hwy, alpha = class))+
  geom_point()

mpg %>%
  ggplot( aes(x = displ, y = hwy, colour = class)) +
  geom_smooth()+
  facet_wrap(~class)

# create a plot just with geom_smooth, and define linetype in the geom_smooth aesthetic

mpg %>%
  ggplot( aes(x = displ, y = hwy, colour = drv)) +
  geom_smooth(aes(linetype = drv))


# making point and smooth together

mpg %>%
  ggplot(aes(x = displ, y = hwy))+
  geom_point(aes(colour = drv))+
  geom_smooth()

# we can use geom poin to apply different layer of filter and labeling
# take a new geom_smooth and run a filtering pipeline inside, and shape, label, color data then


mpg %>%
  ggplot(aes(x = displ, y = hwy))+
  geom_point()+
  geom_point(
  data = mpg %>%
    filter( drv == 'f'),
  colour= 'red'
  )

# we can use facet wrap for two variable also
mpg %>%
  ggplot(aes(x = displ, y = hwy, colour = drv))+
  geom_point()+
  facet_wrap(~drv)

# what if using two variable in facet wrap, remember we can alway place catagorical variables
# inside the facet wrap

mpg %>%
  ggplot(aes(x = displ, y = hwy, colour = drv))+
  geom_point()+
  facet_wrap(class ~ drv)

mpg %>%
  ggplot(aes(x = displ, y = hwy, colour = drv))+
  geom_point()+
  facet_wrap(.~ drv)


mpg %>%
  ggplot(aes(x = displ, y = hwy, colour = drv))+
  geom_point()+
  facet_wrap(class ~.)

mpg %>%
  ggplot(aes(x = displ, y = hwy, colour = drv))+
  geom_point()+
  facet_wrap(~class, scale = 'free')


# but this gives same x axis scale across all the subplot, we can make it free
# so that x scale can be adjusted according to the best fit of the subplot

mpg %>%
  ggplot(aes(x = displ, y = hwy, colour = drv))+
  geom_point()+
  facet_wrap(class ~ drv, scale = 'free')



