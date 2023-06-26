-- Insertar datos ficticios en la tabla Usuarios
INSERT INTO Usuarios (nombre, apellido, username, password, rol)
VALUES
    ('Juan', 'Pérez', 'juan123', 'password123', 'Estudiante'),
    ('María', 'López', 'maria456', 'password456', 'Estudiante'),
    ('Ana', 'Gómez', 'ana789', 'password789', 'Docente');

-- Insertar datos ficticios en la tabla Cursos
INSERT INTO Cursos (nombre, descripcion, id_profesor)
VALUES
    ('Programación en Python', 'Curso introductorio a Python', 3),
    ('Diseño Gráfico', 'Curso de diseño gráfico básico', 3);

-- Insertar datos ficticios en la tabla Lecciones
INSERT INTO Lecciones (nombre, duracion, id_curso)
VALUES
    ('Introducción a Python', '50::00:00', 1),
    ('Estructuras de Control', '30:00:00', 1),
    ('Herramientas de Diseño', '02:00:00', 2),
    ('Composición y Color', '10:00:00', 2);

-- Insertar datos ficticios en la tabla Progreso
INSERT INTO Progreso (id_usuario, id_leccion, fecha_finalizacion)
VALUES
    (1, 1, '2023-05-01'),
    (1, 2, '2023-05-03'),
    (2, 1, '2023-05-02'),
    (3, 3, '2023-05-05')

-- Consulta duración total de los cursos

SELECT Cursos.nombre, SEC_TO_TIME(SUM(TIME_TO_SEC(Lecciones.duracion))) AS duracion_total
FROM Cursos
JOIN Lecciones ON Cursos.id_curso = Lecciones.id_curso
GROUP BY Cursos.nombre;

--Registro de los usuarios que han finalizado las lecciones y los cursos.

SELECT Usuarios.nombre, Usuarios.apellido, COUNT(DISTINCT Progreso.id_leccion) 
AS lecciones_finalizadas, COUNT(DISTINCT Progreso.id_leccion) AS cursos_finalizados 
FROM Usuarios LEFT JOIN Progreso ON Usuarios.id_usuario = Progreso.id_usuario
GROUP BY Usuarios.nombre, Usuarios.apellido; 

--Consulta lecciones finalizadas.
SELECT Usuarios.nombre, Usuarios.apellido, COUNT(DISTINCT Progreso.id_leccion)
AS lecciones_finalizadas, COUNT(DISTINCT Cursos.id_curso) AS cursos_finalizados
FROM Usuarios INNER JOIN Progreso ON Usuarios.id_usuario = Progreso.id_usuario
INNER JOIN Lecciones ON Progreso.id_leccion = Lecciones.id_leccion
INNER JOIN Cursos ON Lecciones.id_curso = Cursos.id_curso
GROUP BY Usuarios.nombre, Usuarios.apellido;