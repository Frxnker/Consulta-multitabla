DROP DATABASE IF EXISTS empleados;
CREATE DATABASE empleados CHARACTER SET utf8mb4;
USE empleados;

CREATE TABLE departamento (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  presupuesto DOUBLE UNSIGNED NOT NULL,
  gastos DOUBLE UNSIGNED NOT NULL
);

CREATE TABLE empleado (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nif VARCHAR(9) NOT NULL UNIQUE,
  nombre VARCHAR(100) NOT NULL,
  apellido1 VARCHAR(100) NOT NULL,
  apellido2 VARCHAR(100),
  id_departamento INT UNSIGNED,
  FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);

INSERT INTO departamento VALUES(1, 'Desarrollo', 120000, 6000);
INSERT INTO departamento VALUES(2, 'Sistemas', 150000, 21000);
INSERT INTO departamento VALUES(3, 'Recursos Humanos', 280000, 25000);
INSERT INTO departamento VALUES(4, 'Contabilidad', 110000, 3000);
INSERT INTO departamento VALUES(5, 'I+D', 375000, 380000);
INSERT INTO departamento VALUES(6, 'Proyectos', 0, 0);
INSERT INTO departamento VALUES(7, 'Publicidad', 0, 1000);

INSERT INTO empleado VALUES(1, '32481596F', 'Aarón', 'Rivero', 'Gómez', 1);
INSERT INTO empleado VALUES(2, 'Y5575632D', 'Adela', 'Salas', 'Díaz', 2);
INSERT INTO empleado VALUES(3, 'R6970642B', 'Adolfo', 'Rubio', 'Flores', 3);
INSERT INTO empleado VALUES(4, '77705545E', 'Adrián', 'Suárez', NULL, 4);
INSERT INTO empleado VALUES(5, '17087203C', 'Marcos', 'Loyola', 'Méndez', 5);
INSERT INTO empleado VALUES(6, '38382980M', 'María', 'Santana', 'Moreno', 1);
INSERT INTO empleado VALUES(7, '80576669X', 'Pilar', 'Ruiz', NULL, 2);
INSERT INTO empleado VALUES(8, '71651431Z', 'Pepe', 'Ruiz', 'Santana', 3);
INSERT INTO empleado VALUES(9, '56399183D', 'Juan', 'Gómez', 'López', 2);
INSERT INTO empleado VALUES(10, '46384486H', 'Diego','Flores', 'Salas', 5);
INSERT INTO empleado VALUES(11, '67389283A', 'Marta','Herrera', 'Gil', 1);
INSERT INTO empleado VALUES(12, '41234836R', 'Irene','Salas', 'Flores', NULL);
INSERT INTO empleado VALUES(13, '82635162B', 'Juan Antonio','Sáez', 'Guerrero', NULL);

/*
Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. 
Este listado también debe incluir los empleados que no tienen ningún departamento asociado.
*/
SELECT empleado.*, departamento.nombre AS nombre_departamento, departamento.presupuesto, departamento.gastos
FROM empleado
LEFT JOIN departamento ON empleado.id_departamento = departamento.id;

SELECT empleado.*, departamento.nombre AS nombre_departamento, departamento.presupuesto, departamento.gastos
FROM departamento
RIGHT JOIN empleado ON departamento.id = empleado.id_departamento;

/*
Devuelve un listado donde sólo aparezcan aquellos empleados que no tienen ningún departamento asociado.
*/
SELECT empleado.*
FROM empleado
LEFT JOIN departamento ON empleado.id_departamento = departamento.id
WHERE departamento.id IS NULL;

SELECT empleado.*
FROM departamento
RIGHT JOIN empleado ON empleado.id_departamento = departamento.id
WHERE empleado.id_departamento IS NULL;

/*
Devuelve un listado donde sólo aparezcan aquellos departamentos que no tienen ningún empleado asociado.
*/
SELECT departamento.*
FROM departamento
LEFT JOIN empleado ON departamento.id = empleado.id_departamento
WHERE empleado.id IS NULL;

SELECT departamento.*
FROM empleado
RIGHT JOIN departamento ON empleado.id_departamento = departamento.id
WHERE empleado.id IS NULL;

/*
Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. 
El listado debe incluir los empleados que no tienen ningún departamento asociado y los departamentos que no tienen ningún empleado asociado. 
Ordene el listado alfabéticamente por el nombre del departamento.
*/
SELECT empleado.*, departamento.nombre AS nombre_departamento, departamento.presupuesto, departamento.gastos
FROM empleado
LEFT JOIN departamento ON empleado.id_departamento = departamento.id
ORDER BY nombre_departamento;

SELECT empleado.*, departamento.nombre AS nombre_departamento, departamento.presupuesto, departamento.gastos
FROM departamento
RIGHT JOIN empleado ON departamento.id = empleado.id_departamento
ORDER BY nombre_departamento;

/*
Devuelve un listado con los empleados que no tienen ningún departamento asociado y los departamentos que no tienen ningún empleado asociado. 
Ordene el listado alfabéticamente por el nombre del departamento.
*/
SELECT empleado.*, departamento.nombre AS nombre_departamento, departamento.presupuesto, departamento.gastos
FROM departamento
RIGHT JOIN empleado ON departamento.id = empleado.id_departamento
WHERE empleado.id IS NULL

UNION

SELECT NULL AS id, NULL AS nif, NULL AS nombre, NULL AS apellido1, NULL AS apellido2, departamento.id AS id_departamento, departamento.nombre AS nombre_departamento, departamento.presupuesto, departamento.gastos
FROM departamento
LEFT JOIN empleado ON departamento.id = empleado.id_departamento
WHERE empleado.id IS NULL
ORDER BY nombre_departamento;