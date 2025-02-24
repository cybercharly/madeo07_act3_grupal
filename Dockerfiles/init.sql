-- Crear la base de datos
CREATE DATABASE escuela;

-- Usar la base de datos creada
\c escuela;

-- Crear la tabla "grado"
CREATE TABLE grado (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Insertar algunos grados
INSERT INTO grado (nombre) VALUES ('Primero');
INSERT INTO grado (nombre) VALUES ('Segundo');
INSERT INTO grado (nombre) VALUES ('Tercero');
INSERT INTO grado (nombre) VALUES ('Cuarto');
INSERT INTO grado (nombre) VALUES ('Quinto');

-- Crear la tabla "maestria"
CREATE TABLE maestria (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Insertar algunas maestrías
INSERT INTO maestria (nombre) VALUES ('Ciencias de la Computación');
INSERT INTO maestria (nombre) VALUES ('Administración de Empresas');
INSERT INTO maestria (nombre) VALUES ('Ingeniería Eléctrica');
INSERT INTO maestria (nombre) VALUES ('Filosofía');

-- Crear la tabla "alumno"
CREATE TABLE alumno (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    grado_id INT REFERENCES grado(id),
    maestria_id INT REFERENCES maestria(id),
    fecha_nacimiento DATE NOT NULL
);

-- Insertar algunos alumnos
INSERT INTO alumno (nombre, grado_id, maestria_id, fecha_nacimiento) 
VALUES ('Juan Pérez', 1, 1, '2000-01-15');
INSERT INTO alumno (nombre, grado_id, maestria_id, fecha_nacimiento) 
VALUES ('Ana Gómez', 2, 2, '1999-04-22');
INSERT INTO alumno (nombre, grado_id, maestria_id, fecha_nacimiento) 
VALUES ('Carlos López', 3, 3, '1998-07-30');
INSERT INTO alumno (nombre, grado_id, maestria_id, fecha_nacimiento) 
VALUES ('Luisa Martínez', 4, 4, '1997-11-10');

-- Confirmar los datos insertados
SELECT * FROM alumno;
SELECT * FROM grado;
SELECT * FROM maestria;
