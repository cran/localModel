## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  message = FALSE,
  warning = FALSE,
  error = FALSE
)

## ----pkgs----------------------------------------------------------------
library(DALEX)
library(localModel)
library(randomForest)
data('apartments')
data('apartments_test')
set.seed(69)
mrf <- randomForest(m2.price ~., data = apartments, ntree = 50)
mlm <- lm(m2.price ~., data = apartments)

## ----model---------------------------------------------------------------
explainer <- DALEX::explain(model = mrf,
                     data = apartments_test[, -1])
explainer2 <- DALEX::explain(model = mlm, 
                      data = apartments_test[, -1])
new_observation <- apartments_test[5, -1]
new_observation

## ----explanation---------------------------------------------------------
model_lok <- individual_surrogate_model(explainer, new_observation,
                                        size = 500, seed = 17)
model_lok2 <- individual_surrogate_model(explainer2, new_observation,
                                         size = 500, seed = 17)

## ----plot----------------------------------------------------------------
plot(model_lok, model_lok2)

