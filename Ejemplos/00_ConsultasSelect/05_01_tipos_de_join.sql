-- Ejemplo inicial
select * 
from alumnos join matriculas using(id_alumno)
JOIN cursos using (id_curso);

select * 
from alumnos a join matriculas m ON a.id_alumno = m.id_alumno
JOIN cursos c ON m.id_curso = c.id_curso;

-- Vamos a obtener el listado de alumnos y matriculaciones dejando huecos.
SELECT * 
FROM alumnos a LEFT JOIN matriculas m ON a.id_alumno = m.id_alumno;


SELECT * 
FROM alumnos a RIGHT JOIN matriculas m ON a.id_alumno = m.id_alumno;


SELECT *
FROM matriculas m RIGHT JOIN alumnos a ON m.id_alumno = a.id_alumno;

-- Vamos con 3 tablas

SELECT *
FROM matriculas m LEFT JOIN alumnos a ON m.id_alumno = a.id_alumno
	RIGHT JOIN cursos c ON c.id_curso = m.id_curso;

SELECT *
FROM matriculas m LEFT JOIN alumnos a ON m.id_alumno = a.id_alumno
	LEFT JOIN cursos c ON c.id_curso = m.id_curso;

SELECT *
FROM matriculas m LEFT JOIN alumnos a ON m.id_alumno = a.id_alumno
	JOIN cursos c ON c.id_curso = m.id_curso;


SELECT *
FROM matriculas m JOIN alumnos a ON m.id_alumno = a.id_alumno
	LEFT JOIN cursos c ON c.id_curso = m.id_curso;
    
    
-- correcto
SELECT *
FROM matriculas m JOIN alumnos a ON m.id_alumno = a.id_alumno
	LEFT JOIN cursos c ON c.id_curso = m.id_curso
WHERE c.id_curso IS NULL;


-- absurdo:
SELECT *
FROM matriculas m JOIN alumnos a ON m.id_alumno = a.id_alumno
	LEFT JOIN cursos c ON c.id_curso = m.id_curso
WHERE m.id_curso IS NULL;


--  1) Saca el listado de matrículas en cursos inexistentes
SELECT *
FROM matriculas m LEFT JOIN cursos c ON m.id_curso = c.id_curso
WHERE c.id_curso = null; -- incorrecto
-- WHERE nombre_curso is null;
SELECT *
FROM matriculas m LEFT JOIN cursos c ON m.id_curso = c.id_curso
WHERE c.id_curso is null; 

-- Ojo, que el using hace "desaparecer" esa columna que tenía el ID en null.
SELECT *
FROM matriculas m LEFT JOIN cursos c USING(id_curso)
WHERE c.id_curso is null; 


-- 2) Saca el listado de cursos sin matrículas
SELECT *
FROM cursos c LEFT JOIN matriculas m ON c.id_curso = m.id_curso
WHERE m.id_curso IS NULL;

-- 3) Alumnos matriculados en cursos inexistentes.
SELECT *
FROM matriculas m JOIN alumnos a ON m.id_alumno = a.id_alumno
	LEFT JOIN cursos c ON c.id_curso = m.id_curso
WHERE c.id_curso IS NULL;


-- 4) Matrículas de alumnos inexistentes.
SELECT * 
FROM matriculas LEFT JOIN alumnos ON matriculas.id_alumno = alumnos.id_alumno
WHERE alumnos.id_alumno IS NULL;


