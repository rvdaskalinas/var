source("scripts/02_data_cleaning.R")

cointegration_rank <- readRDS("results/cointegration_rank.rds")

# Choose between VECM and VAR based on the cointegration rank
if (!is.na(cointegration_rank) && cointegration_rank > 0) {
  # Run the VECM model script if cointegration is found
  source("scripts/04_vecm_model.R")
} else {
  # Run the VAR model script if no cointegration is found
  source("scripts/03_var_model.R")
}

print("Wait a few minutes and then check the results folder.")
