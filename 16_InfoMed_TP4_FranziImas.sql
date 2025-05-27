SELECT 
m.nombre AS NombreMedico, p.nombre AS NombrePaciente,
COUNT (c.id_consulta) AS TotalConsultas
FROM Medicos m
JOIN Consultas c ON m.id_medico = c.id_medico --se une con la tabla de medicos segun el id de consulta
JOIN Pacientes p ON c.id_paciente=p.id_paciente --se une con la tabla de medicos segun la consulta del paciente con ese medico
GROUP BY m.id_medico, p.id_paciente --agrupa todas las consultas realizadas por un mismo medico a un mismo paciente
ORDER BY m.nombre, p.nombre;
