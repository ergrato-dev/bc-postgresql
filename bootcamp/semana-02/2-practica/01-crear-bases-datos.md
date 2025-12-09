# 💻 Práctica 01: Crear Bases de Datos y Esquemas

## 🎯 Objetivo

Aprender a crear y gestionar bases de datos y esquemas en PostgreSQL.

---

## 📋 Requisitos Previos

Tener el contenedor PostgreSQL en ejecución:

```bash
docker compose up -d
docker exec -it postgres-bootcamp psql -U bootcamp -d tienda_online
```

---

## 🔨 Parte 1: Crear Bases de Datos

### 1.1 Ver bases de datos existentes

```sql
-- Listar todas las bases de datos
\l

-- O usando SQL
SELECT datname FROM pg_database WHERE datistemplate = false;
```

**¿Qué?** Lista las bases de datos disponibles en el servidor.

**¿Para qué?** Verificar qué bases de datos ya existen antes de crear nuevas.

**Impacto:** Solo lectura, no modifica nada.

---

### 1.2 Crear una base de datos

```sql
-- Crear base de datos simple
CREATE DATABASE biblioteca;

-- Crear con opciones
CREATE DATABASE inventario
    ENCODING = 'UTF8'
    LC_COLLATE = 'es_ES.UTF-8'
    LC_CTYPE = 'es_ES.UTF-8'
    TEMPLATE = template0
    CONNECTION LIMIT = 100;
```

**¿Qué?** Crea una nueva base de datos con configuración específica.

**¿Para qué?**

- `ENCODING`: Codificación de caracteres (UTF8 para español)
- `LC_COLLATE`: Ordenamiento de texto (alfabético español)
- `CONNECTION LIMIT`: Límite de conexiones simultáneas

**Impacto:** Crea un nuevo contenedor de datos independiente.

---

### 1.3 Conectarse a otra base de datos

```sql
-- Conectarse a la nueva base de datos
\c biblioteca

-- Verificar conexión actual
SELECT current_database();
```

**¿Qué?** Cambia la conexión a otra base de datos.

**¿Para qué?** Trabajar con los objetos de esa base de datos.

**Impacto:** Cambia el contexto de trabajo.

---

### 1.4 Eliminar una base de datos

```sql
-- Primero volver a otra base de datos
\c tienda_online

-- Eliminar la base de datos (no puedes eliminar la que estás usando)
DROP DATABASE IF EXISTS biblioteca;
```

**¿Qué?** Elimina permanentemente la base de datos y todo su contenido.

**¿Para qué?** Limpiar bases de datos que ya no se necesitan.

**Impacto:** ⚠️ **DESTRUCTIVO** - Pérdida permanente de datos.

---

## 🗂️ Parte 2: Esquemas

Los **esquemas** son namespaces dentro de una base de datos para organizar objetos.

### 2.1 Ver esquemas existentes

```sql
-- Listar esquemas
\dn

-- O usando SQL
SELECT schema_name FROM information_schema.schemata;
```

**¿Qué?** Muestra los esquemas disponibles.

**¿Para qué?** Ver la organización actual de la base de datos.

**Impacto:** Solo lectura.

---

### 2.2 Crear esquemas

```sql
-- Crear esquema simple
CREATE SCHEMA ventas;

-- Crear esquema con autorización (propietario)
CREATE SCHEMA rrhh AUTHORIZATION bootcamp;

-- Crear esquema si no existe
CREATE SCHEMA IF NOT EXISTS logistica;
```

**¿Qué?** Crea un nuevo namespace para organizar objetos.

**¿Para qué?**

- Separar lógicamente diferentes áreas (ventas, inventario, RRHH)
- Evitar conflictos de nombres
- Controlar permisos por área

**Impacto:** Crea una estructura organizativa vacía.

---

### 2.3 Usar esquemas

```sql
-- Crear tabla en un esquema específico
CREATE TABLE ventas.clientes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100)
);

-- Crear tabla en otro esquema
CREATE TABLE rrhh.empleados (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100)
);

-- Consultar con esquema explícito
SELECT * FROM ventas.clientes;
SELECT * FROM rrhh.empleados;
```

**¿Qué?** Crea objetos dentro de esquemas específicos.

**¿Para qué?** Organizar tablas por área funcional.

**Impacto:** Las tablas quedan asociadas a su esquema.

---

### 2.4 Search Path

```sql
-- Ver el search_path actual
SHOW search_path;

-- Cambiar el search_path
SET search_path TO ventas, public;

-- Ahora puedes usar tablas de ventas sin prefijo
SELECT * FROM clientes;  -- Busca en ventas.clientes

-- Cambiar permanentemente para la sesión
ALTER ROLE bootcamp SET search_path TO ventas, rrhh, public;
```

**¿Qué?** Define el orden de búsqueda de objetos.

**¿Para qué?** Evitar escribir el prefijo del esquema constantemente.

**Impacto:** Cambia cómo PostgreSQL resuelve los nombres de objetos.

---

### 2.5 Eliminar esquemas

```sql
-- Eliminar esquema vacío
DROP SCHEMA IF EXISTS logistica;

-- Eliminar esquema con todo su contenido
DROP SCHEMA ventas CASCADE;
-- NOTICE: drop cascades to table ventas.clientes
```

**¿Qué?** Elimina el esquema y opcionalmente su contenido.

**¿Para qué?** Limpiar esquemas que ya no se necesitan.

**Impacto:** ⚠️ `CASCADE` elimina TODO el contenido del esquema.

---

## 🏗️ Parte 3: Estructura de Ejemplo

Vamos a crear una estructura organizada para una tienda:

```sql
-- Conectarse a la base de datos principal
\c tienda_online

-- Crear esquemas para diferentes áreas
CREATE SCHEMA IF NOT EXISTS catalogo;   -- Productos y categorías
CREATE SCHEMA IF NOT EXISTS ventas;     -- Pedidos y clientes
CREATE SCHEMA IF NOT EXISTS inventario; -- Stock y almacenes
CREATE SCHEMA IF NOT EXISTS auditoria;  -- Logs y registros

-- Verificar esquemas creados
\dn

-- Ver el resultado:
--    List of schemas
--      Name    |  Owner
-- -------------+----------
--  auditoria   | bootcamp
--  catalogo    | bootcamp
--  inventario  | bootcamp
--  public      | pg_database_owner
--  ventas      | bootcamp
```

---

## ✅ Ejercicio Práctico

### Tarea

1. Crear una base de datos llamada `universidad`
2. Conectarse a ella
3. Crear 3 esquemas: `academico`, `administrativo`, `biblioteca`
4. Crear una tabla simple en cada esquema
5. Verificar la estructura

### Solución

```sql
-- 1. Crear base de datos
CREATE DATABASE universidad;

-- 2. Conectarse
\c universidad

-- 3. Crear esquemas
CREATE SCHEMA academico;
CREATE SCHEMA administrativo;
CREATE SCHEMA biblioteca;

-- 4. Crear tablas
CREATE TABLE academico.estudiantes (
    id SERIAL PRIMARY KEY,
    matricula VARCHAR(20) UNIQUE,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE administrativo.empleados (
    id SERIAL PRIMARY KEY,
    legajo VARCHAR(10) UNIQUE,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE biblioteca.libros (
    id SERIAL PRIMARY KEY,
    isbn VARCHAR(20) UNIQUE,
    titulo VARCHAR(200) NOT NULL
);

-- 5. Verificar
\dn
\dt academico.*
\dt administrativo.*
\dt biblioteca.*
```

---

## 🎯 Puntos Clave

1. **Base de datos** = Contenedor principal e independiente
2. **Esquema** = Namespace dentro de una base de datos
3. **Esquema `public`** = Esquema por defecto
4. **`search_path`** = Define dónde buscar objetos
5. **Usa `IF EXISTS` / `IF NOT EXISTS`** para evitar errores
6. **Cuidado con `CASCADE`** en DROP

---

## 📖 Navegación

|                  ⬅️ Teoría                   |            Siguiente ➡️            |
| :------------------------------------------: | :--------------------------------: |
| [Constraints](../1-teoria/03-constraints.md) | [Crear Tablas](02-crear-tablas.md) |
