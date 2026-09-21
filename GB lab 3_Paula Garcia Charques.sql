SELECT * FROM clientes;
SELECT * FROM empleados;
SELECT * FROM tiendas;
SELECT * FROM prendas;
SELECT * FROM clientes
WHERE nombre_cliente LIKE 'L%';
SELECT COUNT(*) AS total_clientes
FROM clientes;
SELECT * FROM compras
WHERE fecha_compra > '2023-05-01';
UPDATE clientes
SET email_cliente = 'nuevo@email.com'
WHERE id_cliente = 123;
UPDATE clientes
SET email_cliente = 'nuevo@email.com'
WHERE id_cliente = 123;
DELETE FROM clientes
WHERE id_cliente = 123;
SELECT * FROM prendas
WHERE color = 'Negro';
SELECT * FROM tiendas
WHERE ciudad = 'Madrid';
SELECT COUNT(*) AS prendas_caras
FROM prendas
WHERE precio > 50;
SELECT * FROM empleados
WHERE tienda_id = 1;
SELECT * FROM clientes
WHERE nombre_cliente LIKE '%Andrés%';
SELECT * FROM compras
WHERE id_cliente = 2;
DELETE FROM compras
WHERE monto_total < 30;
SELECT * FROM prendas
WHERE precio BETWEEN 20 AND 40;
SELECT * FROM empleados
WHERE nombre_empleado LIKE '%a%';
SELECT * FROM prendas
ORDER BY precio DESC
LIMIT 5;
SELECT * FROM compras
WHERE monto_total > 75;
SELECT * FROM prendas
WHERE talla = 'M';
UPDATE prendas
SET talla = 'NuevaTalla'
WHERE id_prenda = 123;
SELECT * FROM empleados
WHERE fecha_contratacion > '2022-01-01';
SELECT * FROM tiendas
WHERE ciudad = 'Barcelona';
DELETE FROM empleados
WHERE id_empleado = 123;
SELECT * FROM compras
WHERE fecha_compra < '2023-07-01';
SELECT * FROM prendas
WHERE tipo_prenda LIKE '%eta';
SELECT * FROM clientes
WHERE email_cliente NOT LIKE '%hotmail%';
SELECT COUNT(*) AS compras_septiembre
FROM compras
WHERE fecha_compra BETWEEN '2023-09-01' AND '2023-09-30';
SELECT * FROM prendas
WHERE tipo_prenda = 'Camiseta';
DELETE FROM prendas
WHERE precio < 20;
SELECT * FROM tiendas
ORDER BY ciudad ASC;
SELECT * FROM empleados
WHERE puesto = 'Vendedor';
SELECT COUNT(*) AS prendas_blancas
FROM prendas
WHERE color = 'Blanco';
SELECT * FROM clientes
WHERE LENGTH(nombre_cliente) > 10;
SELECT COUNT(*) AS prendas_blancas
FROM prendas
WHERE color = 'Blanco';
SELECT * FROM clientes
WHERE LENGTH(nombre_cliente) > 10;
SELECT * FROM compras
WHERE monto_total BETWEEN 50 AND 100;
SELECT * FROM compras
ORDER BY fecha_compra DESC
LIMIT 3;
SELECT * FROM cursos
WHERE nombre LIKE '%Digital%';
SELECT color, COUNT(*) AS cantidad
FROM prendas
GROUP BY color;
INSERT INTO tiendas (nombre_tienda, direccion, ciudad, pais)
VALUES ('Tienda Norte', 'Calle A 123', 'Madrid', 'España'),
       ('Tienda Sur', 'Calle B 456', 'Madrid', 'España');
UPDATE clientes
SET nombre_cliente = 'Micaela Torres',
    email_cliente = 'micaela.torres@nuevocorreo.com'
WHERE nombre_cliente = 'Miguel Torres';
