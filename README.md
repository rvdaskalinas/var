# VAR and VECM Models

This repository contains scripts that run VECM, VAR or BVAR models based on the CI test. If cointegration is found it will run the VECM test, otherwise it will let you choose between BVAR and VAR. 

## Repository Structure

- `01_master_script.R`: Master script that runs the data cleaning script first and then chooses between the VAR and VECM scripts based on the cointegration results.
- `02_data_cleaning.R`: Script for data cleaning and performing the Johansen cointegration test.
- `03_var_model.R`: Script for fitting a VAR model if no cointegration is found.
- `04_vecm_model.R`: Script for fitting a VECM model if cointegration is found.
- `05_bvar_mode.R`: Script for fitting a BVAR model if no cointegration is found.
- `data/`: Directory for input data files.
- `results/`: Directory for output files including IRF and FEVD plots. (NOTE! For BVAR only the summary is printed. There is no FEVD plot.)

## Requirements

- The following R packages:
  - `readxl`
  - `dplyr`
  - `urca`
  - `vars`
  - `ggplot2`
  - `bvars`

## Instructions

### Step 1: Prepare Your Data

1. Place your data file (e.g., `data.xlsx`) in the `data/` directory.
2. Change the names of the columns at `02_data_cleaning.R` or find a better method of doing it automatically. I am not at this level yet. 

### Step 2: Run the Analysis

Run the master script!