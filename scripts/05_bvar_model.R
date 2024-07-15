library(BVAR)
library(vars)
library(ggplot2)

# Load the cleaned data
var_data <- readRDS("data/var_data.rds")

# Lag selection
lag_selection <- VARselect(var_data, lag.max = 12, type = "const")
lag_bvar <- lag_selection$selection["AIC(n)"]
print(lag_selection)

# BVAR model
bvar_model <- bvar(var_data, lags = lag_bvar)
summary(bvar_model)

# Portmanteau
serial_test <- serial.test(VAR(var_data, p = lag_bvar, type = "const"), lags.pt = 16, type = "PT.asymptotic")
print(serial_test)


# IRF for BVAR
irf_result <- irf(bvar_model, horizon = 10)
variables <- colnames(var_data)
for (impulse_var in variables) {
  for (response_var in variables) {
    pdf(paste0("results/irf_plots/irf_plot_", impulse_var, "_to_", response_var, "_bvar.pdf"))
    plot(irf_result, vars_impulse = impulse_var, vars_response = response_var)
    dev.off()
  }
}

# FEVD for BVAR
fevd_summary <- summary(irf_result, vars_impulse = variables, vars_response = variables)
print(fevd_summary)
