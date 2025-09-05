mutate(flights,
       dep_time = dep_time %% 100, 
       sched_dep_time = sched_dep_time %% 100)

transmute(flights, arr_time_new = arr_time - dep_time, arr_time, dep_time, air_time)
transmute(flights, dep_time, sched_dep_time, dep_delay)

####Exercise 2
delay = group_by(flights, dep_time, dep_delay, sched_dep_time, arr_time,
                 arr_delay, sched_arr_time)
summarise(delay, dep_delay < -15)

not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))

#########Exercise 3
airport_df = airports
#average delay by destination

flights_avg_delay = not_cancelled %>%
  group_by(dest) %>%
  summarise(avg_delay = mean(dep_delay))%>%
  left_join(airport_df, by = c('dest' = 'faa'))

ggplot(flights_avg_delay, aes(lon, lat)) +
  borders("state") +
  geom_point(aes(color = avg_delay, size = avg_delay)) +
  scale_color_viridis_c(direction = -1) +
  coord_quickmap()

####Making your code faster by vectorisation
N <- 3e5

#Linear Algebra

set.seed(1)
X <- matrix(rnorm(5000), ncol = 5)
Y <- matrix(rnorm(2000), ncol = 5)

system.time({
  dist <- matrix(NA_real_, nrow(X), nrow(Y))
  for (i in seq_len(nrow(X))) {
    for (j in seq_len(nrow(Y))) {
      dist[i, j] <- sqrt(sum((Y[j, ] - X[i, ])^2))
    }
  }
})

#Easier way using sweep
colmeans = colMeans(X)
X_centered <- sweep(x, 2, colmeans())


set.seed(1)

system.time({
  N <- 1e5
  x <- 0
  count <- 0
  for (i in seq_len(N)) {
    y <- rnorm(1)
    x <- x + y
    if (x < 0) count <- count + 1
  }
  p <- count / N
})

set.seed(1)
system.time(p2 <- advr38pkg::random_walk_neg_prop(1e5))

system.time({
  N <- 1e5
  x <- 1
  count <- 0
  for (i in seq_len(N)) {
    y <- rnorm(1)
    x <- x + y
    if (x < 1) count <- count + 1
  }
  p <- count / N
})

set.seed(1)
system.time({
  N <- 1e5
  x <- 0
  count <- 0
  for (i in seq_len(N)) {
    y <- rnorm(1)
    x <- x + y
    if (x < 0) count <- count + 1
  }
  p <- count / N
})

set.seed(1)
system.time({
  N <- 1e5
  x <- 0
  count <- 0
  y <- rnorm(N)
  for (i in seq_len(N)) {
    x <- x + y[i]
    if (x < 0) count <- count + 1
  }
  p <- count / N
})
# x0 = 0
# x1 = x0 + y1 = y1
# x2 = x1 + y2 = y1 + y2
# x3 = x2 + y3 = y1 + y2 + y3

set.seed(1)
system.time({
  N <- 1e5
  y <- rnorm(N)
  x <- cumsum(y)
  # for (i in seq_len(N)) {
  #   if (x[i] < 0) count <- count + 1
  # }
  p <- mean(x < 0)
})

