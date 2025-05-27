---quiero ver todas las formas escritas
---SELECT DISTINCT ciudad FROM pacientes;
---busco reducir las diferencias entre las opciones
UPDATE pacientes
SET ciudad = TRIM(INITCAP(ciudad));
---la siguiente forma es bastante ineficiente para solucionar este problema
---solo se puede hacer porque es una base chica
UPDATE pacientes
SET ciudad = 'BUENOS AIRES'
WHERE ciudad IN ('buenos aires','Bs Aires','Buenos aires','Buenos Aires',
                 'buenos Aiers','Buenos    Aires', 'Buenos   Aires', 'Buenos Aiers');
UPDATE pacientes
SET ciudad = 'CORDOBA'
WHERE ciudad IN ('Córdoba', 'Cordoba');
UPDATE pacientes
SET ciudad = 'SANTA FE'
WHERE ciudad IN ('Santa Fe');
UPDATE pacientes
SET ciudad = 'MENDOZA'
WHERE ciudad IN ('Mendzoa',' Mendoza');
SELECT DISTINCT ciudad FROM pacientes;
