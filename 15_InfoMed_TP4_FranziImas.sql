SELECT
p.nombre AS nombre_paciente,
c.fecha AS FechaUltimaConsulta,
c.diagnostico AS Diagnostico
FROM Pacientes p
LEFT JOIN Consultas c ON p.id_paciente=c.id_paciente
WHERE c.fecha=(SELECT MAX(fecha) ---como se filtra por fecha, el where hace que los pacientes sin consultas no se muestren
FROM Consultas
WHERE id_paciente=p.id_paciente);
