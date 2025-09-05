##################Answers to first exercise

# Tidy data, run first
tidy4a <- table4a %>%
  pivot_longer(c(1999, 2000), names_to = "year", values_to = "cases")
tidy4b <- table4b %>%
  pivot_longer(c(1999, 2000), names_to = "year", values_to = "population")
# 12.3
#1
stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>%
  pivot_wider(names_from = year, values_from = return) %>%
  pivot_longer(2015:2016, names_to = "year", values_to = "return")
# They are not perfectly symmetrical because when pivot_wider() turns variable values
# into column names, those names are always stored as character strings.
# When pivot_longer() reverses the process, it has no way of knowing the original type (e.g. numeric)
# so you must explicitly convert it back using names_transform.
#2
# It fails because the numbers in the vector are seen as element number. We need to put it into quotations:
table4a %>%
  pivot_longer(c(1999, 2000), names_to = "year", values_to = "cases")
#3
people <- tribble(
  ~name, ~key, ~value,
  #-----------------|--------|------
  "Phillip Woods",  "age", 45,
  "Phillip Woods", "height", 186,
  "Phillip Woods", "age", 50,
  "Jessica Cordero", "age", 37,
  "Jessica Cordero", "height", 156
)
glimpse(people)
# If you widen this table, pivot_wider() will produce list-columns
# because name and key do not uniquely identify rows (e.g. Phillip Woods has two “age” values).
people2 <- people %>%
  group_by(name, key) %>%
  mutate(obs = row_number())
# This obs column ensures that each (name, key, obs) combination is unique
# so pivot_wider() can create a regular table.
pivot_wider(people2, names_from="name", values_from = "value")
#4
preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes", NA, 10,
  "no", 20, 12
)
# We need to pivot longer to get the variables: sex, pregnant and count:
preg_tidy <- preg %>%
  pivot_longer(c(male, female), names_to = "sex", values_to = "count")
preg_tidy
# If we think about our data, we could drop the instances that are impossible:
preg_tidy2 <- preg %>%
  pivot_longer(c(male, female), names_to = "sex", values_to = "count", values_drop_na = TRUE)
preg_tidy2

########Answers to GGplot exercises
library("tidyverse")
#3.3
#1
# Needs to be outside mapping, since mapping specify relation between variable and value.
# This is what is likely meant
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), colour = "blue")
#2
?mpg
glimpse(mpg)
# chr ones are categorical
# int or dbl are continuous
#3
# Map cty (city miles per gallon) which is continuous to colour.
# It becomes a scale of colour and not descrete colours.
ggplot(mpg, aes(x = displ, y = hwy, colour = cty)) +
  geom_point()
# Scale of sizes
ggplot(mpg, aes(x = displ, y = hwy, size = cty)) +
  geom_point()
# Shape is not possible
ggplot(mpg, aes(x = displ, y = hwy, shape = cty)) +
  geom_point()
#4
ggplot(mpg, aes(x = displ, y = hwy, colour = hwy, size = displ)) +
  geom_point()
# We get a plot but redundant information since size and x-axis position give the same information. Same for colour
#5
ggplot(mtcars, aes(wt, mpg)) +
  geom_point(shape = 21, colour = "black", fill = "white", size = 2, stroke = 5)
# Creates an "aura" or border with thickness of the specified value
#6
ggplot(mpg, aes(x = displ, y = hwy, colour = displ < 5)) +
  geom_point()
# It creates a colour boolean, so that above and below have a colour each
#3.6
#1
# line chart: geom_line()
# boxplot: geom_boxplot()
# histogram: geom_histogram()
# area chart: geom_area()
#2
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, colour = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)
# both scatterplot and smooth (without se). Gas consumption vs miles per gallon,
# coloured according to drive, i.e. front, back, 4 wheel
#3
ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, colour = drv),
    show.legend = FALSE
  )
# in the name, legend will not be shown. If we delete, it is there, so it is on by default
#4
#adds standard error to the geom_smooth:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, colour = drv)) +
  geom_point() +
  geom_smooth(se = TRUE)
#on by default:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, colour = drv)) +
  geom_point() +
  geom_smooth()
#5
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()
ggplot() +
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
# No, the 2 geoms will inherit the data specified in the mapping. This is easier to look at, code more clear.
#6
#.1
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(se = FALSE)
#.2
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(group = drv), se = FALSE) +
  geom_point()
#.3
ggplot(mpg, aes(x = displ, y = hwy, colour = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)
#.4
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = drv)) +
  geom_smooth(se = FALSE)
#.5
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(colour = drv)) +
  geom_smooth(aes(linetype = drv), se = FALSE)
#.6
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(size = 4, color = "white") +
  geom_point(aes(colour = drv))


######### Answers to data transformation questions
library(nycflights13)
library(tidyverse)
nycflights13::flights
View(flights)
# 5.2
# 1
filter(flights, arr_delay >= 120)
# 2
filter(flights, dest == "IAH" | dest == "HOU")
# %in% scales better
filter(flights, dest %in% c("IAH", "HOU"))
# 3
airlines
filter(flights, carrier %in% c("AA", "DL", "UA"))
# 4
filter(flights, month == 7 | month == 8 | month == 9)
filter(flights, month %in% 7:9)
# 5
filter(flights, arr_delay > 120, dep_delay <= 0)
# 6
filter(flights, dep_delay >= 60, dep_delay - arr_delay > 30)
# 7
summary(flights$dep_time)
# Midnight is represented 2400 not 0
filter(flights, dep_time <= 600 | dep_time == 2400)
#Modulus operation would also be good, we will see this later:
filter(flights, dep_time %% 2400 <= 600)
# 2
#between(x, left, right) x is larger or = to left and equal or smaller or equal to than right.
filter(flights, between(month, 7, 9))
# 3
filter(flights, is.na(dep_time))
# arr_time also missing, flights cancelled
# 4
# Anything ^0 = 1
# Na|TRUE is unknown or TRUE, so true.
# FALSE & Na is FALSE or Na so FALSE
#  & TRUE is Na, Na could be FALSE
# x * 0 = 0 for finite numbers, but Inf and -Inf are NaN, not a number
Inf * 0

###Exercise on Arrange
#Nas sorted last:
arrange(flights, dep_time) %>%
  tail()
# desc() does not change this:
arrange(flights, desc(dep_time))
# The flights will first be sorted by desc(is.na(dep_time)).
# desc(is.na(dep_time)) evaluates to TRUE when dep_time is missing, or FALSE, when it is not,
# the rows with missing values of dep_time will come first, since TRUE > FALSE
arrange(flights, desc(is.na(dep_time)), dep_time)
# 2
# Most delayed are the highest dep_delay:
arrange(flights, desc(dep_delay))
# Earliest is the other end
arrange(flights, dep_delay)
# 3
#Least time in the air
head(arrange(flights, air_time))
# highest speed:
head(arrange(flights, desc(distance / air_time)))
# 4
# shortest
arrange(flights, desc(distance))
# longest
arrange(flights, distance)









