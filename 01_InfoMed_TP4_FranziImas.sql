CREATE INDEX idx_ciudad ON pacientes(ciudad);
EXPLAIN ANALYZE
SELECT ciudad, COUNT(*) AS cantidad_pacientes
FROM pacientes
GROUP BY ciudad;
