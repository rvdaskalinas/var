library(vars)
library(ggplot2)
library(urca)


var_data <- readRDS("data/var_data.rds")

# Fit a VECM model
vecm_model <- cajorls(johansen_test, r = cointegration_rank)
summary(vecm_model$rlm)

# vec to var
vecm_var <- vec2var(johansen_test, r = cointegration_rank)

# IRF for VECM
variables <- colnames(var_data)
for (impulse_var in variables) {
  irf_result <- irf(vecm_var, impulse = impulse_var, response = variables, n.ahead = 10, boot = TRUE)
  pdf(paste0("results/irf_plots/irf_plot_", impulse_var, "_vecm.pdf"))
  plot(irf_result)
  dev.off()
}

# FEVD for VECM
fevd_result <- fevd(vecm_var, n.ahead = 10)
pdf("results/fevd_plot_vecm.pdf")
plot(fevd_result)
dev.off()