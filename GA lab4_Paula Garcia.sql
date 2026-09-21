-- 1. Clientes y sus compras (nombre + monto)
SELECT c.nombre_cliente, co.monto_total
FROM clientes c
JOIN compras co ON c.id_cliente = co.id_cliente;

-- 2. Empleados y tienda donde trabajan
SELECT e.nombre_empleado, t.nombre_tienda
FROM empleados e
JOIN tiendas t ON e.tienda_id = t.id_tienda;

-- 3. Prendas compradas y nombre del cliente
SELECT p.tipo_prenda, c.nombre_cliente
FROM detalle_compras dc
JOIN prendas p       ON dc.id_prenda = p.id_prenda
JOIN compras co      ON dc.id_compra = co.id_compra
JOIN clientes c      ON co.id_cliente = c.id_cliente;

-- 4. Total de compras por cliente
SELECT c.nombre_cliente, SUM(co.monto_total) AS total_compras
FROM clientes c
JOIN compras co ON c.id_cliente = co.id_cliente
GROUP BY c.id_cliente, c.nombre_cliente;

-- 5. Empleados que han vendido prendas rojas
SELECT DISTINCT e.nombre_empleado, p.tipo_prenda
FROM detalle_compras dc
JOIN prendas p   ON dc.id_prenda = p.id_prenda
JOIN compras co  ON dc.id_compra = co.id_compra
JOIN empleados e ON co.id_empleado = e.id_empleado
WHERE p.color = 'Rojo';

-- 6. Cantidad de prendas vendidas por tienda
SELECT t.nombre_tienda, SUM(dc.cantidad) AS total_prendas_vendidas
FROM tiendas t
JOIN compras co       ON t.id_tienda = co.id_tienda
JOIN detalle_compras dc ON co.id_compra = dc.id_compra
GROUP BY t.id_tienda, t.nombre_tienda;

-- 7. Clientes con compras > 100
SELECT c.nombre_cliente, co.monto_total
FROM clientes c
JOIN compras co ON c.id_cliente = co.id_cliente
WHERE co.monto_total > 100;

-- 8. Tipos de prendas y cuántas se han comprado
SELECT p.tipo_prenda, SUM(dc.cantidad) AS cantidad_vendida
FROM prendas p
JOIN detalle_compras dc ON p.id_prenda = dc.id_prenda
GROUP BY p.tipo_prenda;

-- 9. Prendas compradas por más de un cliente
SELECT p.tipo_prenda, COUNT(DISTINCT co.id_cliente) AS num_clientes
FROM prendas p
JOIN detalle_compras dc ON p.id_prenda = dc.id_prenda
JOIN compras co         ON dc.id_compra = co.id_compra
GROUP BY p.id_prenda, p.tipo_prenda
HAVING COUNT(DISTINCT co.id_cliente) > 1;

-- 10. Compras en una tienda específica (por nombre)
SELECT c.nombre_cliente, co.monto_total
FROM compras co
JOIN clientes c ON co.id_cliente = c.id_cliente
JOIN tiendas t  ON co.id_tienda = t.id_tienda
WHERE t.nombre_tienda = 'Nombre de la tienda';

-- 11. Empleados que trabajan en tiendas en Madrid
SELECT e.nombre_empleado, t.nombre_tienda
FROM empleados e
JOIN tiendas t ON e.tienda_id = t.id_tienda
WHERE t.ciudad = 'Madrid';

-- 12. Clientes sin compras
SELECT c.nombre_cliente, c.email_cliente
FROM clientes c
LEFT JOIN compras co ON c.id_cliente = co.id_cliente
WHERE co.id_compra IS NULL;

-- 13. Tienda con mayor número de empleados
SELECT t.nombre_tienda, COUNT(e.id_empleado) AS num_empleados
FROM tiendas t
JOIN empleados e ON t.id_tienda = e.tienda_id
GROUP BY t.id_tienda, t.nombre_tienda
ORDER BY num_empleados DESC
LIMIT 1;

-- 14. Monto total de compras por empleado
SELECT e.nombre_empleado, SUM(co.monto_total) AS total_vendido
FROM empleados e
JOIN compras co ON e.id_empleado = co.id_empleado
GROUP BY e.id_empleado, e.nombre_empleado;

-- 15. Compras en septiembre 2023 (cliente + fecha)
SELECT c.nombre_cliente, co.fecha_compra
FROM compras co
JOIN clientes c ON co.id_cliente = c.id_cliente
WHERE co.fecha_compra BETWEEN '2023-09-01' AND '2023-09-30';

-- 16. Clientes y tiendas donde han comprado
SELECT DISTINCT c.nombre_cliente, t.nombre_tienda
FROM clientes c
JOIN compras co ON c.id_cliente = co.id_cliente
JOIN tiendas t  ON co.id_tienda = t.id_tienda;

-- 17. Prendas con precio promedio > 40
SELECT p.tipo_prenda, AVG(p.precio) AS precio_promedio
FROM prendas p
GROUP BY p.tipo_prenda
HAVING AVG(p.precio) > 40;

-- 18. Empleados y cantidad de compras gestionadas
SELECT e.nombre_empleado, COUNT(co.id_compra) AS num_compras
FROM empleados e
LEFT JOIN compras co ON e.id_empleado = co.id_empleado
GROUP BY e.id_empleado, e.nombre_empleado;

-- 19. Clientes con más de 3 compras
SELECT c.nombre_cliente, COUNT(co.id_compra) AS num_compras
FROM clientes c
JOIN compras co ON c.id_cliente = co.id_cliente
GROUP BY c.id_cliente, c.nombre_cliente
HAVING COUNT(co.id_compra) > 3;

-- 20. Total de ventas por tipo de prenda
SELECT p.tipo_prenda, SUM(dc.cantidad * p.precio) AS monto_total_vendido
FROM prendas p
JOIN detalle_compras dc ON p.id_prenda = dc.id_prenda
JOIN compras co         ON dc.id_compra = co.id_compra
GROUP BY p.tipo_prenda;

-- 21. CASE WHEN según monto total de compras por cliente
SELECT c.nombre_cliente,
       SUM(co.monto_total) AS total_compras,
       CASE
           WHEN SUM(co.monto_total) < 50  THEN 'Bajo'
           WHEN SUM(co.monto_total) BETWEEN 50 AND 150 THEN 'Medio'
           ELSE 'Alto'
       END AS categoria_gasto
FROM clientes c
LEFT JOIN compras co ON c.id_cliente = co.id_cliente
GROUP BY c.id_cliente, c.nombre_cliente;

-- 22. Incrementar precio de "Zapatos" en 10%
UPDATE prendas
SET precio = precio * 1.10
WHERE tipo_prenda = 'Zapatos';

-- 23. Alterar tabla clientes para agregar telefono_cliente
ALTER TABLE clientes
ADD COLUMN telefono_cliente VARCHAR(20);

-- 24. Número total de compras y promedio de gasto por cliente
SELECT c.nombre_cliente,
       COUNT(co.id_compra) AS num_compras,
       AVG(co.monto_total) AS promedio_gasto
FROM clientes c
LEFT JOIN compras co ON c.id_cliente = co.id_cliente
GROUP BY c.id_cliente, c.nombre_cliente;

-- 25. Eliminar prendas con precio < 10
DELETE FROM prendas
WHERE precio < 10;

-- 26. Nombre de clientes y cantidad total gastada
SELECT c.nombre_cliente, SUM(co.monto_total) AS total_gastado
FROM clientes c
JOIN compras co ON c.id_cliente = co.id_cliente
GROUP BY c.id_cliente, c.nombre_cliente;

-- 27. Informe: empleado y cantidad de compras por tienda
SELECT e.nombre_empleado, t.nombre_tienda, COUNT(co.id_compra) AS num_compras
FROM empleados e
JOIN compras co ON e.id_empleado = co.id_empleado
JOIN tiendas t  ON co.id_tienda = t.id_tienda
GROUP BY e.id_empleado, e.nombre_empleado, t.id_tienda, t.nombre_tienda;

-- 28. Cliente que ha realizado la compra más alta
SELECT c.nombre_cliente, co.monto_total
FROM clientes c
JOIN compras co ON c.id_cliente = co.id_cliente
WHERE co.monto_total = (
    SELECT MAX(monto_total) FROM compras
);

-- 29. Actualizar ciudad de la tienda "Zara Gran Vía" a Madrid
UPDATE tiendas
SET ciudad = 'Madrid'
WHERE nombre_tienda = 'Zara Gran Vía';

-- 30. Clientes que han realizado compras (EXISTS)
SELECT c.nombre_cliente
FROM clientes c
WHERE EXISTS (
    SELECT 1
    FROM compras co
    WHERE co.id_cliente = c.id_cliente
);
