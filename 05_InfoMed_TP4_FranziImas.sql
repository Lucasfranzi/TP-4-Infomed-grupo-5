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
