## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  warning = FALSE,
  message = FALSE,
  error = FALSE
)

## ----model---------------------------------------------------------------
library(DALEX)
library(randomForest)
library(localModel)

data('HR')

set.seed(17)
mrf <- randomForest(status ~., data = HR, ntree = 100)
explainer <- explain(mrf, 
                     HR[, -6],
                     predict_function = function(x, y) predict(x, y, type = "prob"))
new_observation <- HR[10, -6]
new_observation

## ----explanation---------------------------------------------------------
model_lok <- individual_surrogate_model(explainer, new_observation, 
                                        size = 500, seed = 17)
plot(model_lok)
plot(model_lok, geom = "bar")

