library(readxl)
library(dplyr)
library(urca)

# Data
data <- read_xlsx("data/data.xlsx")
data$date <- as.Date(data$date)

# Sample data from 2007-01-01 to 2021-12-01
data <- data %>%
  filter(date >= as.Date("2007-01-01") & date <= as.Date("2022-12-01"))

# Log transformation except interbank and exchange rates where we take the first difference
data <- data %>%
  mutate(log_dry_shale_production = log(dry_shale_production),
         log_shale_gas_withdrawals = log(shale_gas_withdrawals),
         log_oil_production = log(oil_production),
         log_ny_gasoline = log(ny_gasoline),
         log_brent = log(brent),
         log_wti = log(wti),
         log_industrial_oil_consumption = log(industrial_oil_consumption),
         log_m2real = log(m2real),
         diff_interbank_rates = c(NA, diff(interbank_rates)),
         diff_us_eu = c(NA, diff(us_eu)))

# Remove the first row
data <- data[-1, ]

# Put the log and the first differences in a new dataset
var_data <- data %>%
  select(log_dry_shale_production, log_shale_gas_withdrawals, log_oil_production,
         log_ny_gasoline, log_brent, log_wti, log_industrial_oil_consumption,
         log_m2real, diff_interbank_rates, diff_us_eu)

# Save the cleaned data
saveRDS(var_data, "data/var_data.rds")

# Johansen cointegration test
johansen_test <- ca.jo(var_data, type = "trace", ecdet = "const", K = 2)
summary(johansen_test)

# Extract test statistics and critical values
test_stats <- johansen_test@teststat
critical_values <- johansen_test@cval

# Determine the cointegration rank
cointegration_rank <- sum(test_stats > critical_values[, 2])
saveRDS(cointegration_rank, "results/cointegration_rank.rds")

