#R programing
(0.1 + 0.2) == 0.3
all.equal(0.1 + 0.2, 0.3)
all.equal(0.1 + 0.2, 0.3, tolerance = 0)
#to test for equality you can use the near fun in dplyr
dplyr:: near(0.1 + 0.2, 0.3)

min(0, 5, 10)
max(0, 5, 10)
mean(0, 5, 10)

mean(c(0, 5, 10))#the right way using a vector
median(c(0, 5, 10))

args(mean)
#Use a list to store different data types

#Exercise1
mat <- matrix(sample(c(TRUE, FALSE), 12, replace = TRUE), nrow = 3)
mat1 = matrix(as.integer(mat), nrow = 3)

mat1 = mat + 0 #Alternative way
typeof(0) #double
typeof(0L) #integar

#Datframe is a list of different data types of equal length

#Exercise 2
#advr38pkg::sum_every(1:10, 2)

colSums(matrix(1:10, nrow = 2))
mat = matrix(1:10, nrow = , byrow =TRUE)

head(iris)
colMeans(iris[, 1:4])
is.numeric((iris$Sepal.Length) #Tells you if the column is numeric
lapply(iris, is.numeric) #Tell you all the columns that are numeric in a list form
sapply(iris, is.numeric) ##Tell you all the columns that are numeric in a vectorform
colMeans(iris[sapply(iris, is.numeric)])
#sapply(iris[sapply(iris, is.numeric)])

mat <- matrix(0, 10, 2); mat[c(5, 8, 9, 12, 15, 16, 17, 19)] <- 1; mat
(decode <- matrix(c(0, NA, 1, 2), 2))
x = c(1,0)
decode[x[1] + 1, x[2] + 1]

#myfun = function(x) decode[x[1]+1, x[2]+1]
apply(mat, 1, myfun)
apply(mat, 1, function(x) decode[x[1]+1, x[2]+1])


# Call a function with arguments as a list
do.call('c', list_of_int)

## How to use a multiline expression?
replicate(5, rnorm(10))  


#Exercise 3
advr38pkg::split_ind(1:40, 3)
x = sample(1:10, 40, replace = TRUE)
sample(rep_len(1:3, 40))

split(x, rep_len(1:3, 40))

split(1:40, sample(rep_len(1:3, 40)))

split(x, sample(rep_len(1:n, length(x))))

sample(rep_len(1:3, 40))

#setting seed
set.seed(1)
(x <- rnorm(10))
mean(x)
all_est <- 
  replicate(1000, mean(sample(x, replace = TRUE)))
hist(all_est)
hist(all_est); abline(v = mean(x), col = "red")
interval <- quantile(all_est, c(0.025, 0.975))
interval
abline(v = interval, col = "chartreuse3")

df <- data.frame(
  id1 = c("a", "f", "a"),
  id2 = c("b", "e", "e"), 
  id3 = c("c", "d", "f"),
  inter = c(7.343, 2.454, 3.234),
  stringsAsFactors = FALSE
)
df
(code <- setNames(1:6, letters[1:6]))
code['a']
code[df$id1]

df[1:3] <- lapply(df[1:3], function(var), code(var))

count1 <- 0
count2 <- 0
f <- function(i) {
  count1 <-  count1 + 1  ## will assign a new (temporary) count1 each time
  count2 <<- count2 + 1  ## will increment count2 on top
  i
}
sapply(1:10, f)

c(count1, count2)
