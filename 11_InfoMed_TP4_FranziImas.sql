SELECT pa.nombre AS nombre_paciente, co.id_consulta, co.fecha, co.diagnostico
FROM consultas co
JOIN pacientes pa ON co.id_paciente=pa.id_paciente
WHERE co.fecha BETWEEN '2024-08-01' AND '2024-08-31'
ORDER BY co.fecha;
