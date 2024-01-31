-- Question 3
SELECT COUNT(*)
FROM green_taxi_data
WHERE DATE(lpep_pickup_datetime) = '2019-09-18'
	AND DATE(lpep_dropoff_datetime) = '2019-09-18';

-- Question 4
SELECT lpep_pickup_datetime
FROM green_taxi_data
ORDER BY trip_distance DESC
LIMIT 1;

-- Question 5
SELECT taxi_zone_lookup."Borough", SUM(green_taxi_data.total_amount) AS sum_total
FROM green_taxi_data
JOIN taxi_zone_lookup
ON green_taxi_data."PULocationID" = taxi_zone_lookup."LocationID"
WHERE DATE(green_taxi_data.lpep_pickup_datetime) = '2019-09-18'
GROUP BY taxi_zone_lookup."Borough"
ORDER BY sum_total DESC;

-- Question 6
SELECT green_taxi_data."DOLocationID", taxi_zone_lookup."Zone", 
	green_taxi_data.lpep_dropoff_datetime, green_taxi_data.tip_amount, 
	green_taxi_data.fare_amount, green_taxi_data.total_amount
FROM green_taxi_data
JOIN taxi_zone_lookup
ON green_taxi_data."DOLocationID" = taxi_zone_lookup."LocationID"
WHERE DATE(lpep_pickup_datetime) >= '2019-09-01'
	AND DATE(lpep_pickup_datetime) < '2019-10-01'
	AND green_taxi_data."PULocationID" = 7
ORDER BY green_taxi_data.tip_amount DESC
LIMIT 1;



