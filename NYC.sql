create database if not exists NYC_Trips;

use NYC_Trips;

create table yellow_trips1 (
VendorID                INT,
    tpep_pickup_datetime     DATETIME,
    tpep_dropoff_datetime    DATETIME,
    passenger_count          FLOAT,
    trip_distance            FLOAT,
    RatecodeID               FLOAT,
    store_and_fwd_flag       VARCHAR(1),
    PULocationID             INT,
    DOLocationID             INT,
    payment_type             INT,
    fare_amount              DECIMAL(10,2),
    extra                    DECIMAL(10,2),
    mta_tax                  DECIMAL(10,2),
    tip_amount               DECIMAL(10,2),
    tolls_amount             DECIMAL(10,2),
    improvement_surcharge    DECIMAL(10,2),
    total_amount             DECIMAL(10,2),
    congestion_surcharge     DECIMAL(10,2),
    Airport_fee              DECIMAL(10,2),
    cbd_congestion_fee       DECIMAL(10,2),
    trip_month               VARCHAR(7)
);

create table yellow_trips2 (
VendorID                INT,
    tpep_pickup_datetime     DATETIME,
    tpep_dropoff_datetime    DATETIME,
    passenger_count          FLOAT,
    trip_distance            FLOAT,
    RatecodeID               FLOAT,
    store_and_fwd_flag       VARCHAR(1),
    PULocationID             INT,
    DOLocationID             INT,
    payment_type             INT,
    fare_amount              DECIMAL(10,2),
    extra                    DECIMAL(10,2),
    mta_tax                  DECIMAL(10,2),
    tip_amount               DECIMAL(10,2),
    tolls_amount             DECIMAL(10,2),
    improvement_surcharge    DECIMAL(10,2),
    total_amount             DECIMAL(10,2),
    congestion_surcharge     DECIMAL(10,2),
    Airport_fee              DECIMAL(10,2),
    cbd_congestion_fee       DECIMAL(10,2),
    trip_month               VARCHAR(7)
);

create table yellow_trips3 (
VendorID                INT,
    tpep_pickup_datetime     DATETIME,
    tpep_dropoff_datetime    DATETIME,
    passenger_count          FLOAT,
    trip_distance            FLOAT,
    RatecodeID               FLOAT,
    store_and_fwd_flag       VARCHAR(1),
    PULocationID             INT,
    DOLocationID             INT,
    payment_type             INT,
    fare_amount              DECIMAL(10,2),
    extra                    DECIMAL(10,2),
    mta_tax                  DECIMAL(10,2),
    tip_amount               DECIMAL(10,2),
    tolls_amount             DECIMAL(10,2),
    improvement_surcharge    DECIMAL(10,2),
    total_amount             DECIMAL(10,2),
    congestion_surcharge     DECIMAL(10,2),
    Airport_fee              DECIMAL(10,2),
    cbd_congestion_fee       DECIMAL(10,2),
    trip_month               VARCHAR(7)
);

CREATE TABLE taxi_zone_lookup (
    LocationID   INT,
    Borough      VARCHAR(50),
    Zone         VARCHAR(100),
    service_zone VARCHAR(50)
);


set global local_infile = 1 ;
load data local infile 'C:/Users/HP/Documents/python_le/.vscode/yellow_tripdata_2026-01.csv' 
into table yellow_trips1 fields terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

load data local infile 'C:/Users/HP/Documents/python_le/.vscode/yellow_tripdata_2026-02.csv' 
into table yellow_trips2 fields terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

load data local infile 'C:/Users/HP/Documents/python_le/.vscode/yellow_tripdata_2026-03.csv' 
into table yellow_trips3 fields terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 rows;


LOAD DATA LOCAL INFILE 'C:/Users/HP/Downloads/taxi_zone_lookup.csv'
INTO TABLE taxi_zone_lookup
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

set innodb_lock_wait_timeout = 600 ;

UPDATE yellow_trips1
SET trip_month = DATE_FORMAT(tpep_pickup_datetime, '%Y-%m')
WHERE trip_month IS NULL;

UPDATE yellow_trips2
SET trip_month = DATE_FORMAT(tpep_pickup_datetime, '%Y-%m')
WHERE trip_month IS NULL;

UPDATE yellow_trips3
SET trip_month = DATE_FORMAT(tpep_pickup_datetime, '%Y-%m')
WHERE trip_month IS NULL;


CREATE INDEX idx_pu_location ON yellow_trips1 (PULocationID);
CREATE INDEX idx_do_location ON yellow_trips1 (DOLocationID);
 
CREATE INDEX idx_pu_location ON yellow_trips2 (PULocationID);
CREATE INDEX idx_do_location ON yellow_trips2 (DOLocationID);
 
CREATE INDEX idx_pu_location ON yellow_trips3 (PULocationID);
CREATE INDEX idx_do_location ON yellow_trips3 (DOLocationID);

CREATE INDEX idx_pickup_dt ON yellow_trips1 (tpep_pickup_datetime);
CREATE INDEX idx_pickup_dt ON yellow_trips2 (tpep_pickup_datetime);
CREATE INDEX idx_pickup_dt ON yellow_trips3 (tpep_pickup_datetime);

CREATE INDEX idx_trip_month ON yellow_trips1 (trip_month);
CREATE INDEX idx_trip_month ON yellow_trips2 (trip_month);
CREATE INDEX idx_trip_month ON yellow_trips3 (trip_month);

ALTER TABLE taxi_zone_lookup ADD PRIMARY KEY (LocationID);


select count(*) as negative_value from yellow_trips1 where total_amount < 0;

select count(*)  from yellow_trips1 where total_amount = 0;

CREATE OR REPLACE VIEW yellow_trips_all AS
SELECT *FROM yellow_trips1
UNION ALL
SELECT * FROM yellow_trips2
UNION ALL
SELECT * FROM yellow_trips3;

select count(*) from yellow_trips_all;
select trip_month,count(*) from yellow_trips_all group by trip_month;

CREATE OR REPLACE VIEW yellow_trips_clean AS
SELECT *
FROM yellow_trips_all
WHERE
    trip_month IN ('2026-01', '2026-02', '2026-03')
    AND fare_amount > 0
    AND total_amount > 0
    AND fare_amount <= total_amount
    AND trip_distance > 0
    AND trip_distance < 100
    AND tip_amount >= 0
    AND tolls_amount >= 0
    AND PULocationID NOT IN (264, 265)
    AND DOLocationID NOT IN (264, 265)
    AND TIMESTAMPDIFF(SECOND, tpep_pickup_datetime, tpep_dropoff_datetime) BETWEEN 60 AND 21600;
    
select trip_month,count(*) from yellow_trips_clean group by trip_month;

CREATE OR REPLACE VIEW yellow_trips_final AS
SELECT
    t.tpep_pickup_datetime as pickup_dt,
    t.tpep_dropoff_datetime as dropoff_dt,
    t.passenger_count,
    t.RatecodeID,
    t.trip_distance,
    t.PULocationID,
    pu.Borough  AS pickup_borough,
    pu.Zone     AS pickup_zone,
    t.DOLocationID,
    do.Borough  AS dropoff_borough,
    do.Zone     AS dropoff_zone,
    t.payment_type,
    t.fare_amount,
    t.tip_amount,
    t.tolls_amount,
    t.total_amount,
    t.trip_month
FROM yellow_trips_clean t
JOIN taxi_zone_lookup pu ON t.PULocationID = pu.LocationID
JOIN taxi_zone_lookup do ON t.DOLocationID = do.LocationID;

select * from yellow_trips_final limit 500;

show variables like "secure_file_priv";

( select 'pickup_dt','dropoff_dt','passenger_count','RatecodeID','trip_distance','PULocationID','pickup_borough','pickup_zone',
'DOLocationID','dropoff_borough','dropoff_zone','payment_type','fare_amount','tip_amount','tolls_amount','total_amount','trip_month')
union all
( SELECT *
FROM yellow_trips_final )
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/yellow_trips_final1.csv'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- QUERY 1: Daily trip volume & revenue trend

SELECT
    DATE(pickup_dt) AS trip_date,
    COUNT(*) AS total_trips,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS avg_fare
FROM yellow_trips_final
GROUP BY trip_date
ORDER BY trip_date;

-- QUERY 2: Month-over-month growth

WITH monthly AS (
    SELECT trip_month, COUNT(*) AS total_trips, SUM(total_amount) AS total_revenue
    FROM yellow_trips_final
    GROUP BY trip_month
)
SELECT
    trip_month,
    total_trips,
    total_revenue,
    LAG(total_trips) OVER (ORDER BY trip_month) AS prev_month_trips,
    ROUND(
        100.0 * (total_trips - LAG(total_trips) OVER (ORDER BY trip_month))
        / LAG(total_trips) OVER (ORDER BY trip_month), 2
    ) AS growth_pct__trips
FROM monthly;

-- QUERY 3: Top 10 pickup zones by revenue, per month

WITH zone_rev AS (
    SELECT trip_month, pickup_zone, pickup_borough,
           SUM(total_amount) AS zone_revenue, COUNT(*) AS zone_trips
    FROM yellow_trips_final
    GROUP BY trip_month, pickup_zone, pickup_borough
)
SELECT *
FROM (
    SELECT *, RANK() OVER (PARTITION BY trip_month ORDER BY zone_revenue DESC) AS revenue_rank
    FROM zone_rev
) ranked
WHERE revenue_rank <= 10
ORDER BY trip_month, revenue_rank;

-- QUERY 4: Demand by day-of-week x hour-of-day

SELECT
    DAYNAME(pickup_dt) AS day_of_week,
    HOUR(pickup_dt) AS hour_of_day,
    COUNT(*) AS total_trips,
    ROUND(AVG(total_amount), 2) AS avg_fare
FROM yellow_trips_final
GROUP BY day_of_week, hour_of_day
ORDER BY
    FIELD(day_of_week, 'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'),
    hour_of_day;

-- QUERY 5: Average tip % by payment type and borough

SELECT
    pickup_borough,
    payment_type,
    ROUND(AVG(tip_amount / NULLIF(fare_amount, 0)) * 100, 2) AS avg_tip_pct,
    COUNT(*) AS total_trips
FROM yellow_trips_final
GROUP BY pickup_borough, payment_type
ORDER BY pickup_borough, payment_type;

-- QUERY 6: Weekday vs weekend comparison

SELECT
    CASE WHEN DAYOFWEEK(pickup_dt) IN (1,7) THEN 'Weekend' ELSE 'Weekday' END AS day_type,
    COUNT(*) AS total_trips,
    ROUND(AVG(total_amount), 2) AS avg_fare,
    ROUND(AVG(tip_amount / NULLIF(fare_amount,0)) * 100, 2) AS avg_tip_pct
FROM yellow_trips_final
GROUP BY day_type;

-- QUERY 7: Rate code breakdown

SELECT
    RatecodeID,
    CASE RatecodeID
        WHEN 1 THEN 'Standard'
        WHEN 2 THEN 'JFK'
        WHEN 3 THEN 'Newark'
        WHEN 4 THEN 'Nassau/Westchester'
        WHEN 5 THEN 'Negotiated'
        WHEN 6 THEN 'Group ride'
        ELSE 'Unknown/Other'
    END AS rate_type,
    COUNT(*) AS total_trips,
    ROUND(AVG(fare_amount), 2) AS avg_fare,
    ROUND(AVG(trip_distance), 2) AS avg_distance
FROM yellow_trips_final
GROUP BY RatecodeID
ORDER BY total_trips DESC;

-- QUERY 8: Top 20 pickup -> dropoff routes by volume

SELECT
    pickup_zone,
    dropoff_zone,
    COUNT(*) AS trip_count,
    ROUND(AVG(total_amount), 2) AS avg_fare
FROM yellow_trips_final
GROUP BY pickup_zone, dropoff_zone
ORDER BY trip_count DESC
LIMIT 20;

-- QUERY 9: Revenue concentration -- what % comes from the top 10 zones?

WITH zone_totals AS (
    SELECT pickup_zone, SUM(total_amount) AS zone_revenue
    FROM yellow_trips_final
    GROUP BY pickup_zone
),
ranked AS (
    SELECT *, RANK() OVER (ORDER BY zone_revenue DESC) AS rnk
    FROM zone_totals
)
SELECT
    SUM(CASE WHEN rnk <= 10 THEN zone_revenue ELSE 0 END) AS top10_revenue,
    SUM(zone_revenue) AS total_revenue,
    ROUND(100.0 * SUM(CASE WHEN rnk <= 10 THEN zone_revenue ELSE 0 END) / SUM(zone_revenue), 2) AS top10_pct_of_total
FROM ranked;

-- QUERY 10: Anomaly detection -- days where volume deviates from
-- the 7-day rolling average by more than 2 standard deviations

WITH daily_trips AS (
    SELECT DATE(pickup_dt) AS trip_date, COUNT(*) AS total_trips
    FROM yellow_trips_final
    GROUP BY trip_date
),
rolling AS (
    SELECT
        trip_date,
        total_trips,
        AVG(total_trips) OVER (ORDER BY trip_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS rolling_avg,
        STDDEV(total_trips) OVER (ORDER BY trip_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS rolling_stddev
    FROM daily_trips
)
SELECT
    trip_date,
    total_trips,
    ROUND(rolling_avg, 0) AS rolling_7day_avg,
    ROUND((total_trips - rolling_avg) / NULLIF(rolling_stddev, 0), 2) AS z_score
FROM rolling
WHERE ABS((total_trips - rolling_avg) / NULLIF(rolling_stddev, 0)) > 2
ORDER BY trip_date;

-- QUERY 11: Payment type distribution and its revenue share

SELECT
    payment_type,
    COUNT(*) AS total_trips,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM yellow_trips_final), 2) AS pct_of_trips,
    ROUND(SUM(total_amount), 2) AS total_revenue
FROM yellow_trips_final
GROUP BY payment_type
ORDER BY total_trips DESC;

-- QUERY 12: Zone-level month-over-month trend

WITH zone_monthly AS (
    SELECT pickup_zone, pickup_borough, trip_month, COUNT(*) AS total_trips
    FROM yellow_trips_final
    GROUP BY pickup_zone, pickup_borough, trip_month
)
SELECT
    pickup_zone,
    pickup_borough,
    trip_month,
    total_trips,
    LAG(total_trips) OVER (PARTITION BY pickup_zone ORDER BY trip_month) AS prev_month_trips,
    ROUND(
        100.0 * (total_trips - LAG(total_trips) OVER (PARTITION BY pickup_zone ORDER BY trip_month))
        / NULLIF(LAG(total_trips) OVER (PARTITION BY pickup_zone ORDER BY trip_month), 0), 2
    ) AS pct_change
FROM zone_monthly
ORDER BY pickup_zone, trip_month;