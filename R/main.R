library(randomForest)

# Reading the csv file and attaching the data frame
data = read.csv("titanic_data/train.csv")
test = read.csv("titanic_data/test.csv")
attach(data)

# Remove columns to improve model
data$Parch = NULL
data$Embarked = NULL
data$Fare = NULL
data$Age = NULL
data$Cabin = NULL

# Removing na values
data = na.omit(data)

# Changing numeric to factor for classification
data$Survived = factor(data$Survived)

# Random Forest model
titanic.rfmodel = randomForest(Survived ~ ., ntree = 100000, mtry = 5, data = data)
titanic.rfmodel

predictions = predict(titanic.rfmodel, newdata = test)
prediction_results = data.frame(PassengerID = test$PassengerId, Survived = predictions)

write.csv(prediction_results, "R/submission.csv", row.names=FALSE)


