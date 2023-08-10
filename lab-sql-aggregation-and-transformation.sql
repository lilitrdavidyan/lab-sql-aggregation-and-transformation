-- Challenge 1

-- 1.1 Shortest and longest movie durations
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration
FROM film;

-- 1.2 Average movie duration in hours and minutes
SELECT 
    FLOOR(AVG(length) / 60) AS avg_hours, 
    ROUND(AVG(length) % 60) AS avg_minutes
FROM film;

-- 2.1 Calculate the number of days that the company has been operating. 

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operational_days
FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show 
-- the month and weekday of the rental. Return 20 rows of results.
SELECT rental_date, 
       MONTH(rental_date) AS rental_month, 
       DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 Retrieve rental information and add an additional column called DAY_TYPE 
-- with values 'weekend' or 'workday', depending on the day of the week. 
-- Hint: use a conditional expression.
SELECT rental_date,
       CASE 
           WHEN DAYOFWEEK(rental_date) IN (1, 7) THEN 'weekend' 
           ELSE 'workday' 
       END AS DAY_TYPE
FROM rental;

-- 3 Film titles with NULL rental duration handled
SELECT title, 
       COALESCE(CAST(rental_duration AS CHAR), 'Not Available') AS rental_duration
FROM film
ORDER BY title;

-- 4 Personalized email campaign data
SELECT CONCAT(first_name, ' ', last_name) AS full_name, 
       SUBSTRING(email, 1, 3) AS email_start
FROM customer
ORDER BY last_name;

-- Challenge 2

-- 1.1 Total number of films
SELECT COUNT(*) AS total_films
FROM film;

-- 1.2 Number of films for each rating
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- 1.3 Number of films for each rating, sorted
SELECT rating, COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2. Number of rentals processed by each employee
SELECT staff_id, COUNT(*) AS rentals_processed
FROM rental
GROUP BY staff_id;

-- 3.1 Mean film duration for each rating
SELECT rating, ROUND(AVG(length), 2) AS average_length
FROM film
GROUP BY rating
ORDER BY average_length DESC;

-- 3.2 Ratings with mean duration over 2 hours
SELECT rating, ROUND(AVG(length), 2) AS average_length
FROM film
GROUP BY rating
HAVING average_length > 120;

-- 4. Non-repeated last names in actor
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
