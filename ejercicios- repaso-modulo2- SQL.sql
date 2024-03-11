-- EJERCICIOS DE REPASO SQL 

-- EJERCICIOS JOINS
-- 1. Obtener los clientes y las películas que han alquilado.
SELECT `c`.`customer_id`, `c`.`first_name`, `c`.`last_name`, `f`.`title`
	FROM `customer` AS `c`
INNER JOIN `rental` AS `r`
	ON `c`.`customer_id` = `r`.`customer_id`
INNER JOIN `inventory` AS `i`
	ON `r`.`inventory_id` = `i`.`inventory_id`
INNER JOIN `film` AS `f`
	ON `i`.`film_id` = `f`.`film_id`;

-- 2. Obtener los actores y las películas en las que han actuado.
SELECT `a`.`actor_id`, `a`.`first_name`, `a`.`last_name`, `f`.`title`
	FROM `actor` AS `a`
INNER JOIN `film_actor` AS `fa`
    ON `a`.`actor_id` = `fa`.`actor_id`
INNER JOIN `film` AS `f`
    ON `fa`.`film_id` = `f`.`film_id`;
    
-- 3. Obtener todas las películas y, si están disponibles en inventario, mostrar la cantidad disponible.
SELECT `f`.`film_id`, `f`.`title`, COUNT(`i`.`inventory_id`) AS "cantidad_disponible"
	FROM `film` AS `f`
LEFT JOIN `inventory` AS `i`
	ON `f`.`film_id` = `i`.`film_id`
GROUP BY `f`.`film_id`;

-- 4. Obtener todos los clientes y mostrar la cantidad de alquileres que han realizado, incluso si no han realizado ningún alquiler.
SELECT `c`.`first_name`, `c`.`last_name`, COUNT(`r`.`rental_id`) AS "Cantidad_alquiler"
	FROM `customer` AS `c`
		LEFT JOIN `rental` AS `r`
			ON `c`.`customer_id` = `r`.`customer_id`
	GROUP BY `c`.`first_name`, `c`.`last_name`
    ORDER BY "Cantidad_alquiler" DESC;

-- 5. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
SELECT `f`.`title`, `a`.`actor_id`, `a`.`first_name`, `a`.`last_name`
	FROM `film` AS `f`
	LEFT JOIN `film_actor` AS `fa`
		ON `f`.`film_id` = `fa`.`film_id`
	LEFT JOIN `actor` AS `a`
		ON `fa`.`actor_id` = `a`.`actor_id`;

-- 6. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
SELECT `a`.`actor_id`, `a`.`first_name`, `a`.`last_name`, `f`.`title`
	 FROM `actor` AS `a`
	 LEFT JOIN `film_actor` AS `fa`
		ON  `a`.`actor_id` = `fa`.`actor_id`
	LEFT JOIN `film` AS `f`
		ON `fa`.`film_id` = `f`.`film_id`;


-- EJERCICIOS LIKE, NOT LIKE Y REGEXP
-- 1. Encuentra todas las películas que comienzan con la letra "A" en su título.
SELECT `film_id`, `title`
	FROM `film` 
	WHERE `title` LIKE 'A%'; -- Opcion 2- resolucion: uso de REGEXP = WHERE title REGEXP '^A';

-- 2. Encuentra todas las películas que tienen al menos una vocal en su título.
SELECT `film_id`, `title`
	FROM `film` 
	WHERE `title` REGEXP '[aeiouAEIOU]';

-- 3. Encuentra todas las películas que tienen una longitud de título de al menos 10 caracteres.
SELECT `film_id`, `title`
	FROM `film` 
	WHERE  LENGTH(`title`) >=10 ;-- Opcion 2- resolucion: uso de REGEXP = WHERE title REGEXP '.{10,}';
    
-- 4. Encuentra todas las películas cuyo título contiene la palabra "The."
SELECT `film_id`, `title`
	FROM `film` 
	WHERE `title` LIKE '%The%';

-- 5. Encuentra todas las películas cuyo título comienza con la letra "S."
SELECT `film_id`, `title`
	FROM `film` 
	WHERE  `title`LIKE 'S%';


-- EJERCICIOS UNION
-- 1. Encuentra todos los actores cuyos nombres comienzan con la letra "A" en la tabla actor, y encuentra todos los clientes cuyos nombres comienzan con la letra "B" en la tabla customer. Combina ambos conjuntos de resultados en una sola tabla.
SELECT `a`.`first_name` AS "Nombre" 
	FROM `actor` AS `a`
	WHERE `a`.`first_name` LIKE 'A%'
UNION
SELECT CONCAT(`c`.`first_name`, ' ',`c`.`last_name`) AS nombre
	FROM `customer` AS `c`
	WHERE `c`.`first_name` LIKE 'B%';

-- 2. Encuentra todas las películas cuyos títulos contienen la palabra "Comedy" en la tabla film, y encuentra todas las películas cuyo título comienza con la letra "D" en la misma tabla. Combina ambos conjuntos de resultados en una sola lista de películas.
SELECT `film_id`, `title`
	FROM `film` 
    WHERE  `title` LIKE 'Comedy%'
UNION ALL 
SELECT `film_id`, `title`
	FROM `film` 
	WHERE `title`LIKE 'D%';


-- EJERCICIOS SUBQUERIES Y QUERIES AVANZADAS
-- 1. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película "ACADEMY DINOSAUR" se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.  
SELECT DISTINCT `a`.`first_name`, `a`.`last_name`  
    FROM `rental` AS `r`
		INNER JOIN `inventory` AS `i`
			ON `r`.`inventory_id` = `i`.`inventory_id`
		INNER JOIN `film` AS `f`
			ON `i`.`film_id` = `f`.`film_id`
		INNER JOIN `film_actor` AS `fa`
			ON `f`.`film_id` = `fa`.`film_id`
		INNER JOIN `actor` AS `a`
			ON `a`.`actor_id` = `fa`.`actor_id`
		WHERE `r`.`rental_date` > (SELECT MIN(`r`.`rental_date`) 
										FROM `rental` AS `r`
										INNER JOIN `inventory`
											ON `r`.`inventory_id` = `inventory`.`inventory_id`
										INNER JOIN `film`
											ON `film`.`film_id` = `inventory`.`film_id`
										WHERE `film`.`title` = 'ACADEMY DINOSAUR')
		ORDER BY `a`.`last_name`, `a`.`first_name`;   
    
-- 2. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre "MARY SMITH" y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.
SELECT  `f`.`title`
	FROM `film` AS `f`
    INNER JOIN `inventory` AS `i`
		ON `f`.`film_id` = `i`.`film_id` 
    INNER JOIN `rental` AS `r`
		ON `i`.`inventory_id` = `r`.`inventory_id`
    INNER JOIN `customer` AS `c`
		ON `r`.`customer_id` = `c`.`customer_id`
    WHERE `c`.`first_name`= "MARY" AND `c`. `last_name` = 'SMITH' AND `r`.`return_date` IS NULL
    ORDER BY `f`.`title`;
    
-- Se procede a verificar, puesto que el OUTPUT da una tabla vacía. 
-- Verificar si hay un cliente con el nombre "MARY SMITH":
SELECT *
	FROM `customer`
	WHERE `first_name` = 'MARY' AND `last_name` = 'SMITH';
    
-- Verificar si "MARY SMITH" tiene películas actualmente alquiladas:
SELECT *
	FROM `rental` AS `r`
		JOIN `customer` AS `c`
			ON `r`.`customer_id` = `c`.`customer_id`
	WHERE `c`.`first_name` = 'MARY' AND `c`.`last_name` = 'SMITH' AND `r`.`return_date` IS NULL;
    
-- Verificar si "MARY SMITH" ha alquilado alguna película en el pasado:
SELECT *
	FROM `rental` AS `r`
		INNER JOIN `customer` AS `c`
			ON `r`.`customer_id` = `c`.`customer_id`
	WHERE `c`.`first_name` = 'MARY' AND `c`.`last_name` = 'SMITH';

-- 3. Encuentra los nombres de los clientes que han alquilado al menos 5 películas distintas. Ordena los resultados alfabéticamente por apellido.
SELECT `c`.`first_name`,`c`.`last_name`, COUNT(DISTINCT `r`.`inventory_id`) AS "num_peliculas_alquiladas"
	FROM `customer` AS `c`
	INNER JOIN `rental` AS `r`
		ON `c`.`customer_id` = `r`.`customer_id`
	GROUP BY `c`.`customer_id`, `c`.`last_name`, `c`.`first_name`
	HAVING COUNT(DISTINCT `r`.`inventory_id`) >= 5
	ORDER BY `c`.`first_name`;

-- 4. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría "Horror." Ordena los resultados alfabéticamente por apellido.
SELECT DISTINCT `a`.`first_name`, `a`.`last_name`
	FROM `actor` AS `a`
	INNER JOIN `film_actor` AS `fa`
		ON `a`.`actor_id` = `fa`.`actor_id`
	INNER JOIN `film` AS `f`
		ON `fa`.`film_id` = `f`.`film_id`
	INNER JOIN `film_category` AS `fc`
		ON `f`.`film_id` = `fc`.`film_id`
	INNER JOIN `category` AS `c`
		ON `fc`.`category_id` = `c`.`category_id`
	WHERE `c`.`name` = 'Horror'
	ORDER BY `a`.`last_name`, `a`.`first_name`;

-- 5. Encuentra los nombres de las películas que tienen la misma duración que la película con el título "GATTACA." Ordena los resultados alfabéticamente por título de película.
SELECT `f`.`title`
	FROM `film` AS `f`
	WHERE `f`.length = (SELECT length
							FROM `film`
                            WHERE `title` = 'GATTACA') AND `f`.`title` != 'GATTACA'
	ORDER BY `f`.`title`;


-- EJERCICIOS CTE's
-- 1. Encuentra el nombre de los actores que han actuado en más películas y la cantidad de películas en las que han actuado.
WITH `Actores_Peliculas` AS (SELECT `actor_id`, COUNT(*) AS `num_peliculas_actuadas`
								FROM `film_actor`
								GROUP BY `actor_id`)
	SELECT `a`.`actor_id`, `a`.`first_name`, `a`.`last_name`, `ap`.`num_peliculas_actuadas`
		FROM `actor` AS `a`
		INNER JOIN `Actores_Peliculas` AS `ap`
			ON `a`.`actor_id` = `ap`.`actor_id`
		WHERE `ap`.`num_peliculas_actuadas` = (SELECT MAX(`num_peliculas_actuadas`)
												FROM `Actores_Peliculas`);
-- 2. Encuentra las categorías de películas con la mayor cantidad de películas y la cantidad de películas en cada categoría.
WITH `Peliculas_Categorias` AS (SELECT `fc`.`category_id`, `c`.`name` AS `categoria`, COUNT(*) AS `num_peliculas`
									FROM `film_category` AS `fc`
									JOIN `category` AS `c`
										ON `fc`.`category_id` = `c`.`category_id`
									GROUP BY `fc`.`category_id`, `c`.`name`)
	SELECT `pc`.`category_id`, `pc`.`categoria`, `pc`.`num_peliculas`
		FROM `Peliculas_Categorias` AS `pc`
		WHERE `pc`.`num_peliculas` = (SELECT MAX(`num_peliculas`)
										FROM `Peliculas_Categorias`);
                                        
-- 3. Encuentra los clientes que han alquilado más películas y la cantidad de películas alquiladas por cada cliente.
WITH `Clientes_Peliculas` AS (SELECT `customer_id`, COUNT(*) AS `num_peliculas_alquiladas`
								FROM `rental`
								GROUP BY `customer_id`)
	SELECT `c`.`customer_id`, `c`.`first_name`, `c`.`last_name`, `cp`.`num_peliculas_alquiladas`
		FROM `customer` `c`
		JOIN `Clientes_Peliculas` `cp`
			ON `c`.`customer_id` = `cp`.`customer_id`
		WHERE `cp`.`num_peliculas_alquiladas` = (SELECT MAX(`num_peliculas_alquiladas`)
												FROM `Clientes_Peliculas`);
                                                
-- 4. Encuentra los actores que han actuado en películas de todas las categorías y muestra la cantidad de categorías en las que han actuado.
WITH `Actores_Categorias` AS (SELECT `fa`.`actor_id`, COUNT(DISTINCT `fc`.`category_id`) AS `num_categorias_actuadas`
								FROM `film_actor` AS `fa`
								JOIN `film_category` AS `fc`
									ON `fa`.`film_id` = `fc`.`film_id`
								GROUP BY `fa`.`actor_id`)
	SELECT `a`.`actor_id`, `a`.`first_name`, `a`.`last_name`, `ac`.`num_categorias_actuadas`
		FROM `actor` `a`
		JOIN `Actores_Categorias` `ac`
			ON `a`.`actor_id` = `ac`.`actor_id`
		WHERE `ac`.`num_categorias_actuadas` = (SELECT COUNT(*) FROM `category`);
