library(vars)
library(ggplot2)

# lag selection
lag_selection <- VARselect(var_data, lag.max = 12, type = "const")
lag_selection

# select based on AIC
var_model <- VAR(var_data, p = lag_selection$selection["AIC(n)"], type = "const")

# Portmanteau
serial_test <- serial.test(var_model, lags.pt = 16, type = "PT.asymptotic")
serial_test

dir.create("results/irf_plots", showWarnings = FALSE, recursive = TRUE)

# IRF save as pdf (it takes time... drink a coffee)
variables <- colnames(var_data)
for (impulse_var in variables) {
  irf_result <- irf(var_model, impulse = impulse_var, response = variables, n.ahead = 10, boot = TRUE)
  pdf(paste0("results/irf_plots/irf_plot_", impulse_var, ".pdf"))
  plot(irf_result)
  dev.off()
}

# FEVD save as pdf
fevd <- fevd(var_model, n.ahead = 10)
pdf("results/fevd_plot.pdf")
plot(fevd)
dev.off()
