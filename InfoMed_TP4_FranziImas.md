# Trabajo Práctico 4 - Informática en Medicina

## Integrantes
Franzi, Lucas
Imas Navarro, Justina

## Docentes

- Eugenia Uberrino
- Melina Piacentino

## Institución

## Parte 1

**Descripción**: Listar todos los pacientes registrados.
PARTE 1: Bases de Datos 
Base de datos centro médico 

Se desea diseñar una base de datos relacional que almacene la información sobre los pacientes, médicos, recetas y consultas en un centro de salud. En la actualidad, la gestión de esta información se lleva a cabo del siguiente modo: Cuando una persona acude al centro de salud, se le toma nota en una ficha con sus datos personales: nombre, fecha de nacimiento, sexo biológico y dirección (calle, número y ciudad). Esta ficha queda registrada en el archivo de pacientes del centro. Los médicos del centro también tienen su ficha, donde se registran su nombre completo, especialidad y dirección profesional. Cada vez que un médico realiza una consulta o tratamiento a un paciente, puede emitir una receta. Esta receta incluye la fecha, el nombre del paciente atendido, el médico que la emite, el medicamento o tratamiento indicado, y la enfermedad o condición que motivó la prescripción. Esta información queda registrada y organizada para facilitar tanto el seguimiento del paciente como las auditorías clínicas. Los tratamientos pueden incluir medicamentos, indicaciones como reposo o fisioterapia, y suelen tener especificaciones temporales (por ejemplo, “tomar por 5 días” o “uso indefinido”). También se registran enfermedades o diagnósticos asociados, permitiendo análisis estadísticos o seguimiento epidemiológico. 

El sistema busca reemplazar los registros en papel por una solución digital que permita realizar búsquedas rápidas, obtener estadísticas de distribución demográfica, sexo y especialidad, y mantener la información organizada para su integración con otros módulos médicos como historiales clínicos, turnos o recetas médicas. 

Nota: La implementación hecha por la cátedra de esta base de datos está en el archivo previamente compartido “base_de_datos.sql”. 
Consignas: 
1. ¿Qué tipo de base de datos es? Clasificarla según estructura y función. 
2. Armar el diagrama entidad-relación de la base de datos dada. 
3. Armar el modelo lógico entidad-relación de la base de datos dada. 
4. ¿Considera que la base de datos está normalizada? En caso que no lo esté, ¿cómo podría hacerlo? Nota: no debe normalizar la base de datos, solo explicar como lo haría. 

**EJERCICIO 1**
La clasificacion segun la estructura es RELACIONAL porque esta organizada en tablas que se relacionan entre si mediante claves que pueden ser primarias o foraneas
Clave primaria: campo que identifica univocamente a un registro. Puede ser una clave primaria simple o una clave primaria compuesta.

Clave foránea: campo que hace referencia a la clave primaria de otra tabla, estableciendo una relación entre ellas
La clasificacion segun su funcion es transaccional, las cuales se usan para gestionar datos dinamicos y operativos del día a día en un sistema de atención médica (registro de pacientes, médicos, consultas, etc.).

**EJERCICIO 2**

![Descripción de la imagen](ejercicio%202.png)

**EJERCICIO 3** Modelo Lógico Entidad-Relación (Modelo Relacional)

Tablas con claves:
SexoBiologico(id_sexo PK, descripcion UNIQUE)


Pacientes(id_paciente PK, nombre, fecha_nacimiento, id_sexo FK, numero, calle, ciudad)


Especialidades(id_especialidad PK, nombre UNIQUE)


Medicos(id_medico PK, nombre, especialidad_id FK, telefono, email, matricula)


Consultas(id_consulta PK, id_paciente FK, id_medico FK, fecha, diagnostico, tratamiento, snomed_codigo, UNIQUE(fecha, id_medico, id_paciente, snomed_codigo))

**EJERCICIO 4** ¿Está normalizada la base de datos?

La base de datos está parcialmente normalizada, ya que en la tabla de Pacientes, los campos como calle, numero y ciudad podrian estar normalizados en una tabla separada de direcciones para evitar datos repetidos o mal escritos
Se pueden ver errores tipograficos o inconsistencias como "Bs Aires", "Buenos Aires", "buenos aires", " Buenos Aires" lo que muestra la falta de normalizacion.


Para normalizar la tabla se sugiere agregar un diccionario de direcciones y ciudades y referenciarla desde pacientes o bien realizar un update sobre la tabla de pacientes corriegiendo los errores ortograficos comunes

##Parte 2: SQL 

Consignas: 
1. Cuando se realizan consultas sobre la tabla paciente agrupando por ciudad los tiempos de respuesta son demasiado largos. Proponer mediante una query SQL una solución a este problema. 

```sql
EXPLAIN ANALYZE
SELECT ciudad, COUNT(*) AS cantidad_pacientes
FROM pacientes
GROUP BY ciudad;
```

```sql
CREATE INDEZ idx_ciudad ON pacientes(ciudad);
EXPLAIN ANALYZE
SELECT ciudad, COUNT(*) AS cantidad_pacientes
FROM pacientes
GROUP BY ciudad;
```

2. Se tiene la fecha de nacimiento de los pacientes. Se desea calcular la edad de los pacientes y almacenarla de forma dinámica en el sistema ya que es un valor típicamente consultado, junto con otra información relevante del paciente. 

```sql
CREATE VIEW vista_pacientes AS
SELECT id_paciente, nombre, fecha_nacimiento,
	EXTRACT(YEAR FROM AGE(fecha_nacimiento)) AS edad
FROM pacientes;
```


3. La paciente, “Luciana Gómez”, ha cambiado de dirección. Antes vivía en “Avenida Las Heras 121” en “Buenos Aires”, pero ahora vive en “Calle Corrientes 500” en “Buenos Aires”. Actualizar la dirección de este paciente en la base de datos. 
```sql
SELECT nombre, calle, ciudad FROM pacientes WHERE nombre=”Luciana Gómez”;
```

```sql
UPDATE pacientes
SET calle='Calle Corrientes 500'
WHERE nombre ='Luciana Gómez' AND calle='Avenida Las Heras' AND ciudad ='Bs Aires';
SELECT nombre, calle, ciudad FROM pacientes WHERE nombre='Luciana Gómez';
```

4. Seleccionar el nombre y la matrícula de cada médico cuya especialidad sea identificada por el id 4. 

```sql
SELECT nombre, matricula
FROM medicos
WHERE especialidad_id=4;
```
5. Puede pasar que haya inconsistencias en la forma en la que están escritos los nombres de las ciudades, ¿cómo se corrige esto? Agregar la query correspondiente. 

```sql
—quiero ver todas las formas escritas
—SELECT DISTINCT ciudad FROM pacientes;
—busco reducir las diferencias entre las opciones
UPDATE pacientes
SET ciudad =TRIM(INITCAP(ciudad));
SELECT DISTINCT ciudad FROM pacientes;
—la siguiente forma es bastante ineficiente para solucionar este problema
—solo se puede hacer porque es una base chica
UPDATE pacientes
SET ciudad = 'BUENOS AIRES'
WHERE ciudad IN ('buenos aires','Bs Aires', 'Buenos Aires', 'Buenos aires', 'buenos Aires', 'Buenos    Aires');
UPDATE pacientes
SET ciudad= 'CORDOBA'
WHERE ciudad IN ('Córodba','Cordoba');
UPDATE pacientes
SET ciudad='SANTA FE'
WHERE ciudad IN ('Santa Fe');
UPDATE pacientes
SET ciudad ='MENDOZA'
where CIUDAD in ('Menzoa', 'Mendoza');
SELECT DISTINCT ciudad FROM pacientes;
```

6. Obtener el nombre y la dirección de los pacientes que viven en Buenos Aires. 
```sql
SELECT nombre, calle
FROM pacientes
WHERE (ciudad='BUENOS AIRES')
```
7. Cantidad de pacientes que viven en cada ciudad. 
```sql
SELECT ciudad, COUNT(*) AS cantidad_pacientes
FROM pacientes
GROUP BY ciudad
ORDER BY cantidad_pacientes DESC;
```

8. Cantidad de pacientes por sexo que viven en cada ciudad. 

```sql
SELECT ciudad, id_sexo, COUNT(*) AS cantidad_pacientes
FROM pacientes
GROUP BY ciudad, id_sexo
ORDER BY ciudad, cantidad_pacientes dDESC;
```

9. Obtener la cantidad de recetas emitidas por cada médico. 

```sql
SELECT M.nombre, r.id_medico, COUNT(r.id_receta) AS cantidad_recetas
FROM recetas r
JOIN medicos M ON r.id_medico =M.id_medico
GROUP BY M.nombre, r.id_medico
ORDER BY cantidad_recetas DESC;
```
10. Obtener todas las consultas médicas realizadas por el médico con ID igual a 3 durante el mes de agosto de 2024. 

```sql
SELECT M.nombre AS nombre_medico, r.id_receta, r.fecha,r.id_paciente,r.descripcion
FROM recetas r
JOIN medicos M ON r.id_medico=M.id_medico
WHERE r.id_medico=3
AND r.fecha BETWEEN 2024-08-01 AND 2024-08-31
ORDER BY r.fecha;
SELECT fecha FROM recetas WHERE id_medico=3 ORDER BY fecha;
```

11. Obtener el nombre de los pacientes junto con la fecha y el diagnóstico de todas las consultas médicas realizadas en agosto del 2024. 

```sql
SELECT pa.nombre AS nombre_paciente, co.id_consulta, co.fecha, co.diagnostico
FROM consultas co
JOIN pacientes pa ON co.id_paciente=pa.id_paciente
WHERE co.fecha BETWEEN '2024-08-01' AND '2024-08-31'
ORDER BY co.fecha;
```


12. Obtener el nombre de los medicamentos prescritos más de una vez por el médico con ID igual a 2. 
```sql
–-vemos todas las recetas del medico
SELECT med.nombre AS nombre_medico,dro.nombre AS remedio
FROM recetas r
JOIN medicos med ON r.id_medico=med.id_medico
JOIN medicamentos dro ON r.id_medicamento=dro.id_medicamento
WHERE r.id_medico=2;
–seleccionamos las que se repetian 2 o mas veces
SELECT med.nombre AS nombre_medico, dro.nombre AS remedio, COUNT(*) AS veces_prescrito
FROM recetas r
JOIN medicos med ON r.id_medico=med.id_medico
JOIN medicamentos dro ON r.id_medicamento=dro.id_medicamento
WHERE r.id_medico=2
GROUP BY med.nombre, dro.nombre
HAVING COUNT(*)>1
ORDER BY veces_prescrito DESC;
```

13. Obtener el nombre de los pacientes junto con la cantidad total de recetas que han recibido. 
```sql
SELECT pa.nombre AS nombre_paciente, COUNT (*) AS cantidad_recetas
FROM recetas r 
JOIN pacientes pa ON r.id_paciente=pa.id_paciente
GROUP BY pa.nombre
ORDER BY cantidad_recetas DESC;
```

14. Obtener el nombre del medicamento más recetado junto con la cantidad de recetas emitidas para ese medicamento. 
```sql
SELECT med.nombre AS nombre_medicamento, COUNT(*) AS veces_recetado
FROM recetas r
JOIN medicamentos med ON r.id_medicamento=med.id_medicamento
GROUP BY med.nombre
ORDER BY veces_recetado DESC
LIMIT 1;
```

15. Obtener el nombre del paciente junto con la fecha de su última consulta y el diagnóstico asociado. 

```sql
SELECT
p.nombre AS nombre_paciente,
c.fecha AS FechaUltimaConsulta,
c.diagnostico AS Diagnostico
FROM Pacientes p
LEFT JOIN Consultas c ON p.id_paciente=c.id_paciente
WHERE c.fecha=(SELECT MAX(fecha) —como se filtra por fecha, el where hace que los pacientes sin consultas no se muestren
FROM Consultas
WHERE id_paciente=p.id_paciente);
```

16. Obtener el nombre del médico junto con el nombre del paciente y el número total de consultas realizadas por cada médico para cada paciente, ordenado por médico y paciente.
```sql
SELECT 
m.nombre AS NombreMedico, p.nombre AS NombrePaciente,
COUNT (c.id_consulta) AS TotalConsultas
FROM Medicos m
JOIN Consultas c ON m.id_medico = c.id_medico —se une con la tabla de medicos segun el id de consulta
JOIN Pacientes p ON c.id_paciente=p.id_paciente —se une con la tabla de medicos segun la consulta del paciente con ese medico
GROUP BY m.id_medico, p.id_paciente —grupa todas las consultas realizadas por un mismo medico a un mismo paciente
ORDER BY m.nombre, p.nombre;
```



17. Obtener el nombre del medicamento junto con el total de recetas prescritas para ese medicamento, el nombre del médico que lo recetó y el nombre del paciente al que se le recetó, ordenado por total de recetas en orden descendente. 
```sql
SELECT me.nombre AS NombreMedicamento, COUNT(r.id_receta) AS TotalRecetas,m.nombre AS NombreMedico,p.nombre AS NombrePaciente
FROM Medicamentos me
JOIN  Recetas r ON me.id_medicamento = r.id_medicamento
JOIN Medicos m ON r.id_medico = m.id_medico - - - une medico con receta
JOIN Pacientes p ON r.id_paciente = p.id_paciente - - -une receta con paciente
GROUP BY me.id_medicamento, m.id_medico, p.id_paciente 
ORDER BY TotalRecetas DESC;
```


18. Obtener el nombre del médico junto con el total de pacientes a los que ha atendido, ordenado por el total de pacientes en orden descendente.
```sql
SELECT m.nombre AS nombre_medico, COUNT(c.id_paciente) AS total_pacientes
FROM Medicos m
JOIN Consultas c ON m.id_medico = c.id_medico
GROUP BY m.id_medico, m.nombre
ORDER BY total_pacientes DESC;
```

```sql
SELECT * FROM Pacientes;
