library(randomForest)

# Reading the csv file and attaching the data frame
data = read.csv("titanic/train.csv")
test = read.csv("titanic/test.csv")
attach(data)

# Removing na values
# data = na.omit(data)

# Changing numeric to factor for classification
data$Survived = factor(data$Survived)

# Random Forest model
titanic.rfmodel = randomForest(Survived ~ ., ntree = 1000, mtry = 5, data = data)
titanic.rfmodel

predictions = predict(titanic.rfmodel, newdata = test)
prediction_results = data.frame(PassengerID = test$PassengerId, Survived = predictions)

write.csv(prediction_results, "R/submission.csv", row.names=FALSE)


