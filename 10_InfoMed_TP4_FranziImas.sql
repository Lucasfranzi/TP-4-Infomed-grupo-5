SELECT M.nombre AS nombre_medico, r.id_receta, r.fecha,r.id_paciente,r.descripcion
FROM recetas r
JOIN medicos M ON r.id_medico=M.id_medico
WHERE r.id_medico=3
AND r.fecha BETWEEN '2024-08-01' AND '2024-08-31'
ORDER BY r.fecha;
---verificacion
SELECT fecha FROM recetas WHERE id_medico=3 ORDER BY fecha;
