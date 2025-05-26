SELECT pa.nombre AS nombre_paciente, COUNT (*) AS cantidad_recetas
FROM recetas r 
JOIN pacientes pa ON r.id_paciente=pa.id_paciente
GROUP BY pa.nombre
ORDER BY cantidad_recetas DESC;
