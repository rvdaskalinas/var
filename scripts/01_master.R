source("scripts/02_data_cleaning.R")

cointegration_rank <- readRDS("results/cointegration_rank.rds")

# Choose between VECM and VAR based on the cointegration rank
if (!is.na(cointegration_rank) && cointegration_rank > 0) {
  # Run the VECM model script if cointegration is found
  source("scripts/04_vecm_model.R")
} else {
  # Choose between VAR and BVAR
  cat("Choose a model to run:\n")
  cat("1: VAR\n")
  cat("2: BVAR\n")
  model_choice <- as.integer(readLines("stdin", n = 1))
  
  if (model_choice == 1) {
    source("scripts/03_var_model.R")
  } else if (model_choice == 2) {
    source("/scripts/05_bvar_model.R")
  } else {
    cat("Invalid choice. Exiting.\n")
  }
}


print("Wait a few minutes and then check the results folder.")
