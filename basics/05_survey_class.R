#------------ Inspecting our ways to university-------------
#
# Goal: take the dataset recorded in the second session of the
# course and do a basic statistical analysis with it.
#
# Lisa Gotzian, May 8, 2019

#------------------- Preliminaries --------------------
# Enter here the packages you need as well as the data you'll work with.
library(readxl) # to read excel files
library(GGally) # to be able to do the multiple-plots-plot

survey <- read_excel(path = 'survey_day2.xlsx')
survey <- as.data.frame(survey) # I don't like the tibble representation

# Convert them to factors to be able to do calculations and plots
survey$transport <- as.factor(survey$transport)
survey$transportNum <- c(2,3,4,5,1,7,6)[as.numeric(survey$transport)]
survey$tired <- as.factor(survey$tired)
survey$direct_NS <- as.factor(survey$direct_NS)
survey$tutor <- as.factor(survey$tutor)

# Do a version without tired to be able to display the ggpairs plot
surveyWoTired <- survey[,-2] # tired is the second column

# Basic inspections
View(survey)
head(survey)
str(survey)

#------------------- Basic plots -----------------------
# To inspect the data, some visuals can be really helpful.
ggpairs(surveyWoTired) # ggpairs is from the package GGally

# Do a plot for each column
plot(survey$transport) # categorical, so automatic histogram.
plot(survey$tired) # categorical, so automatic histogram.
hist(survey$direct_degree) # numeric, so I use hist to get a histogram. 
hist(survey$km) # numeric, so I use hist to get a histogram. 
plot(survey$tutor) # categorical, so automatic histogram.

# Look at boxplots to compare
boxplot(survey$km) #why does the boxplot look so weird?
hist(survey$km) # because most data is around 0
boxplot(survey$direct_degree)

#------------------- Descriptive statistics --------------------
# Recall what you can do up till now. I recall:
# - median and mean
# - some statistical tests like the shapiro test

# Mean & Median: for a better overview, always combine it with a histogram
mean(survey$km)
median(survey$km)
hist(survey$km) # How is it distributed? Why are median and mean different?
summary(survey) # This is a little faster ;)

#------------------- Inference statistics --------------------
# Let's do some tests!
# Shapiro-Wilk test: do you think this variable is normally-distributed?
shapiro.test(survey$km) # definitely not!

# Chi-square-test: Is the tired and the tutor column related?
# two *categorical* variables
chisq.test(survey$tired, survey$tutor) # there seems to be a relation
plot(survey$tired)
plot(survey$tired, survey$tutor)

# T-test: do my tutor-students come a significantly longer way?
# numeric variable km split into tutors. 
# t.test(variable1, variable 2) # normal syntax
t.test(survey[survey$tutor == "heike", "km"],
       #don't get confused, the km when tutor is heike
       
       survey[survey$tutor == "Lisa", "km"] ) # the km when tutor is lisa
# no significant difference

# Now do it for Lisa vs. Prabesh
t.test(survey[survey$tutor == "Lisa", "km"],
       #don't get confused, the km when tutor is heike
       
       survey[survey$tutor == "Prabesh", "km"] ) # the km when tutor is lisa
# also not significant :(

# Note: Remember how we collected the data? The $tutor-column is the only
# column that matches the rest of its row.
survey[2,] # displays the 2nd row
# reveals that the data is not connected, the person didn't come by foot 
# from NE and walked 2.5km. This means: most tests won't work
# (except for with tutor).

# The end!
library(beepr)
beep(5)