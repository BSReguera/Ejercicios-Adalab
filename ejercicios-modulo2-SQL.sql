-- EJERCICIOS MODULO 2- SQL 

-- SQL - CREACION DE TABLAS
-- 0. Crear esquema para el ejercicio planteado
CREATE SCHEMA ejercicios_02;
USE ejercicios_02;

-- 1. Crear tabla de empleadas
CREATE TABLE Empleadass (
    id INT PRIMARY KEY NOT NULL,
    salario DECIMAL(10, 2),
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    pais VARCHAR(10)
);
-- 2. Crear y modificar tabla de Personas2
CREATE TABLE Personass2 (
    id INT NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    nombre VARCHAR(255),
    edad INT CHECK (edad > 16),
    ciudad VARCHAR(255) DEFAULT 'Madrid'
);
-- 3. Crear tabla Empleadas y empleadas_en_proyectos 
CREATE TABLE Empleadass (
    id_empleada INT PRIMARY KEY,
    salario DECIMAL(10, 2),
    nombre VARCHAR(255),
    apellido VARCHAR(255),
    pais VARCHAR(255)
);

-- Crear tabla empleadas_en_proyectos
CREATE TABLE empleadas_en_proyectoss (
    id_empleada INT,
    id_proyecto INT,
    PRIMARY KEY (id_empleada, id_proyecto),
    FOREIGN KEY (id_empleada) REFERENCES Empleadas(id_empleada) ON DELETE CASCADE
);
-- 4. Crear nuevo esquema y activarlo
CREATE SCHEMA creacion_tiendaa;
USE creacion_tiendaa;

-- Crear tabla customers
CREATE TABLE customers (
customer_id INT PRIMARY KEY
customer_name VARCHAR(255)
contact_name VARCHAR(255)
address VARCHAR(255)
city VARCHAR(255)
postal_code VARCHAR(10)
country VARCHAR(255)
);

-- 5. Crear tabla employees sin clave foranea
CREATE TABLE employeess (
employee_id INT PRIMARY KEY,
last_name VARCHAR(255),
first_name VARCHAR(255),
birth_date DATE,
hire_date DATE,
address VARCHAR(255),
city VARCHAR(255),
postal_code VARCHAR(10),
country VARCHAR(255)
);

-- 6. Crear tablas con FK y restricciones
-- Eliminar las tablas creadas anteriormente para recrearlas con FK y restricciones
DROP TABLE IF EXISTS customerss;
DROP TABLE IF EXISTS employeess;

-- Crear la tabla customers con FK y restricciones
CREATE TABLE customerss (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    contact_name VARCHAR(255),
    address VARCHAR(255),
    city VARCHAR(255),
    postal_code VARCHAR(10),
    country VARCHAR(255),
    credit_limit DECIMAL(10, 2) CHECK (credit_limit >= 0)
);

-- Crear la tabla employees con claves foráneas y restricciones
CREATE TABLE employeess (
    employee_id INT PRIMARY KEY,
    last_name VARCHAR(255),
    first_name VARCHAR(255),
    birth_date DATE,
    hire_date DATE,
    address VARCHAR(255),
    city VARCHAR(255),
    postal_code VARCHAR(10),
    country VARCHAR(255),
    salary DECIMAL(10, 2) CHECK (salary >= 0)
);


-- SQL - MODIFICACION E INSERCIÓN DE DATOS
-- 0. Creacion de esquema
CREATE SCHEMA ejercicio_dia2;
USE ejercicio_dia2;

-- 0. Creacion de tabla
CREATE TABLE t1 (a INTEGER, b CHAR(10));

-- 1. Renombra la tabla t1 a t2
ALTER TABLE t1
RENAME TO t2;

-- 2.  Cambiar la columna a de tipo INTEGER a tipo TINYINT NOT NULL (manteniendo el mismo nombre para la columna).
ALTER TABLE t2
MODIFY COLUMN a TINYINT NOT NULL;

-- 3. Cambia la columna b de tipo CHAR de 10 caracteres a CHAR de 20 caracteres. Además, renombra la columna como c.
ALTER TABLE t2
MODIFY COLUMN b CHAR(20);

ALTER TABLE t2
CHANGE COLUMN b c CHAR(20);

-- 4. Añade una nueva columna llamada d de tipo TIMESTAMP.
ALTER TABLE t2
ADD COLUMN d TIMESTAMP;

-- 5. Elimina la columna c que definiste en el ejercicio 3.
ALTER TABLE t2
DROP COLUMN c;

-- 6. Crea una tabla llamada t3 idéntica a la tabla t2 (de manera automática, no definiéndola columna a columna).
CREATE TABLE t3
LIKE t2;

-- 7. Elimina la tabla original t2 y en otra sentencia renombra la tabla t3 como t1.
DROP TABLE t2;
ALTER TABLE t3 RENAME TO t1;

-- 8. Para los siguientes ejercicios vamos a usar las tablas ya creadas llamadas customers (clientes/as) y employees, que están en la base de datos tienda.
-- 8. 1 Crear una copia de la tabla customers
USE tienda;

CREATE TABLE IF NOT EXISTS customers_mod 
SELECT * 
FROM customers;
-- Realiza una inserción de datos sobre la tabla customers
INSERT INTO customers_mod (customernumber, customername, contactlastname, contactfirstname, phone, addressline1, addressline2, city, state, postalcode, country, salesrepemployeeNumber, creditlimit)
VALUES
(343, 'Adalab', 'Rodriguez', 'Julia', '672986373', 'Calle Falsa 123', 'Puerta 42', 'Madrid', 'España', '28000', 'España', '15', '20000000'),
(344, 'La pegatina After','Santiago', 'Maricarmen', '00000000', 'Travesía del rave', 'NULL', 'Palma de Mallorca', 'NULL', '07005', 'España', '10', '45673453' );

-- Introduce ahora 5 filas nuevas con la información que consideres relevante para los campos disponibles en una misma instrucción.
INSERT INTO customers_mod (customername, contactlastname, contactfirstname, phone, addressline1, addressline2, city, state, postalcode, country, salesrepemployeenumber, creditlimit) 
VALUES 
('Respol', 'Perez', 'Patricia', '11135111', 'Calle Tipo 4', 'Puerta 65', 'Jaen', 'España', '28069', 'España', 5, 100000),
('Cepsa', 'Sanchez', 'Paula', '2278922', 'Calle Peta 66', 'Puerta 2', 'Huelva', 'España', '27651', 'España', 6, 200000),
('Aldi', 'Cabetas', NULL , '33479333', 'Calle 98', 'Puerta 3', 'Ciudad3', 'Estepona', 'España', '26789', 7, 300000),
('Mercadona', 'Gortazar', NULL, '44147444', 'Calle zipa 29', 'Puerta 4', 'Malaga', 'España', '24561', 'España', 8, 400000),
('Cnagase', 'Zori', NULL , '55247555', 'Calle 50x', 'Puerta 5', 'Ciudad5', 'Murcia', 'España', '27894', 9, 500000);
-- Actualizar los datos faltantes
UPDATE customers_mod
SET addressline1 = 'Polígono Industrial de Son Castelló',
    addressline2 = 'Nave 92',
    city = 'Palma de Mallorca',
    state = 'España',
    postalcode = '28123',
    country = 'España',
    salesrepemployeenumber = 25,
    creditlimit = 5000000
WHERE customername = 'La pegatina After';
-- Realizar copia de la tabla
-- Actualizar cambios sin especificar la condicion WHERE
UPDATE customers_mod
SET addressline1 = 'Vamos',
    addressline2 = 'a',
    postalcode = 'fastidiar',
    country = 'la tabla :)';
    
-- Restaurar la tabla customers_mod
-- Actualizar los datos de la tabla para que las primeras 10 empresas sean gestionadas por la representante de ventas numero 2
UPDATE customers_mod
SET salesrepemployeenumber = 2
ORDER BY customernumber
LIMIT 10;

-- Eliminar los registros que contienen 'null' en el campo 'ContactFirstName'
DELETE FROM customers_mod
WHERE contactfirstname IS NULL;

-- Eliminar los últimos 5 registros de la tabla ordenando por la columna creditLimit de mayor a menor
DELETE FROM customers_mod
ORDER BY creditlimit DESC
LIMIT 5;
-- La cláusula ORDER BY en SQL se utiliza para ordenar los resultados de una consulta según el valor de una o más columnas en orden ascendente o descendente.

-- Ejecutar la instrucción de DELETE para la tabla customers_mod olvidando el WHERE como condición
DELETE FROM customers_mod;


-- SQL - QUERIES BÁSICAS
SELECT * FROM tienda.customers;

-- 1. Realiza una consulta SELECT que obtenga los nombres, teléfonos y direcciones de todas las empresas cliente de la tabla customers.
SELECT customer_name, phone, address_line1, address_line2 
FROM customers;

-- 2. Realiza una consulta que obtenga los teléfonos y direcciones de aquellas empresas de la tabla customers que se encuentren en USA (es su país).
SELECT phone, address_line1, address_line2
FROM customers
WHERE country = 'USA';

-- 3. Realiza una consulta que obtenga los nombres y apellidos de las personas de contacto en cada empresa que no tenga segunda linea de dirección.
SELECT contact_first_name, contact_last_name
FROM customers
WHERE address_line2 IS NULL;

-- 4. Busca aquellos registros de la tabla customers que tengan un valor guardado para el campo state. Este atributo solo es valido para ciertos países por lo que habrá varias entradas con valor NULL.
SELECT *
FROM customers
WHERE state IS NOT NULL; 

-- 5. Busca aquellos registros de la tabla customers que correspondan a clientes de USA pero que no tengan un valor guardado para el campo state.
SELECT *
FROM customers
WHERE country = 'USA' AND state IS NULL;

-- 6. Selecciona el país (country) correspondiente a los registros de clientes con un límite de crédito (credit_limit) mayor que $10000.
SELECT country
FROM customers
WHERE credit_limit > 10000;


-- SQL - QUERIES AVANZADAS
-- 0. Obtengo la informacion de toda la tabla para verla. 
SELECT *
	FROM customers;

-- 1. Realiza una consulta SELECT que obtenga el número identificativo de cliente más bajo de la base de datos
SELECT MIN(customer_number) AS NumeroMinimo
	FROM customers;
    
-- 2. Selecciona el limite de crédito medio para los clientes de España.
SELECT AVG(credit_limit)
	FROM customers
		WHERE country = "Spain";

-- 3. Selecciona el numero de clientes en Francia.
SELECT COUNT(customer_name)
	FROM customers
		WHERE country = 'France';

-- 4. Selecciona el máximo de crédito que tiene cualquiera de los clientes del empleado con número 1323.
SELECT MAX(credit_limit)
	FROM customers
		WHERE 'sales_rep_employee_number' = 1323;

-- 5. ¿Cuál es el número máximo de empleado de la tabla customer?
SELECT MAX(customer_number)
	FROM customers;

-- 6. Realiza una consulta SELECT que seleccione el número de cada empleado de ventas, así como el numero de clientes distintos que tiene cada uno.
SELECT sales_rep_employee_number, COUNT(customer_number)
	FROM customers
	GROUP BY (sales_rep_employee_number);

-- 7. Selecciona el número de cada empleado de ventas que tenga más de 7 clientes distintos.
SELECT sales_rep_employee_number, COUNT(customer_number) -- No hace alta el distinct porque es una PK
	FROM customers
		GROUP BY sales_rep_employee_number
		HAVING COUNT(DISTINCT customer_number) > 7;

-- 8. Selecciona el número de cada empleado de ventas, así como el numero de clientes distintos que tiene cada uno. Asigna una etiqueta de "AltoRendimiento" a aquellos empleados con mas de 7 clientes distintos.
SELECT sales_rep_employee_number, COUNT(DISTINCT customer_number),
	CASE
		WHEN COUNT(DISTINCT customer_number) > 7 THEN "AltoRendimiento"
		END
FROM customers
GROUP BY (sales_rep_employee_number);

-- 9. Selecciona el número de clientes en cada pais.
SELECT COUNT(customer_number) AS "NumClientes", country AS "Pais"
	FROM customers
		GROUP BY (country);

-- 10. Selecciona aquellos países que tienen clientes de más de 3 ciudades diferentes.
SELECT country, COUNT(DISTINCT city)  AS "ciudades_distintas"
	FROM customers
		GROUP BY (country)
		HAVING COUNT(DISTINCT city) >3;

-- BONUS - Seleccionar  el id_ de los clientes de donde haya un mayor numero de pedidos
SELECT customer_number
	FROM customers
		WHERE country IN ("Australia", "France", "USA");


-- SQL - UNION TABLAS(JOINS)
-- 1. Selecciona el ID, nombre, apellidos de las empleadas y el ID de cada cliente asociado a ellas, usando CROSS JOIN.
SELECT `employees.employee_number`,  `employees.first_name`, `employees.last_name`, `customers.customer_number`
	FROM `employees`
	CROSS JOIN `customers`;

-- 2. Selecciona el ID, nombre, apellidos de las empleadas, para aquellas con más de 8 clientes, usando CROSS JOIN.
SELECT `employees.employee_number`, `employees.first_name`, `employees.last_namè`
	FROM `employees`
	CROSS JOIN `customers`
	GROUP BY (`employees.employee_number`)
	HAVING COUNT(DISTINCT `customers.customer_number`) > 8;

-- 3. Selecciona el nombre y apellidos de las empleadas que tienen clientes de más de un país, usando CROSS JOIN.
SELECT DISTINCT `employees.employee_number`, `employees.first_name`, `employees.last_name`, COUNT(DISTINCT `customers.country`)
	FROM `employees`
	CROSS JOIN `customers`
	GROUP BY (`employees.employee-number`)
	HAVING COUNT(DISTINCT "country") > 1;

-- 4. Selecciona el ID, nombre, apellidos de las empleadas y el ID de cada cliente asociado a ellas, usando INNER JOIN.
SELECT `employees.employee_number`, `employees.first_name`, `employees.last_name`, `customers.customer_number`
	FROM `employees`
	INNER JOIN `customers`
	ON `employees.employee_number` = `customers.sales_rep_employee_number`;

-- 5. Selecciona el ID, nombre, apellidos de las empleadas, para aquellas con más de 8 clientes, usando INNER JOIN.
SELECT `employees.employee_number`, `employees.first_name`, `employees.last_name`
	FROM `employees`
	INNER JOIN `customers`
	ON `employees.employee_number` = `customers.sales_rep_employee_number`
	GROUP BY (`employees.employee_number`)  
	HAVING COUNT(DISTINCT `customers.customer_number`)>8;

-- 6. Selecciona el nombre y apellidos de las empleadas que tienen clientes de más de un país, usando INNER JOIN.
SELECT `employees.employe_Number`, `employees.first_name`, `employees.last_name`, COUNT(DISTINCT `customers.country`)
	FROM `employees` 
	INNER JOIN `customers` ON `employees.employee_number` = `customers.sales_rep_employee_number`
	GROUP BY (`employees.employee_number`)
	HAVING COUNT(DISTINCT `customers.country`) > 1;

-- 7. Selecciona el ID, nombre, apellidos de todas las empleadas y el ID de cada cliente asociado a ellas (si es que lo tienen).
SELECT `employees.employee_number`, `employees.first_name`, `employees.last_name`, `customers.customer_number`
	FROM `employees`
	LEFT JOIN `customers`
	ON `employees.employee_number` = `customers.sales_rep_employee_number`;

-- 8. Selecciona el ID de todos los clientes, y el nombre, apellidos de las empleadas que llevan sus pedidos (si es que las hay).
SELECT `employees.employee_number`, `employees.first_name`, `employees.last_name`, `customers.customer_number`
	FROM `employees`
	RIGHT JOIN `customers`
	ON `employees.employee_number` = `customers.sales_rep_employee_number`;

-- 9. Selecciona el ID, nombre, apellidos de las empleadas, para aquellas con más de 8 clientes, usando LEFT JOIN.
SELECT `employees.employee_number`, `employees.first_name`, `employees.last_name`, COUNT(`customers.customer_number`)
	FROM `employees`
	LEFT JOIN `customers`
	ON `employees.employee_number` = `customers.sales_rep_employee_number`
	GROUP BY `employees.employee_number`
	HAVING COUNT(`customers.customer_number`)> 8;

-- 10. Selecciona el ID, nombre, apellidos de las empleadas, para aquellas con más de 8 clientes, usando RIGHT JOIN.
SELECT `employees.employee_number`, `employees.first_name`, `employees.last_name`, COUNT(`customers.customer_number`)
	FROM `customers`
	RIGHT JOIN `employees`
	ON `employees.employee_number` = `customers.sales_rep_employee_number`
	GROUP BY `employees.employee_number`
	HAVING COUNT(`customers.customer_number`);

-- 11. Selecciona el nombre y apellidos de las empleadas que tienen clientes de más de un país, usando LEFT JOIN.
SELECT `employees.employee_number`, `employees.first_name`, `employees.last_name`, COUNT(DISTINCT `customers.country`)
	FROM `employees`
	LEFT JOIN `customers`
	ON `employees.employee_number` = `customers.sales_rep_employee_number`
	GROUP BY (`employees.employee_number`)
	HAVING COUNT(DISTINCT `customers.country`)>1;


-- SQL -OPERADORES ESPECIALES DE FILTRO
-- 0. Visualización de ambas tablas
SELECT *  
FROM `customers`;

SELECT *
FROM `employees`;

-- 1. Selecciona los apellidos que se encuentren en ambas tablas para employees y customers, con alias 'Apellidos'.
SELECT e.last_name AS "Apellidos"
FROM employees e
INNER JOIN customers c ON e.last_name = c.contact_last_name;

-- 2. Selecciona los nombres con alias 'nombre' y apellidos, con alias 'Apellidos' tanto de los clientes como de los empleados de las tablas employees y customers.
SELECT e.first_name AS "Nombres", e.last_name AS "Apellidos"
FROM employees e
UNION
SELECT c.contact_first_name AS "Nombres", c.contact_last_name AS "Apellidos"
FROM customers c;

-- 3. Selecciona todos los nombres con alias 'nombre' y apellidos, con alias 'Apellidos' tanto de los clientes como de los empleados de las tablas employees y customers.
SELECT `first_name` AS "Nombres", `last_name` AS "Apellidos"
FROM `employees`
UNION ALL
SELECT `contact_first_name` AS "Nombres", `contact_last_name` AS "Apellidos"
FROM `customers`;

-- 4. Queremos ver ahora el employee_number como 'Número empleado', first_n_ame como 'nombre Empleado' y last_name como 'Apellido Empleado' para los empleados con employee_number: 1002,1076,1088 y 1612.
SELECT `employee_number` AS "Número empleado", `first_name` AS "Nombre empleado", `last_name` AS "Apellido empleado" 
FROM `employees`
WHERE `employee_number` IN (1002, 1076, 1088, 1612);

-- 5. Queremos ver ahora la 'ciudad' y los nombres de las empresas como 'nombre de la empresa ' de la tabla customers, que no estén en: Ireland, France, Germany.
SELECT `city` AS "Ciudad" , `customer_number` AS "Nombre de la empresa"
FROM `customers`
WHERE `country` NOT IN ('Ireland', 'France', 'Germany');

-- 6. Encuentra los campos nombre del cliente y ciudad, de aquellas ciudades de la tabla de customers que terminen en 'on'.
SELECT `customer_number`, `city`
FROM  `customers`
WHERE `city`LIKE '%on';

-- 7. Encuentra los campos nombre del cliente, ciudad de aquellas ciudades de la tabla de customers que terminen en 'on' y que unicamente sean de longitud 4.
SELECT `customer_name`, `city`
FROM  `customers`
WHERE `city`LIKE '%on' AND LENGTH(`city`) = 4;

-- 8. Encuentra el nombre del cliente, primera dirección y ciudad de aquellas ciudades que contengan el número 3 en su dirección postal (o lo que es lo mismo, su primera dirección).
SELECT `customer_name`, `address_line1`, `city`
FROM `customers`
WHERE `address_line1` LIKE '%3%'; 

-- 9. Encuentra el nombre del cliente, primera dirección y ciudad de aquellas ciudades que contengan el número 3 en su dirección postal y la ciudad no empiece por T.
SELECT `customer_name`, `address_line1`, `city`
FROM `customers`
WHERE `address_line1` LIKE '%3%'  AND `city` NOT LIKE 'T%'; 

-- 10. Selecciona, haciendo uso de expresiones regulares, los campos nombre del cliente, primera dirección y ciudad. Unicamente en el caso que la dirección postal, posea algún número en dicho campo.
SELECT `customer_name`, `address_line1`, `city`
FROM `customers`
WHERE `address_line1` REGEXP '[0-9]';


-- SQL - SUBCONSULTAS
-- 0. Visualización tablas
SELECT *
	FROM `customers`;
SELECT  *
	FROM `employees`;
SELECT  *
	FROM `offices`;

-- 1. Calcula el numero de clientes por cada ciudad.
SELECT `city`, COUNT(`city`) AS "numerocliente" 
	FROM `customers`
    GROUP BY `city`;

-- 2. Usando la consulta anterior como subconsulta, selecciona la ciudad con el mayor numero de clientes.
SELECT `city`
	FROM `customers`
    GROUP BY `city`
    HAVING COUNT(`customer_number`) >= ALL(SELECT COUNT(`city`) 
												FROM `customers`
												GROUP BY `city`);

-- 3. Por último, usa todas las consultas anteriores para seleccionar el customerNumber, nombre y apellido de las clientas asignadas a la ciudad con mayor numero de clientas.
SELECT `customer_number`, CONCAT(`contact_first_name`, " ", `contact_last_name`), `city`
	FROM `customers`
    WHERE `city` IN (SELECT `city`
						FROM `customers`
						GROUP BY `city`
						HAVING COUNT(`customer_number`) >= ALL(SELECT COUNT(`city`) 
																	FROM `customers`
																	GROUP BY `city`);
                                                                      
-- 4. Queremos ver ahora que empleados tienen algún contrato asignado con alguno de los clientes existentes. Para ello selecciona employeeNumber como 'Número empleado', firstName como 'nombre Empleado' y lastName como 'Apellido Empleado'
SELECT `employee_number` AS 'Numero empleado', `first_name`AS 'Nombre Empleado',  `last_name` AS 'Apellido Empleado'
	FROM `employees`  
    WHERE `employee_number` IN (SELECT `sales_rep_employee_number`
									FROM `customers`);

-- 5. Queremos ver ahora en cuantas ciudades en las cuales tenemos clientes, no también una oficina de nuestra empresa para ello: Selecciona aquellas ciudades como 'ciudad' y los nombres de las empresas como 'nombre de la empresa ' de la tabla customers, sin repeticiones, que no tengan una oficina en dicha ciudad de la tabla offices.
SELECT DISTINCT `c`.`city` AS "ciudad", `c`.`customer_name` AS "nombre empresa"
	FROM `customers` AS `c`
	WHERE `city` NOT IN (SELECT  `city`
							FROM `offices`);


-- SQL -CTEs
WITH nombre_CTE [(nombres_columnas)]
  AS (consulta_CTE);