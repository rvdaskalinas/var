# VAR and VECM Models

This repository contains scripts that choose between using a VAR or a VECM model based on the CI test and provides the irf and fevd plots.

## Repository Structure

- `01_master_script.R`: Master script that runs the data cleaning script first and then chooses between the VAR and VECM scripts based on the cointegration results.
- `02_data_cleaning.R`: Script for data cleaning and performing the Johansen cointegration test.
- `03_var_model.R`: Script for fitting a VAR model if no cointegration is found.
- `04_vecm_model.R`: Script for fitting a VECM model if cointegration is found.
- `data/`: Directory for input data files.
- `results/`: Directory for output files including IRF and FEVD plots.

## Requirements

- The following R packages:
  - `readxl`
  - `dplyr`
  - `urca`
  - `vars`
  - `ggplot2`

## Instructions

### Step 1: Prepare Your Data

1. Place your data file (e.g., `data.xlsx`) in the `data/` directory.
2. Change the names of the columns at `02_data_cleaning.R` or find a better method of doing it automatically. I am not on this level yet. 

### Step 2: Run the Analysis

Run the master script!