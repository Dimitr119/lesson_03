/*
 Завдання на SQL до лекції 03.
 */


/*
1.
Вивести кількість фільмів в кожній категорії.
Результат відсортувати за спаданням.
*/
-- SQL code goes here...
SELECT 
	category_id, 
	COUNT(*)
FROM 
	film_category
GROUP BY 
	category_id
ORDER BY COUNT(*) DESC


/*
2.
Вивести 10 акторів, чиї фільми брали на прокат найбільше.
Результат відсортувати за спаданням.
*/
-- SQL code goes here...
SELECT 
	a.first_name, a.last_name, SUM(f.rental_duration) AS total_rental_duration
FROM 
	actor a
JOIN 
	film_actor fa ON a.actor_id = fa.actor_id
JOIN 
	film f ON fa.film_id = f.film_id
GROUP BY 
	a.first_name, 
	a.last_name
ORDER BY 
	total_rental_duration DESC
LIMIT 10;

/*
3.
Вивести категорія фільмів, на яку було витрачено найбільше грошей
в прокаті
*/
-- SQL code goes here...
SELECT
    c.name AS category_name,
    SUM(pm.amount) AS total_amount_numeric
FROM
    payment pm
JOIN
    rental r ON pm.rental_id = r.rental_id
JOIN
    inventory i ON r.inventory_id = i.inventory_id
JOIN
    film_category fc ON i.film_id = fc.film_id
JOIN
    category c ON fc.category_id = c.category_id
GROUP BY
    c.name;

/*
4.
Вивести назви фільмів, яких не має в inventory.
Запит має бути без оператора IN
*/
-- SQL code goes here...
SELECT
    f.title AS film_title,
	f.film_id
FROM
    film f
LEFT JOIN
    inventory i ON f.film_id = i.film_id
WHERE
    i.film_id IS NULL;

/*
5.
Вивести топ 3 актори, які найбільше зʼявлялись в категорії фільмів “Children”.
*/
-- SQL code goes here...
SELECT
    a.first_name,
    a.last_name,
	COUNT(a.first_name)
FROM
    actor a
JOIN
    film_actor fa ON a.actor_id = fa.actor_id
JOIN
    film_category fc ON fa.film_id = fc.film_id
JOIN
    category c ON fc.category_id = c.category_id
WHERE
    c.name = 'Children'
GROUP BY
    a.actor_id, a.first_name, a.last_name
ORDER BY
    COUNT(DISTINCT fa.film_id) DESC
LIMIT 3;