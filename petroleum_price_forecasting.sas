/*STEP 1 — Import the Excel File*/
proc import datafile="/home/u64287794/14,19/RWTCw1.xlsx"
    out=oil_data
    dbms=xlsx
    replace;
    sheet="Data 1";
run;

/* Preview first rows */
proc print data=oil_data (obs=10);
    title "Preview of Imported Data (First 10 Rows)";
run;


/*STEP 2 — Fix Date Column*/
data oil_data_fixed;
    set oil_data;
    SAS_Date = Date;
    format SAS_Date date9.;
run;


/*STEP 3 — Sort data oldest → newest*/
proc sort data=oil_data_fixed out=oil_sorted;
    by SAS_Date;
run;

/* Verify sorted data */
proc print data=oil_sorted (obs=20);
    var SAS_Date WTI_Price;
    title "Sorted Oil Price Data (Oldest to Newest) - First 20 Rows";
run;

/* Dataset summary */
proc sql;
    title "Dataset Summary: Date Range and Total Rows";
    select min(SAS_Date) as Start format=date9.,
           max(SAS_Date) as End format=date9.,
           count(*) as TotalRows
    from oil_sorted;
quit;


/*STEP 4 — Check for missing SAS_Date*/
proc sql;
    title "Count of Missing SAS_Date Values";
    select count(*) as MissingDates
    from oil_sorted
    where SAS_Date is null;
quit;


/*STEP 5 — Extract Last 26 Weeks & Compute Actual Average*/
proc sort data=oil_sorted out=sorted_desc;
    by descending SAS_Date;
run;

/* Last 26 rows */
data last26;
    set sorted_desc(obs=26);
run;

proc print data=last26;
    title "Last 26 Weeks of Data Used for 6-Month Actual Average";
run;

/* Actual 26-week average */
proc sql;
    title "Last 6-Month (26-Week) Actual Average of WTI Price";
    select mean(WTI_Price) as Last6MonthAverage
    from last26;
quit;


/*STEP 6 — Random Walk Forecast*/
proc sql outobs=1;
    title "Random Walk Forecast (Next Week = Last Observed Price)";
    select WTI_Price as RandomWalk_Forecast
    from sorted_desc;
quit;


/*STEP 7 — Final Clean Dataset*/
data oil_clean;
    set oil_sorted;
    if missing(SAS_Date) then delete;
    if missing(WTI_Price) then delete;
run;

proc sql;
    title "Final Row Count After Removing Missing Data";
    select count(*) as FinalRows 
    from oil_clean;
quit;


/*STEP 7A — VISUAL EDA (LINE PLOT, HISTOGRAM, BOX PLOT, MA)*/

/* 1. Line Plot */
title "Weekly WTI Petroleum Price Trend";
proc sgplot data=oil_clean;
    series x=SAS_Date y=WTI_Price / lineattrs=(thickness=2 color=blue);
    xaxis label="Date";
    yaxis label="WTI Crude Oil Price (USD)";
run;

/* 2. Histogram */
title "Distribution of Weekly WTI Prices";
proc sgplot data=oil_clean;
    histogram WTI_Price;
    density WTI_Price;
    xaxis label="WTI Price (USD)";
run;

/* 3. Box Plot */
title "Price Variability and Outliers";
proc sgplot data=oil_clean;
    vbox WTI_Price;
    yaxis label="WTI Crude Oil Price (USD)";
run;

/* 4. Moving Average (30-week) – SAS OnDemand Compatible */
data oil_ma;
    set oil_clean;
    retain sum30 0 count30 0;
    
    /* Add current price to rolling sum */
    sum30 + WTI_Price;
    count30 + 1;

    /* Remove value older than 30 rows */
    if count30 > 30 then sum30 = sum30 - lag30(WTI_Price);

    /* Calculate MA only after 30 observations */
    if count30 >= 30 then MA_30 = sum30 / 30;
run;

/* Plot with Moving Average */
title "WTI Price with 30-Week Moving Average";
proc sgplot data=oil_ma;
    series x=SAS_Date y=WTI_Price / transparency=0.4 lineattrs=(color=gray);
    series x=SAS_Date y=MA_30 / lineattrs=(color=red thickness=2);
    xaxis label="Date";
    yaxis label="Price (USD)";
run;


/* 5. ACF & PACF (Time-Series EDA) */
title "Autocorrelation (ACF) Plot for WTI Price";
proc arima data=oil_clean;
    identify var=WTI_Price nlag=30;
run;
quit;

title "Partial Autocorrelation (PACF) Plot for WTI Price";
proc arima data=oil_clean;
    identify var=WTI_Price nlag=30 stationarity=(adf);
run;
quit;


/*STEP 7B — ADF Test BEFORE Differencing*/
title "ADF Test for Stationarity on Original WTI Price Series";
proc arima data=oil_clean;
    identify var=WTI_Price stationarity=(adf);
run;
quit;


/*STEP 8 — ARIMA FORECASTING*/
proc sort data=oil_clean out=oil_final;
    by SAS_Date;
run;

proc arima data=oil_final;
    title "ARIMA(1,1,1) Model Identification, Estimation, and Forecasting";
    identify var=WTI_Price(1) stationarity=(adf);
    estimate p=1 q=1 method=ml;
    forecast lead=26 id=SAS_Date out=ARIMA_Forecast;
run;
quit;


/*STEP 8B — Residual Diagnostics*/

/* Residual Autocorrelation */
proc arima data=ARIMA_Forecast;
    title "ARIMA Residual Autocorrelation Check";
    identify var=residual nlag=30;
run;
quit;

/* Residual Normality */
proc univariate data=ARIMA_Forecast normal;
    title "Residual Normality Test (Histogram + Tests)";
    var residual;
    histogram residual;
run;


/*STEP 9 — Compute ARIMA 26-Week Forecast Average*/
proc sql;
    title "ARIMA 26-Week Forecast Average";
    select mean(Forecast) as ARIMA_26Week_Forecast_Average
    from ARIMA_Forecast;
quit;


/*STEP 10 — Combine Results into Final Summary Table*/

/* Last 26-week average */
proc sql noprint;
    select mean(WTI_Price)
    into :Last6MonthAvg
    from last26;
quit;

/* Random walk */
proc sql noprint outobs=1;
    select WTI_Price
    into :RandomWalk
    from sorted_desc;
quit;

/* ARIMA average */
proc sql noprint;
    select mean(Forecast)
    into :ARIMA_Avg
    from ARIMA_Forecast;
quit;

/* Build summary */
data Final_Summary;
    Last6Month_Average   = &Last6MonthAvg;
    RandomWalk_Forecast  = &RandomWalk;
    ARIMA_26Week_Average = &ARIMA_Avg;
run;

proc print data=Final_Summary noobs;
    title "Final Combined Forecast Summary (Actual vs RW vs ARIMA)";
run;


/*STEP 11 — Export Forecast Output to Excel*/
proc export data=ARIMA_Forecast
    outfile="/home/u64287794/ARIMA_Forecast_Output.xlsx"
    dbms=xlsx
    replace;
run;
