# 🚕 NYC Yellow Taxi Analytics

### From 11M+ Taxi Trips to Actionable Business Insights

> An end-to-end data analytics project analyzing NYC Yellow Taxi trip data using SQL, Python, statistical analysis, time-series forecasting, and Power BI to uncover demand patterns, revenue concentration, geographic performance, and operational insights.

---

## 📊 Project Overview

This project analyzes approximately **11.08 million NYC Yellow Taxi trips** collected between **January and March 2026**.

The objective was to transform raw trip-level data into actionable business insights by combining:

- **MySQL** for data preparation and SQL analysis
- **Python** for exploratory data analysis and statistical testing
- **Time-Series Analysis** for demand decomposition and forecasting
- **Power BI** for interactive business intelligence and dashboard reporting

The project follows a complete analytics workflow:


Raw Data
    ↓
Data Quality & Cleaning
    ↓
SQL Analysis
    ↓
Exploratory Data Analysis
    ↓
Statistical Hypothesis Testing
    ↓
Time-Series Analysis
    ↓
Forecasting
    ↓
Power BI Dashboard
    ↓
Business Insights & Recommendatio


📌 Dashboard Preview
```
![Home](Screenshots/Screenshot80.png)

![Executive Summary](Screenshots/Screenshot81.png)

![Operations](Screenshots/Screenshot82.png)

![Revenue](Screenshots/Screenshot83.png)
```

🎯 Business Problem

A taxi business generates millions of trip records, but raw data alone does not provide clear answers to important operational and revenue questions.

This analysis focuses on answering:

When is taxi demand highest?
How does demand vary by hour, day, and month?
Which pickup zones generate the most revenue?
How concentrated is revenue among the top-performing locations?
Which routes contribute most to business performance?
How do fares vary by distance, borough, and rate type?
Are observed differences statistically significant?
Can short-term taxi demand be forecasted?

The ultimate goal is to support better:

Driver allocation
Operational planning
Geographic prioritization
Revenue monitoring
Demand forecasting

📂 Data Source & Dataset Overview

The project uses NYC Yellow Taxi trip data and taxi zone lookup information.

Dataset Summary
Metric	Value
Analysis Period	January – March 2026
Raw Records	11.08M
Cleaned Records	10.38M
Records Removed	6.25%
Pickup Zones	259
Total Revenue	$308.8M

📖 Data Dictionary

Column / Feature	Description
tpep_pickup_datetime	Date and time when the trip started
tpep_dropoff_datetime	Date and time when the trip ended
passenger_count	Number of passengers
trip_distance	Distance travelled during the trip
RatecodeID	Rate code used for the trip
PULocationID	Pickup location identifier
DOLocationID	Drop-off location identifier
payment_type	Payment method used
fare_amount	Base fare amount
tip_amount	Tip amount
tolls_amount	Toll amount
total_amount	Total trip revenue
pickup_borough	Pickup borough
pickup_zone	Pickup zone
dropoff_borough	Drop-off borough
dropoff_zone	Drop-off zone
trip_duration	Calculated trip duration
tip_percentage	Calculated tip percentage
day_of_week	Day on which the trip occurred
hour	Hour of the day
day_type	Weekday or Weekend classification

🛠️ Tech Stack & Tools

Database & SQL
MySQL
CTEs
Window Functions
Views
Joins
Aggregations
Indexing
Python
Python
Pandas
NumPy
SciPy
Statsmodels
Scikit-learn
Data Visualization
Matplotlib
Seaborn
Power BI
Statistical Analysis
Welch's t-test
Paired t-test
Wilcoxon signed-rank test
ANOVA
Welch ANOVA
Chi-Square Test
Effect Size Analysis
Confidence Intervals
Multiple Testing Correction
Time-Series Analysis
STL Decomposition
ADF Test
KPSS Test
ACF
PACF
ARIMA
SARIMA
Ljung-Box Test
ARCH Test
🔄 Methodology
1. Data Cleaning & Quality Assessment

The raw data was evaluated for data-quality issues, including:

Missing values
Invalid fares
Negative values
Zero-value transactions
Invalid trip distances
Unrealistic trip distances
Invalid trip durations
Negative tips
Invalid location records

The cleaned dataset was then enriched with taxi zone information.

Feature Engineering

Additional analytical features were created:

Trip Date
Month
Day of Week
Weekday / Weekend
Hour of Day
Trip Duration
Tip Percentage
Pickup Borough
Drop-off Borough
Pickup Zone
Drop-off Zone
Rate Type
Payment Type
2. SQL Analysis

MySQL was used to perform structured analysis and create reusable analytical outputs.

Key SQL Analysis
Daily trip and revenue trends
Monthly performance comparison
Top pickup zones
Top routes
Revenue concentration
Rate-type analysis
Payment-type analysis
Rolling averages
Ranking analysis
Demand anomaly detection
SQL Techniques Used
CTEs
Window Functions
RANK()
ROW_NUMBER()
LAG()
Rolling Averages
Conditional Aggregation
Views
Indexing
3. Exploratory Data Analysis

Python was used to explore:

Demand trends
Revenue distribution
Trip-distance behavior
Trip-duration patterns
Geographic performance
Hourly demand
Weekday vs weekend behavior
Payment methods
Rate types
4. Statistical Hypothesis Testing

The analysis was designed around business questions.

Examples include:

Weekday vs Weekend

Do taxi performance metrics differ significantly between weekdays and weekends?

Payment Methods

Does tip percentage differ across payment methods?

Borough Analysis

Does average trip distance differ across boroughs?

Monthly Demand

Did taxi demand change significantly between months?

Categorical Association

Are categorical variables statistically associated with payment behavior?

The analysis considered:

Statistical Significance
        +
Effect Size
        +
Confidence Intervals
        +
Business Significance
Effect Sizes Used
Cohen's d
Eta-squared
Omega-squared
Cramér's V
Multiple Testing Corrections
Bonferroni Correction
Benjamini-Hochberg FDR Correction
5. Time-Series Analysis & Forecasting

Daily taxi demand was analyzed using:

Daily Demand
      ↓
STL Decomposition
      ↓
Trend + Seasonality + Residual
      ↓
Stationarity Testing
      ↓
ACF / PACF
      ↓
ARIMA / SARIMA
      ↓
Forecast Evaluation
      ↓
Residual Diagnostics
Forecast Evaluation Metrics
MAE
RMSE
MAPE
Diagnostic Tests
Ljung-Box Test
ARCH Test
Residual Autocorrelation
ACF
PACF
Q-Q Plot

Since the dataset covers approximately three months, the forecasting analysis is focused on short-term demand planning rather than long-term annual seasonality.

💡 Key Insights & Visualizations
1️⃣ Revenue is Highly Concentrated Among Top Pickup Zones

The top 10 pickup zones generated approximately:

💰 $117.1M in Revenue

This represented approximately:

📊 37.92% of Total Revenue
Business Interpretation

A relatively small number of pickup locations contribute a significant share of total revenue.

This indicates that these locations are strategically important for:

Driver allocation
Operational planning
Revenue monitoring
Capacity management
Visualization

2️⃣ JFK Airport is a Major Revenue-Generating Location

JFK Airport generated approximately:

💰 $29.7M in Revenue

from approximately:

🚕 380,961 Trips
Business Interpretation

Airport activity represents an important revenue segment and should be analyzed separately from standard urban taxi demand.

Airport trips may have different:

Trip distances
Fare values
Demand patterns
Operational requirements
Visualization

3️⃣ Taxi Demand Varies Significantly Throughout the Day

Demand is not evenly distributed across all hours.

Peak-hour analysis identified periods of higher demand that can support:

Driver scheduling
Fleet allocation
Capacity planning
Operational decision-making
Visualization

4️⃣ Statistical Significance Must Be Interpreted Carefully

With more than 10 million observations, even small differences can become statistically significant.

Therefore, the analysis did not rely only on p-values.

Instead, it also evaluated:

Effect size
Confidence intervals
Practical business significance

This helps distinguish between:

Statistically detectable differences

and:

Business-relevant differences

Visualization

5️⃣ Short-Term Demand Forecasting Can Support Operational Planning

Time-series analysis was used to identify:

Trend
Seasonality
Autocorrelation
Short-term demand patterns

ARIMA and SARIMA models were evaluated using forecast error metrics and residual diagnostics.

Visualization

📊 Power BI Dashboard

The Power BI report contains four analytical pages designed for business users.

🏠 Page 1: Home

Provides:

Project overview
Analysis period
Key KPIs
Navigation

📈 Page 2: Executive Summary

Provides a high-level view of:

Total trips
Total revenue
Average fare
Average trip distance
Daily demand
Revenue trends
Monthly comparisons

🚕 Page 3: Operations

Focuses on:

Peak demand hours
Demand heatmaps
Top pickup zones
Top routes
Revenue concentration

💰 Page 4: Revenue & Behavior

Focuses on:

Rate types
Fare vs distance
Borough-level trip behavior
Trip duration
Payment methods

🐍 Python Notebook Screenshots
Data Preparation & Feature Engineering

Statistical Hypothesis Testing

Time-Series Decomposition & Forecasting

Forecast Diagnostics

🎯 Strategic Recommendations — The "So What?"
1. Implement Demand-Based Driver Allocation

Use hourly and daily demand patterns to allocate driver capacity more effectively.

This could improve:

Driver utilization
Customer availability
Peak-hour service coverage
2. Prioritize High-Value Pickup Locations

High-revenue zones and airport locations should receive focused operational monitoring.

Potential actions include:

Monitoring driver availability
Tracking demand changes
Evaluating revenue performance
Planning capacity around peak periods
3. Monitor Revenue Concentration

Since the top 10 zones contribute a significant share of total revenue, management should track revenue concentration over time.

A sudden increase in concentration may indicate:

Geographic demand shifts
Operational problems
Changes in customer behavior
4. Use Forecasting for Short-Term Planning

Short-term demand forecasts can support:

Driver scheduling
Fleet planning
Demand monitoring
Capacity management
5. Integrate External Data

Future analysis should combine taxi data with:

Weather
Traffic
Holidays
Major events
Airport schedules

This could improve both forecasting accuracy and business interpretation.

🚀 Future Improvements
📅 Expand the Time Period

Analyze multiple years of data to study:

Year-over-year growth
Annual seasonality
Long-term trends
Seasonal demand patterns
🌦️ Add External Variables

Integrate:

Weather
Traffic
Events
Holidays
Airport activity

to improve forecasting and explain demand changes.

📈 Improve Forecast Validation

Compare ARIMA and SARIMA against baseline models such as:

Naive Forecast
Seasonal Naive Forecast

Use rolling time-series cross-validation for more robust model evaluation.

🧠 Add Advanced Forecasting Models

Evaluate:

Prophet
XGBoost
LightGBM
SARIMAX
Ensemble Forecasting
🔮 Add Predictive Analytics

Potential extensions include:

Trip fare prediction
Demand prediction by zone
Revenue forecasting
Anomaly detection
High-demand zone classification
🏗️ Improve Data Modeling

Develop a scalable star schema:

                 Dim Date
                    │
                    │
Dim Zone ───── Fact Trips ───── Dim Rate Type
                    │
                    │
              Dim Payment Type

This would improve:

Data maintainability
Query performance
Power BI performance
Scalability
⚠️ Limitations
Limited Time Period

The analysis covers approximately three months.

Therefore:

Long-term seasonality cannot be reliably analyzed.
Year-over-year comparisons are unavailable.
Forecasting is limited to short-term demand planning.
External Factors Not Included

The analysis does not include:

Weather
Traffic
Major events
Airport schedules

These factors may influence demand and revenue.

Observational Data

The analysis identifies patterns and associations.

It does not prove causation.

For example:

A zone generating higher revenue does not necessarily mean that the zone alone causes higher revenue.

📁 Project Structure
NYC-Yellow-Taxi-Analytics/
│
├── README.md
│
├── SQL/
│   └── nyc_taxi_analysis.sql
│
├── Python/
│   └── nyc_taxi_analysis.ipynb
│
├── PowerBI/
│   └── NYC_Yellow_Taxi_Dashboard.pbix
│
└── screenshots/
    │
    ├── powerbi_home.png
    ├── powerbi_executive_summary.png
    ├── powerbi_operations.png
    ├── powerbi_revenue_behavior.png
    │
    ├── python_data_preparation.png
    ├── python_hypothesis_testing.png
    ├── python_time_series.png
    ├── python_diagnostics.png
    │
    ├── revenue_concentration.png
    ├── top_revenue_zones.png
    ├── demand_heatmap.png
    ├── hypothesis_testing.png
    └── time_series_forecast.png
▶️ How to Run / Reproduce the Project
1. Clone the Repository
git clone https://github.com/your-username/nyc-yellow-taxi-analytics.git
cd nyc-yellow-taxi-analytics
2. Install Python Dependencies
pip install pandas numpy scipy statsmodels scikit-learn matplotlib seaborn sqlalchemy pymysql
3. Run the SQL Analysis
Install MySQL.
Create the required database.
Load the NYC Yellow Taxi data.
Load the taxi zone lookup table.
Run the SQL analysis script.
4. Run the Jupyter Notebook
jupyter notebook

Open:

Python/nyc_taxi_analysis.ipynb

Update the data path or database connection if required.

5. Open the Power BI Dashboard

Open:

PowerBI/NYC_Yellow_Taxi_Dashboard.pbix

Refresh the data source if required.

🧰 Skills Demonstrated

This project demonstrates practical experience with:

SQL Data Analysis
Data Cleaning
Exploratory Data Analysis
Statistical Hypothesis Testing
Effect Size Analysis
Multiple Testing Correction
Time-Series Analysis
Forecasting
Residual Diagnostics
Power BI Dashboard Development
DAX
Data Modeling
Business Intelligence
Data Storytelling
👤 Contact
Sagar Singh

Aspiring Data Analyst

📌 Specializing in:

SQL
Python
Power BI
DAX
Statistical Analysis
Time-Series Analysis
Business Intelligence
Connect With Me
💼 LinkedIn
🐙 GitHub
⭐ Project Summary

This project demonstrates a complete end-to-end data analytics workflow:

Raw Data
    ↓
Data Cleaning
    ↓
SQL Analysis
    ↓
Exploratory Data Analysis
    ↓
Statistical Testing
    ↓
Time-Series Forecasting
    ↓
Power BI Dashboard
    ↓
Business Insights
    ↓
Strategic Recommendations

The project goes beyond simply creating charts.

It connects:

📊 Data

What happened?

📐 Statistics

Is the difference meaningful?

🔮 Forecasting

What might happen next?

💼 Business Intelligence

What action should the business take?
