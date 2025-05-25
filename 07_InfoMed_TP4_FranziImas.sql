SELECT ciudad, COUNT(*) AS cantidad_pacientes
FROM pacientes
GROUP BY ciudad
ORDER BY cantidad_pacientes DESC;
