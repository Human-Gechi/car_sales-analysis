-- What are the most popular car makes
SELECT car_make,
	COUNT(*) as occurence
FROM car_listings
GROUP BY car_make, car_model
ORDER BY occurence desc
LIMIT 10
-- What are the most popular car_models listed?
SELECT car_make,
		car_model,
		COUNT(*) as occurence
FROM car_listings
GROUP BY car_make,car_model
ORDER BY occurence desc
LIMIT 5

SELECT car_make,
		car_model,
		year,
		COUNT(*) as occurence
FROM car_listings
GROUP BY car_make,car_model,year
ORDER BY occurence desc
LIMIT 5

-- Which car brands retain their value the best (based on average price vs. year)
WITH avg_prices AS ( -- cte (common table expression)
    SELECT 
        car_make,
        year,
        AVG(price) AS avg_price
    FROM car_listings
    GROUP BY car_make, year
),
depreciation AS (
    SELECT
        ap_new.car_make,
        ap_new.avg_price AS newest_price,
        ap_old.avg_price AS oldest_price,
        ROUND(
          ((ap_new.avg_price - ap_old.avg_price) / ap_new.avg_price) * 100, 2
        ) AS depreciation_pct
    FROM
        avg_prices AS ap_new
    JOIN
        avg_prices AS ap_old
        ON ap_new.car_make = ap_old.car_make
    JOIN
        (SELECT car_make, MAX(year) AS max_year /*new-price*/, MIN(year) AS min_year -- aliased as old_price.
         FROM avg_prices
         GROUP BY car_make) years
        ON ap_new.car_make = years.car_make
        AND ap_new.year = years.max_year
        AND ap_old.year = years.min_year
)
SELECT
    car_make,
    newest_price,
    oldest_price,
    depreciation_pct
FROM
    depreciation
ORDER BY
    depreciation_pct DESC;
-- Are certain colors more popular (or more expensive)?
--1.most popular color
Select color,
	count(*) as colors_count
	from car_listings
	Group By color
order by colors_count desc
limit 1;
-- 2. how colors affect price
SELECT color,
	AVG(price) as avg_price,
	COUNT(*)
FROM car_listings
GROUP BY color
ORDER BY avg_price desc
;
-- What fuel types are most commonly listed? Is electric/hybrid adoption growing?
SELECT fuel_type,
COUNT(*) 
FROM car_Listings
GROUP BY fuel_type
ORDER BY count 
-- What is the average price by car_make?
SELECT 
    car_make, 
    AVG(price) AS average_price
FROM car_listings
GROUP BY car_make
ORDER BY average_price desc;
--How does mileage affect price? (price vs. mileage regression)
SELECT 
	CONCAT(
 	 FLOOR(mileage / 10000) * 10000,
  		'-',
  	FLOOR(mileage / 10000) * 10000 + 9999
	) AS mileage_range,
	COUNT(*),
	AVG(price) as average_price,
	car_make
FROM car_listings
WHERE price IS NOT NULL and mileage IS NOT NULL
GROUP BY mileage_range,car_make
ORDER BY average_price DESC
LIMIT 5
--What’s the price difference between automatic vs. manual transmission cars?
SELECT 
	ROUND(avg(price),0) as average,
	transmission
FROM car_listings
GROUP BY transmission
ORDER BY average
-- How do prices vary by condition? (new, used, like new, etc.)
SELECT 
	AVG(price) as average_price,
	MIN(price) AS min_price,
    MAX(price) AS max_price,
	condition,
	count(*)
FROM car_listings
GROUP BY condition
ORDER BY average_price,min_price,max_price
-- Are cars with “accidents” significantly cheaper than non-accident vehicles?
--- counting accident cars and non accident cars
SELECT
	accident,
	round(avg(price),0) as avg_price
FROM car_listings
GROUP BY accident
ORDER BY avg_price
--Which cars hold their value best after 5 years?
WITH avg_prices AS (
    SELECT 
        car_make,
        year,
        AVG(price) AS avg_price
    FROM car_listings
    GROUP BY car_make, year
),
paired_years AS (
    SELECT
        price1.car_make,
        price1.year AS start_year,
        price1.avg_price AS start_price,
        price2.year AS end_year,
        price2.avg_price AS end_price,
        ROUND(
          ((price1.avg_price - price2.avg_price) / price.avg_price) * 100, 2
        ) AS depreciation_pct,
        ROUND(
          (price2.avg_price / price1.avg_price) * 100, 2
        ) AS value_retention_pct
    FROM
        avg_prices price
    JOIN
        avg_prices price2 ON price1.car_make = price2.car_make 
		AND price2.year = price1.year + 5
)
SELECT
    car_make,
    start_year,
    end_year,
    value_retention_pct
FROM
    paired_years
ORDER BY
    value_retention_pct DESC
	LIMIT 5
--Which optional features are most common in higher-priced vehicles
SELECT
  TRIM(feature) AS feature, -- remove any whitespace
  ROUND(AVG(price), 0) AS avg_price, -- round average price to whole number
  COUNT(*) AS listings_with_feature
FROM
  car_listings,
  UNNEST(STRING_TO_ARRAY(options_features, ',')) AS feature -- UNNEST turns an array into a set of rows for the options_feature column wiith comma seperated values
GROUP BY
  TRIM(feature)
ORDER BY
  avg_price DESC
LIMIT 5;
-- Which features are most frequently included by brand or model?
SELECT
  TRIM(feature) AS feature, -- remove any whitespace
  car_make,
  count(*)
FROM
  car_listings,
  UNNEST(STRING_TO_ARRAY(options_features, ',')) AS feature -- UNNEST turns an array into a set of rows for the options_feature column wiith comma seperated values
GROUP BY
  TRIM(feature), car_make
ORDER BY count(*) DESC
--Which makes/models are more likely to be sold with accident history?
SELECT car_make,
	accident,
	COUNT(*)
	from car_listings
	WHERE accident = 'True'
	GROUP BY accident,car_make
	ORDER BY count DESC
LIMIT 5
--What is the distribution of cars by year? (Are newer or older cars more common?)
SELECT COUNT(car_make) as carcount,
	year
FROM car_listings
	WHERE condition = 'New' OR condition ='Used'
	GROUP BY year 
	ORDER BY year desc
-- Average Price by Fuel Type
SELECT round(AVG(price),0) as avg_price,
	fuel_type
	FROM car_listings
	GROUP BY fuel_type 
	ORDER BY avg_price desc 