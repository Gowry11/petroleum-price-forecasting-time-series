# Petroleum Price Forecasting Using Time-Series Analysis

## Project Overview

This project focuses on forecasting petroleum prices using classical time-series analysis techniques.

The study analyzes historical weekly West Texas Intermediate (WTI) crude oil prices obtained from the U.S. Energy Information Administration (EIA). The objective is to understand historical price behavior and develop a statistical forecasting model capable of estimating short-term petroleum price trends.

The project implements an end-to-end time-series forecasting workflow using SAS, including data preprocessing, exploratory data analysis, stationarity testing, ARIMA modeling, residual diagnostics, and forecast evaluation.

## Problem Statement

Crude oil prices are highly volatile and influenced by several factors, including geopolitical events, supply-demand imbalances, economic conditions, and market sentiment.

This volatility makes future price movements difficult to predict and creates challenges for industries, governments, and investors.

The central question addressed in this project is:

How can historical time-series data be used to forecast short-term petroleum price trends?

The project aims to develop a forecasting model capable of predicting the future 26-week average price of WTI crude oil.

## Objectives

The main objectives of this project are:

- Collect and preprocess weekly WTI crude oil price data
- Perform exploratory data analysis to understand historical price behavior
- Analyze trends, volatility, and autocorrelation in petroleum prices
- Test the time series for stationarity using the Augmented Dickey-Fuller (ADF) test
- Apply differencing to prepare the series for ARIMA modeling
- Identify and fit an appropriate ARIMA model
- Generate a 26-week ahead petroleum price forecast
- Compare ARIMA forecasting performance with a Random Walk baseline
- Perform residual diagnostics to validate the model
- Interpret the forecasting results for practical decision-making

## Dataset

### Data Source

The dataset consists of historical weekly West Texas Intermediate (WTI) crude oil spot prices collected from the U.S. Energy Information Administration (EIA).

### Dataset Details

- Commodity: West Texas Intermediate (WTI) Crude Oil
- Location: Cushing, Oklahoma
- Frequency: Weekly
- Price Unit: U.S. Dollars per Barrel
- Time Range: 1986 to the latest available period used in the analysis
- Data Type: Time-Series Data

The dataset was downloaded in Excel format and imported into SAS for preprocessing and analysis.

## Methodology

The project follows the following workflow:

Data Collection
        ↓
Data Import into SAS
        ↓
Data Cleaning and Preprocessing
        ↓
Exploratory Data Analysis
        ↓
Stationarity Testing
        ↓
First-Order Differencing
        ↓
ACF and PACF Analysis
        ↓
ARIMA Model Identification
        ↓
ARIMA(1,1,1) Model Fitting
        ↓
26-Week Forecast Generation
        ↓
Residual Diagnostics
        ↓
Comparison with Random Walk Baseline
        ↓
Result Interpretation

## Data Preprocessing

The following preprocessing steps were performed:

- Imported the raw Excel dataset into SAS
- Converted and formatted the date variable
- Sorted observations chronologically
- Checked for missing values
- Removed incomplete records where necessary
- Verified the dataset structure
- Extracted the relevant 26-week period for forecast comparison

These steps ensured that the dataset was properly structured for time-series analysis.

## Exploratory Data Analysis

Exploratory analysis was conducted to understand the behavior of petroleum prices.

The analysis included:

- Long-term price trend visualization
- Distribution analysis
- Histogram and density plots
- Box plots for identifying extreme values
- Moving average analysis
- Autocorrelation Function (ACF)
- Partial Autocorrelation Function (PACF)

The exploratory analysis showed that WTI prices exhibit:

- Strong autocorrelation
- High volatility
- Long-term trends
- Volatility clustering
- Non-stationary behavior

These characteristics supported the use of classical time-series forecasting techniques.

## Stationarity Testing

Stationarity is an important requirement for ARIMA modeling.

The Augmented Dickey-Fuller (ADF) test was used to examine whether the original WTI price series was stationary.

The raw price series was found to be non-stationary.

Therefore, first-order differencing was applied to stabilize the series before fitting the forecasting model.

## ARIMA Model

The primary forecasting model used in this project is:

ARIMA(1,1,1)

ARIMA stands for:

AutoRegressive Integrated Moving Average

Where:

- p = 1 represents the autoregressive component
- d = 1 represents first-order differencing
- q = 1 represents the moving average component

The model was selected based on:

- Stationarity analysis
- ACF patterns
- PACF patterns
- Statistical diagnostics
- Residual analysis

The ARIMA(1,1,1) model was used to capture short-term dependencies and generate future petroleum price forecasts.

## Forecasting Horizon

The forecasting model was used to predict petroleum prices for the next:

26 Weeks

The main objective was to estimate the average petroleum price over this short-term forecasting horizon.

A 26-week horizon represents approximately six months, making the forecast useful for short-term planning and decision-making.

## Baseline Model

A Random Walk model was used as a baseline for comparison.

The Random Walk approach assumes that the next price is based on the most recent observed price.

Although simple, it provides an important benchmark for evaluating whether the ARIMA model adds forecasting value.

The comparison showed that the ARIMA model provided a more structured and reliable forecast for multi-week petroleum price prediction.

## Model Validation

Residual diagnostics were performed to evaluate the quality of the ARIMA model.

The validation process included:

- Residual autocorrelation analysis
- White noise testing
- Residual distribution analysis
- Normality assessment
- Mean residual evaluation

The residual analysis indicated that the model errors behaved approximately like white noise, suggesting that the ARIMA model successfully captured the major patterns in the time series.

## Key Findings

The analysis produced the following key findings:

- WTI crude oil prices exhibit significant volatility and long-term trends
- The original price series was non-stationary
- First-order differencing was required before ARIMA modeling
- Strong autocorrelation was observed in historical weekly prices
- ACF and PACF analysis supported ARIMA model identification
- ARIMA(1,1,1) effectively captured short-term price movements
- Residual diagnostics indicated a statistically sound model fit
- The ARIMA model provided more reliable multi-week forecasts than the Random Walk baseline
- The 26-week forecast showed relatively stable short-term price behavior without major predicted spikes

## Technologies Used

- SAS Studio
- SAS OnDemand for Academics
- Microsoft Excel

## SAS Procedures Used

The project uses several SAS procedures, including:

- PROC IMPORT
- PROC SORT
- PROC SQL
- PROC ARIMA
- PROC SGPLOT
- PROC UNIVARIATE

## Visualizations

The project includes the following visual analyses:

- Historical WTI price trend
- Price distribution analysis
- Histogram and density plot
- Box plot for outlier analysis
- Moving average visualization
- ACF plot
- PACF plot
- Actual versus forecast comparison

## Applications

Petroleum price forecasting can support decision-making in several areas:

### Industry Planning

Helps organizations estimate fuel costs and plan procurement strategies.

### Government and Policy Making

Supports energy planning and economic forecasting.

### Financial Markets

Provides insights for investment, trading, and hedging decisions.

### Transportation and Logistics

Helps organizations manage fuel-related operational costs.

### Research and Academia

Provides a reproducible framework for studying classical time-series forecasting techniques.

## Limitations

The project has several limitations:

- Only historical petroleum price data was used
- External variables such as geopolitical events and supply-demand indicators were not included
- ARIMA primarily models linear relationships
- Sudden market shocks are difficult to predict
- Forecasting was limited to a 26-week horizon
- Machine learning and deep learning models were not included in this analysis

## Future Improvements

The project can be extended by:

- Including external economic indicators
- Incorporating supply and demand variables
- Using geopolitical and macroeconomic features
- Implementing LSTM or GRU models
- Comparing Prophet and machine learning approaches
- Developing hybrid ARIMA-LSTM models
- Implementing GARCH models for volatility forecasting
- Automating weekly data updates
- Building a real-time petroleum price forecasting dashboard
- Comparing multiple forecasting horizons

## Project Structure

petroleum-price-forecasting-time-series/

├── README.md
├── .gitignore
│
├── data/
│   └── README.md
│
├── code/
│   └── petroleum_price_forecasting.sas
│
└── docs/
    ├── project_report.pdf
    └── project_presentation.pdf

## How to Run

### Requirements

This project was developed using SAS.

Recommended environment:

SAS Studio or SAS OnDemand for Academics

### Steps

1. Download the WTI crude oil price dataset from the U.S. Energy Information Administration.
2. Open SAS Studio.
3. Import the dataset into SAS.
4. Run the SAS program.
5. Perform preprocessing and exploratory analysis.
6. Test the series for stationarity.
7. Apply differencing if required.
8. Fit the ARIMA model.
9. Generate the 26-week forecast.
10. Perform residual diagnostics.
11. Compare results with the Random Walk baseline.

## Conclusion

This project demonstrates the application of classical time-series analysis for short-term petroleum price forecasting.

Historical weekly WTI crude oil prices were analyzed using preprocessing, exploratory analysis, stationarity testing, ARIMA modeling, and residual diagnostics.

The ARIMA(1,1,1) model provided a structured approach for forecasting petroleum prices and performed better than the Random Walk baseline for multi-week forecasting.

The project demonstrates that classical statistical models can provide meaningful and interpretable forecasts using historical price data. Future work can improve forecasting performance by incorporating external economic variables, volatility models, machine learning, and deep learning techniques.

## Author

Gowry P P

B.Sc. Data Science & Analytics
