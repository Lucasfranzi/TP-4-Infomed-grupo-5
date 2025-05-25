SELECT M.nombre, r.id_medico, COUNT(r.id_receta) AS cantidad_recetas
FROM recetas r
JOIN medicos M ON r.id_medico =M.id_medico
GROUP BY M.nombre, r.id_medico
ORDER BY cantidad_recetas DESC;
