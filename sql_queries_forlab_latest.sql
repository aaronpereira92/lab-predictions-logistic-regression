

/* This is my final SQL query
 The question has been changed to find out if no. of rentals will equal or greater for August than July. 
 And here I joined two sql queries based on the film_id. In one query I counted rentals for August
 In the other query I counted rentals for July. And then added an extra column comparing which is greater.
This new column is called more_rents_august, and returns a 'True' or 'False' string value 
*/

SELECT * , 
CASE 
WHEN rented_august >= rented_july THEN 'True'
ELSE 'False'
END AS more_rents_august
FROM ( SELECT f.film_id, f.title, c.name AS category_name, f.rental_duration, f.rental_rate, f.rating, count(r.rental_id) AS rented_august 
FROM rental AS r 
RIGHT JOIN inventory AS i
ON r.inventory_id = i.inventory_id 
RIGHT JOIN film AS f
ON i.film_id = f.film_id
RIGHT JOIN film_category AS fc
ON f.film_id = fc.film_id
RIGHT JOIN category AS c
ON fc.category_id = c.category_id
WHERE DATE(r.rental_date) BETWEEN '2005-08-01' AND '2005-08-31'
GROUP BY f.film_id
ORDER BY f.film_id) AS A
JOIN (SELECT f.film_id, count(r.rental_id) AS rented_july 
FROM rental AS r 
RIGHT JOIN inventory AS i
ON r.inventory_id = i.inventory_id 
RIGHT JOIN film AS f
ON i.film_id = f.film_id
RIGHT JOIN film_category AS fc
ON f.film_id = fc.film_id
RIGHT JOIN category AS c
ON fc.category_id = c.category_id
WHERE DATE(r.rental_date) BETWEEN '2005-07-01' AND '2005-07-31'
GROUP BY f.film_id
ORDER BY f.film_id) AS B

ON A.film_id=B.film_id

