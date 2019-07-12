#------------------- Homework -----------------
#
# Homework from the problem set, exercise #5
# June 2019, Lisa Gotzian


data <- c(2.0, 3.0, 3.0, 2.0, 3.0, 0.0, 2.0, 2.0, 2.0, 3.0, 3.0,
          3.5, 3.0, 3.0, 55.0, 2.0, 85.0, 4.0, 40.0, 3.0)
summary(data)
var(data)
sd(data)

# Visualizations of the data
barplot(data) 
hist(data)
boxplot(data)

# barplot and histogram look so different because the barplot plots each value
# as a bar: first 2.0, then 3.0 etc.
# The histogram plots how many times a value is in the data