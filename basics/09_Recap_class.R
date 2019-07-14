#----------------- Repeating all tests ----------------
#
# Goal: repeat the statistical tests and methods learned so far.
# Those include: correlations, chi-squared tests, t-tests, wilcoxon tests,
# shapiro tests, anovas, linear models...
#
# Your task: Every student received a red and a green card which you are supposed to raise
# throughout the script. Green = significant, Red = not significant.
# I emphasize this distinction as in cases such as for the Shapiro-Wilk, the red card is
# actually what we would like as an outcome.
#
# The basic analysis is always:
# 1) visual inspection
# 2) independent histograms of the data & shapiro
# 3) the test
# 3b) optional depending on the model: residuals of the model, plotting
#     the model etc.
#
# Lisa Gotzian, June 12, 2019

set.seed(123) # this sets the random generator in our computers to the same!

# If you ever need help for a command or test:
?t.test

#------------------ Correlations --------------------
# defining / loading your data (example from Eugene O'Loughlin)
Student_attitude <- c(94,73,59,80,93,85,66,79,77,91)
no_correct_answers <- c(17,13,12,15,16,14,16,16,18,19)

# 1) visual inspection
plot(Student_attitude, no_correct_answers)

# 2) independent histograms of the data & shapiro
hist(Student_attitude)
hist(no_correct_answers)

# Shapiro-Test - the shapiro test is always part of your procedure
shapiro.test(Student_attitude)
shapiro.test(no_correct_answers)

# F-Test: are the two variances different?
var.test(Student_attitude, no_correct_answers)

# 3) the test: correlation
# Pearson's correlation coefficient
cor(Student_attitude,no_correct_answers)
cor.test(Student_attitude,no_correct_answers)

#------------------------ T-tests------------------------
# defining / loading your data
# Temperature in South Africa
August<- c(18.3,13.3,16.5,12.6,9.5,13.6,8.1,8.9,10,8.3,7.9,8.1,13.4)
November <- c(12.7,11.1,15.3,12.7,10.5,15.6,11.2,14.2,16.2,15.5,19.9,20.4,36.8)

# 1) visual plot
#...

# 2) independent histograms of the data & shapiro
#...

# 3) test
# Student's t Test: is the temperature in August significantly different
# from the one in August?
#...

# Wilcoxon singed rank test: Like a t-test, just with ranked data, which
# could apply to "days in a month"
wilcox.test(August,November)
wilcox.test(August,November,paired=T)

#------------------------ Chi square test --------------------
## From Agresti(2007) p.39
votes <- rbind(c(762, 327, 468), c(484, 239, 477))

# This assigns column and row labels, so "dimension names"
dimnames(votes) <- list(gender = c("F", "M"),
                        party = c("Democrat","Independent", "Republican"))

# 1) Visual inspection
barplot(votes,beside=T)

# 2) histograms/shapiro don't really apply to categorical data

# 3) the chi-square test
chisq.test(votes)  # Prints test summary
Xsq <- chisq.test(votes)
Xsq$observed   # observed counts (same as M)
Xsq$expected   # expected counts under the null

#------------------ Linear model: cars -------------------
# Loading in the data: a dataset of speed & stopping distance of cars.
data(cars)
# The data is from the inbuilt datasets. For these, there is a help available:
help(cars)

# What's the relationship of speed and stopping distance?
# 1) visual plot of cars$speed, cars$dist
#...

# 2) histograms of both to see how they are distributed individually & shapiro
# and a correlation to see their relationship
#...
cor.test(cars$dist, cars$speed)


# 3a) linear model because we have 2 continuous predictors
model <- lm(cars$dist ~ cars$speed) # stopping distance explained by speed
summary(model)

# 3b) plotting the linear model
plot(cars$dist ~ cars$speed) # normal plot
abline(model) # with the model as a line

# 3c) residuals of the model normally distributed?
hist(resid(model)) # histogram of the residuals
shapiro.test(resid(model)) # the shapiro test of normality of the residuals
# The shapiro test yielded p = 0.02152
# This is not "normally distributed" because we can reject the Null-Hypothesis.

# 4a) Log-Transformation
# That's why we log-transform one variable. It's the same linear model
# but log-transforming the response.
# log-transforming: commonly done to have an even better fit.
logModel <- lm(log(cars$dist) ~ cars$speed)

# 4b) plotting the linear model
plot(log(cars$dist) ~ cars$speed)
abline(logModel)

# 4c) residuals normally distributed? Did we do better?
#... # we did do better!


#---------------------- Anova ------------------------
# Loading the data: comparing yields
data(PlantGrowth)
help(PlantGrowth)

# 1) Visual plot
boxplot(weight ~ group, data = PlantGrowth, main = "PlantGrowth data",
        ylab = "Dried weight of plants", col = "lightgray",
        notch = TRUE, varwidth = TRUE)

# 2) histogram of the variables
# This weird-looking code? I just try to get the three groups you can see in the boxplot.
hist(PlantGrowth[PlantGrowth$group == "ctrl","weight"], main = "Histogram of ctrl")
hist(PlantGrowth[PlantGrowth$group == "trt1","weight"], main = "Histogram of trt1")
hist(PlantGrowth[PlantGrowth$group == "trt2","weight"], main = "Histogram of trt2")

shapiro.test(PlantGrowth[PlantGrowth$group == "ctrl","weight"])
shapiro.test(PlantGrowth[PlantGrowth$group == "trt1","weight"])
shapiro.test(PlantGrowth[PlantGrowth$group == "trt2","weight"])

# 3a) run an anova because we have three categories and each result in 
# plantgrowth.

# The following commands are from different packages but essentially do the
# same thing.
anova(lm(weight ~ group, data = PlantGrowth))
summary(aov(weight ~ group, data = PlantGrowth))

# assign it to a "modelaov" object to access it below for the residuals
modelaov <- aov(weight ~ group, data = PlantGrowth)

# 3b) residuals normally distributed?
shapiro.test(resid(modelaov))

# 4) Post-Hoc test
TukeyHSD(modelaov)

#------------------ Some last commands for data analysis ---------------
# Understanding the data: PlantGrowth
str(PlantGrowth)
summary(PlantGrowth)

# Understanding one variable: PlantGrowth$weight
sum(PlantGrowth$weight)
mean(PlantGrowth$weight)
median(PlantGrowth$weight)
var(PlantGrowth$weight)
sd(PlantGrowth$weight)

# Understanding two variables (apart from the tests above)
# we do a table!
table(PlantGrowth$weight, PlantGrowth$group)
