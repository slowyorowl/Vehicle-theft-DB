-- Objective 3: Identify where vehicles are stolenn

-- 1. Find the number of vehicles that were stolen in each region.

SELECT * FROM stolen_vehicles;
SELECT * FROM locations;

-- Combining both tables to further assess this data.
SELECT region, count(vehicle_id) AS num_vehicles
FROM stolen_vehicles sv LEFT JOIN locations l 
	ON sv.location_id = l.location_id
GROUP BY region;

-- 2. Combine the previous output with the population and density statistics for each region.

SELECT l.region, count(sv.vehicle_id) AS num_vehicles,
	l.population, l.density
FROM stolen_vehicles sv LEFT JOIN locations l 
	ON sv.location_id = l.location_id
GROUP BY l.region, l.population, l.density
ORDER BY num_vehicles DESC;

-- 3. Do types of vehicles stolen in the 3 most dense regions differ from the 3 least dense regions?

SELECT l.region, count(sv.vehicle_id) AS num_vehicles,
	l.population, l.density
FROM stolen_vehicles sv LEFT JOIN locations l 
	ON sv.location_id = l.location_id
GROUP BY l.region, l.population, l.density
ORDER BY l.density DESC;

/*
Most dense regions.
Auckland	1638	1695200	343.09
Nelson	92	54500	129.15
Wellington	420	543500	67.52

least dense regions.
Otago	139	246000	7.89
Gisborne	176	52100	6.21
Southland	26	102400	3.28
*/

(SELECT 'High Density', sv.vehicle_type, count(sv.vehicle_id) AS num_vehicles
FROM stolen_vehicles sv LEFT JOIN locations l 
	ON sv.location_id = l.location_id
WHERE l.region IN ('Auckland', 'Nelson', 'Wellington')
GROUP BY sv.vehicle_type
ORDER BY num_vehicles DESC
LIMIT 5)

-- Using a Unoin to merge both querys above.  
UNION

(SELECT 'Low Density', sv.vehicle_type, count(sv.vehicle_id) AS num_vehicles
FROM stolen_vehicles sv LEFT JOIN locations l 
	ON sv.location_id = l.location_id
WHERE l.region IN ('Otago', 'Gisborne', 'Southland')
GROUP BY sv.vehicle_type
ORDER BY num_vehicles DESC
LIMIT 5)


-- 4. Data visualisation: Create a scatter plot.

-- 5. Data visualization: Create a map. 