SELECT ciudad, id_sexo, COUNT(*) AS cantidad_pacientes
FROM pacientes
GROUP BY ciudad, id_sexo
ORDER BY ciudad, cantidad_pacientes DESC;
