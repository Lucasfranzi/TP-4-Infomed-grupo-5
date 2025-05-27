SELECT me.nombre AS NombreMedicamento, COUNT(r.id_receta) AS TotalRecetas,m.nombre AS NombreMedico,p.nombre AS NombrePaciente
FROM Medicamentos me
JOIN  Recetas r ON me.id_medicamento = r.id_medicamento
JOIN Medicos m ON r.id_medico = m.id_medico ---une medico con receta
JOIN Pacientes p ON r.id_paciente = p.id_paciente ---une receta con paciente
GROUP BY me.id_medicamento, m.id_medico, p.id_paciente 
ORDER BY TotalRecetas DESC;
