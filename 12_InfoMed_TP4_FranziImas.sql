–--vemos todas las recetas del medico
SELECT med.nombre AS nombre_medico,dro.nombre AS remedio
FROM recetas r
JOIN medicos med ON r.id_medico=med.id_medico
JOIN medicamentos dro ON r.id_medicamento=dro.id_medicamento
WHERE r.id_medico=2;
–--seleccionamos las que se repetian 2 o mas veces
SELECT med.nombre AS nombre_medico, dro.nombre AS remedio, COUNT(*) AS veces_prescrito
FROM recetas r
JOIN medicos med ON r.id_medico=med.id_medico
JOIN medicamentos dro ON r.id_medicamento=dro.id_medicamento
WHERE r.id_medico=2
GROUP BY med.nombre, dro.nombre
HAVING COUNT(*)>1
ORDER BY veces_prescrito DESC;
