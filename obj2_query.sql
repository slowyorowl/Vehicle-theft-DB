-- Objective 2: identify which vehicles are stoeln

-- 1. Find the vehicle types that are most often and least often stolen.

-- This query runs what vehicle type that is most often stolen. 
SELECT vehicle_type, count(vehicle_id) AS num_vehicles
FROM stolen_vehicles
GROUP BY vehicle_type
ORDER BY num_vehicles DESC
LIMIT 5;

-- This query runs what vehicle type that is least often stolen. 
SELECT vehicle_type, count(vehicle_id) AS num_vehicles
FROM stolen_vehicles
GROUP BY vehicle_type
ORDER BY num_vehicles
LIMIT 5;

-- 2. For each vehicle type, find the average age of the cars that are stolen. 

SELECT vehicle_type, AVG(YEAR(date_stolen) - model_year) AS avg_age
FROM stolen_vehicles 
GROUP BY vehicle_type
ORDER BY avg_age DESC;

-- 3. For each vehicle type, find the precent of vehicles stolen that are luxury

WITH lux_standard AS (SELECT vehicle_type, 
CASE WHEN make_type = 'Luxury' THEN 1 ELSE 0 END AS luxury, 1 AS all_cars
FROM stolen_vehicles sv LEFT JOIN make_details md
	ON sv.make_id = md.make_id)
    
SELECT vehicle_type, sum(luxury) / sum(all_cars) * 100 AS pct_lux
FROM lux_standard
GROUP BY vehicle_type
ORDER BY pct_lux DESC

-- 4. Create a table whee the rows represent the top 10 vehicle types, the columns represent the top 7 colors (plus 1 column for all other colors) and the va;ues are the number vehicles stolen.  
Silver	1272
White	934
Black	589
Blue	512
Red	    390
Grey	378
Green	224

SELECT color, count(vehicle_id) AS num_vehicles
FROM stolen_vehicles
GROUP BY color
ORDER BY num_vehicles DESC;

SELECT vehicle_type, count(vehicle_id) AS num_vehicles,
	sum(CASE WHEN color = 'Silver' THEN 1 ELSE 0 END) AS silver,
    sum(CASE WHEN color = 'White' THEN 1 ELSE 0 END) AS white,
    sum(CASE WHEN color = 'BLack' THEN 1 ELSE 0 END) AS black,
    sum(CASE WHEN color = 'Blue' THEN 1 ELSE 0 END) AS blue,
    sum(CASE WHEN color = 'Red' THEN 1 ELSE 0 END) AS red,
    sum(CASE WHEN color = 'Grey' THEN 1 ELSE 0 END) AS grey,
    sum(CASE WHEN color = 'Green' THEN 1 ELSE 0 END) AS green,
    sum(CASE WHEN color IN ('Gold', 'Brown, "Yellow', 'Orange', 'Purple', 'Cream', 'Pink') THEN 1 ELSE 0 END) AS other
FROM stolen_vehicles
GROUP BY vehicle_type
ORDER BY num_vehicles DESC
LIMIT 10;
-- 5. Data visualization: create a heat map