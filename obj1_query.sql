-- Objective 1: Identify when vehicles are stolen. 

-- 1. Find the number of vehicles stolen each year.
SELECT YEAR(date_stolen), count(vehicle_id) AS num_vehicles
FROM stolen_vehicles 
GROUP BY YEAR(date_stolen);
-- 2. find the number of vehicles stolen each month.
SELECT YEAR(date_stolen), MONTH(date_stolen), DAY(date_stolen), count(vehicle_id) AS num_vehicles
FROM stolen_vehicles 
WHERE MONTH(date_stolen) = 4
GROUP BY MONTH(date_stolen), YEAR(date_stolen), DAY(date_stolen)
ORDER  BY YEAR(date_stolen), MONTH(date_stolen), DAY(date_stolen);
-- 3. Find the number of vehicles stoeln each day of the week. 
SELECT dayofweek(date_stolen) AS dow, 
count(vehicle_id) AS num_vehicles
FROM stolen_vehicles
GROUP BY dayofweek(date_stolen)
ORDER BY dow;
-- 4. replace the numeric day of week values with the full name of each day of the week.  
SELECT dayofweek(date_stolen) AS dow, 
CASE WHEN dayofweek(date_stolen) = 1 THEN 'Sunday'
	 WHEN dayofweek(date_stolen) = 2 THEN 'Monday'
     WHEN dayofweek(date_stolen) = 3 THEN 'Tuesday'
	 WHEN dayofweek(date_stolen) = 4 THEN 'Wednesday'
	 WHEN dayofweek(date_stolen) = 5 THEN 'Thursday'
	 WHEN dayofweek(date_stolen) = 6 THEN 'Friday'
     ELSE 'Saturday' END AS day_of_week,
count(vehicle_id) AS num_vehicles
FROM stolen_vehicles
GROUP BY dayofweek(date_stolen), day_of_week
ORDER BY dow;
-- 5. Data vizualization: Create a bar chart.
-- Created bar chart in excel. 