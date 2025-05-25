CREATE VIEW vista_pacientes AS
SELECT id_oaciente, nombre, fecha_nacimiento,
	EXTRACT(YEAR FROM AGE(fecha_nacimiento)) AS edad
FROM pacientes;
