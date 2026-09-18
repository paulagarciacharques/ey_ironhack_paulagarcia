SELECT u.nombre_usuario, v.titulo
FROM Usuarios u
JOIN Videos v
ON u.id_usuario = v.id_usuario;