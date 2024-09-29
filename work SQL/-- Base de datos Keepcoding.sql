-- Base de datos Keepcoding

CREATE DATABASE keepcoding;
\c keepcoding;

-- Tabla: Alumnos
CREATE TABLE alumnos (
    id_alumno SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    fecha_nacimiento DATE,
    telefono VARCHAR(20),
    direccion TEXT
);

-- Tabla: Bootcamps
CREATE TABLE bootcamps (
    id_bootcamp SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_inicio DATE,
    fecha_fin DATE,
    precio NUMERIC(10,2)
);

-- Tabla: Modulos
CREATE TABLE modulos (
    id_modulo SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    duracion INTEGER,
    tecnologia_principal VARCHAR(50),
    id_bootcamp INTEGER REFERENCES bootcamps(id_bootcamp)
);

-- Tabla: Profesores
CREATE TABLE profesores (
    id_profesor SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    especialidad VARCHAR(100),
    experiencia INTEGER
);

-- Tabla: Pagos
CREATE TABLE pagos (
    id_pago SERIAL PRIMARY KEY,
    monto NUMERIC(10,2) NOT NULL,
    fecha_pago DATE,
    id_alumno INTEGER REFERENCES alumnos(id_alumno),
    id_bootcamp INTEGER REFERENCES bootcamps(id_bootcamp)
);

-- Tabla: Evaluaciones
CREATE TABLE evaluaciones (
    id_evaluacion SERIAL PRIMARY KEY,
    nota NUMERIC(5,2),
    comentario TEXT,
    fecha DATE,
    id_alumno INTEGER REFERENCES alumnos(id_alumno),
    id_modulo INTEGER REFERENCES modulos(id_modulo)
);