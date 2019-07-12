#----------------- Linear Model -------------------
#
# Goal: understand a linear model and its residuals in R.
#
# May 16, 2019, Lisa Gotzian

#--------------- Preliminaries -------------------
# The data we'll work with (make sure it's in your working directory)
blood <- read.table("blood_pressure.txt", header = TRUE)
blood # age and blood pressure from 15 people


#---------------- Inspect the data ----------------
# Basic analysis can consist of:
str(blood) # the structure
summary(blood)
plot(blood) # a basic plot



#---------------- The statistics -------------------
# The command lm() runs the linar model. We save our model into our environment.
linearModel <- lm(blood_pressure ~ age, # blood pressure explained by age
                  data = blood)

summary(linearModel) # the summary of our model
# age seems to be significant for explaining blood pressure!
# if we want to look at it, the coefficients, the residuals.. everything is saved.


# Plot
# Now that se have the model, we can add it to our plot.
abline(linearModel) # abline adds a line to our existing plot
abline(linearModel, col = "red") # change the color to red
# surprise, our *linear* model is a line ;)


# Residuals
# How is the distribution of the model residuals?
# Residuals are stored inside our linearModel object.

# Histogram & Boxplot of residuals
hist(linearModel$residuals) # column "residuals" in the linearModel objet
boxplot(linearModel$residuals)
# looks normal
