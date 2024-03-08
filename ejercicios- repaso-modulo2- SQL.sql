-- EJERCICIOS DE REPASO SQL

-- EJERCICIOS JOINS
Obtener los clientes y las películas que han alquilado.
Obtener los actores y las películas en las que han actuado.
Obtener todas las películas y, si están disponibles en inventario, mostrar la cantidad disponible.
Obtener todos los clientes y mostrar la cantidad de alquileres que han realizado, incluso si no han realizado ningún alquiler.
Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.

-- EJERCICIOS LIKE, NOT LIKE Y REGEXP
Encuentra todas las películas que comienzan con la letra "A" en su título.
Encuentra todas las películas que tienen al menos una vocal en su título.
Encuentra todas las películas que tienen una longitud de título de al menos 10 caracteres.
Encuentra todas las películas cuyo título contiene la palabra "The."
Encuentra todas las películas cuyo título comienza con la letra "S."

-- EJERCICIOS UNION
Encuentra todos los actores cuyos nombres comienzan con la letra "A" en la tabla actor, y encuentra todos los clientes cuyos nombres comienzan con la letra "B" en la tabla customer. Combina ambos conjuntos de resultados en una sola tabla.
Encuentra todas las películas cuyos títulos contienen la palabra "Comedy" en la tabla film, y encuentra todas las películas cuyo título comienza con la letra "D" en la misma tabla. Combina ambos conjuntos de resultados en una sola lista de películas.

-- EJERCICIOS SUBQUERIES Y QUERIES AVANZADAS
Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película "ACADEMY DINOSAUR" se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.
Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre "MARY SMITH" y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.
Encuentra los nombres de los clientes que han alquilado al menos 5 películas distintas. Ordena los resultados alfabéticamente por apellido.
Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría "Horror." Ordena los resultados alfabéticamente por apellido.
Encuentra los nombres de las películas que tienen la misma duración que la película con el título "GATTACA." Ordena los resultados alfabéticamente por título de película.

-- EJERCICIOS CTE's
Encuentra el nombre de los actores que han actuado en más películas y la cantidad de películas en las que han actuado.
Encuentra las categorías de películas con la mayor cantidad de películas y la cantidad de películas en cada categoría.
Encuentra los clientes que han alquilado más películas y la cantidad de películas alquiladas por cada cliente.
Encuentra los actores que han actuado en películas de todas las categorías y muestra la cantidad de categorías en las que han actuado.