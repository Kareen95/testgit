rm(list = ls())
stocks <- tibble(
  year = c(2015, 2015, 2016, 2016),
  half = c(1, 2, 1, 2),
  return = c(1.88, 0.59, 0.92, 0.17)
) 
stocks

stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>% 
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")

table4a

table4a %>% 
  pivot_longer(c(1999, 2000), names_to = "year", values_to = "cases")

#correct way of running the code above 
table4a %>% 
  pivot_longer(c('1999', '2000'), names_to = "year", values_to = "cases")
  
people <- tribble(
  ~name,             ~names,  ~values,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)


preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes",     NA,    10,
  "no",      20,    12
)

preg_tidy <- preg %>%
  pivot_longer(c(male, female), names_to = 'sex', values_to = 'count')

preg_tidy




######################GGPLOT EXERCISES
iris = iris
head(iris)

iris_tidy <- iris %>%
  pivot_longer(c(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width),
               names_to = 'names', values_to = 'value')
iris_tidy

ggplot(iris_tidy) +
  geom_density(aes(value, fill = Species)) +
  facet_wrap(~ names, scales = 'free') 
  #theme_minimal()

#Create a scatter plot with the data below
(df <- dplyr::filter(gapminder::gapminder, year == 1992))

ggplot(df) +
  geom_point(aes(gdpPercap, lifeExp, colour = continent, 
                 size = pop / 1e6))+
  scale_x_log10()+
  labs(x = 'Gross Domestic Product (log scale)',
       y = 'life Expectancy at Birth (years)', 
       title = 'Gapminder for 1992', colour = 'Continent',
       size = 'Population\n(millions)') +
  theme(plot.title = element_text(hjust = 0.5))
  

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = 'blue')

str(mpg)
glimpse(mpg)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = displ< 5,
                          stroke = 3))
#line chart
geom_line

#boxplot
geom_boxplot

#histogram
geom_histogram

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE, show.legend = FALSE) #se removes the shadow from the plot
 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

#Make plots to make similar graphs
ggplot(data = mpg,aes(x = displ, y = hwy)) + 
  geom_smooth(aes(group = drv), se = FALSE) +
  geom_point()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_smooth(aes(group = drv), se = FALSE) +
  geom_point()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_smooth(colour = 'blue') +
  geom_point()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_smooth(aes(linetype = drv), se = FALSE) +
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(size = 4, color = "white") +
  geom_point(aes(colour = drv))

################Tibble #######

as_tibble(iris)
glimpse(mtcars)
(as.data.frame(mtcars)) #viewing with dataframe
(tibble(mtcars)) #viewing as tibble
is_tibble(mtcars)

df <- data.frame(abc = 1, xyz = "a")
df$x
df[, "xyz"]
df[, c("abc", "xyz")]

#converting to tibble
df1 = as_tibble(df)
df1 <- tibble(
  abc = 1, 
  xyz= "a")

df1$x
df1[, "xyz"]
df1[, c("abc", "xyz")]

cars = mtcars
var = "mpg"
cars[[var]]
cars$mpg

annoying <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(length(`1`))
)
annoying[[1]] #taking the first variable
annoying[['1']] #taking the column called 1
plot(annoying[[1]], annoying[[2]]) #plotting with the positions
annoying[['3']] = annoying[[2]]/annoying[[1]] #plotting with the name of the column

annoying = rename(annoying, one = '1', two = '2', three = '3')
colnames(annoying) = c('one', 'two', 'three') #

#enframe converts a vector to a dataframe
tibble::enframe(x = c(a =1, b = 2, c = 3, d = 4))


############## Data Transformation ###########

library(nycflights13)
library(tidyverse)

flights = nycflights13::flights
is_tibble(flights)

filter(flights, arr_delay >= 120)

filter(flights, dest == 'IAH' | dest == 'HOU')

filter(flights, carrier == 'UA' | carrier == 'AA' | carrier == 'DL')
filter(flights, carrier %in% c('UA','AA','DL')) #Alternative way

filter(flights, month %in% c(7, 8, 9))
filter(flights, month %in% 7:9)

filter(flights, arr_delay > 120 & dep_delay == 0)

filter(flights, dep_delay >= 60 & minute > 30)

filter(flights, dep_delay >= 60, dep_delay - arr_delay > 30)

summary(flights$dep_time)

###Exercise on arrange
arrange(flights, dec(is.na(dep_time), dep_time))

head(arrange(flights, desc(dep_delay)))

head(arrange(flights, dep_delay))

arrange(flights, desc(air_time))

arrange(flights, desc(distance/air_time))


#####Exercise on Select
select(flights, dep_time, dep_delay, arr_time, arr_delay)
select(flights, 4, 6, 7, 9)
select(flights, starts_with('dep_'), starts_with ('arr_'))

select(flights, dep_time, dep_time, arr_time)
vars <- c("year", "month", "day", "dep_delay", "arr_delay")

select(flights, any_of(vars))

select(flights, contains("time"), ignore.case = FALSE)

















