---Creamos la vista edad que raapidamente recalcula la edad de los pacientes
CREATE VIEW vista_pacientes AS
SELECT id_paciente, nombre, fecha_nacimiento,
	EXTRACT(YEAR FROM AGE(fecha_nacimiento)) AS edad
FROM pacientes;
