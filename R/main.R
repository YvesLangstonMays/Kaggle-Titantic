library(randomForest)

# Reading the csv file and attaching the data frame
data <- read.csv("titanic_data/train.csv")
test <- read.csv("titanic_data/test.csv")
attach(data)


# Remove columns to improve model
data$Parch <- NULL
data$Fare <- NULL
data$Age <- NULL

# Removing na values
data <- na.omit(data)

summary(data)
# Changing numeric to factor for classification
data$Survived <- factor(data$Survived)

# Random Forest model, which is just a bootstrapped tree model
# mtry=sqrt5,importance=T, 1000 trees, nodesize 30
titanic.rfmodel <- randomForest(Survived ~ ., ntree = 1000, mtry = sqrt(5), data = data, importance = TRUE, nodesize = 30) # nolint
titanic.rfmodel

predictions <- predict(titanic.rfmodel, newdata = test)
prediction_results <- data.frame(PassengerID = test$PassengerId, Survived = predictions) # nolint


write.csv(prediction_results, "R/submission.csv", row.names = FALSE)
