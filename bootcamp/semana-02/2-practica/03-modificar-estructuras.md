# 💻 Práctica 03: Modificar Estructuras (ALTER)

## 🎯 Objetivo

Dominar el uso de ALTER TABLE para modificar estructuras existentes de forma segura.

---

## 📋 Preparación

Creamos tablas de ejemplo para practicar:

```sql
-- Conectarse
-- docker exec -it postgres-bootcamp psql -U bootcamp -d tienda_online

-- Crear tablas de práctica
CREATE TABLE empleados (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    email VARCHAR(100),
    salario DECIMAL(10,2),
    departamento VARCHAR(50),
    fecha_ingreso DATE
);

CREATE TABLE proyectos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    presupuesto DECIMAL(12,2)
);

-- Insertar datos de ejemplo
INSERT INTO empleados (nombre, email, salario, departamento, fecha_ingreso) VALUES
('Ana García', 'ana@empresa.com', 3500.00, 'TI', '2020-03-15'),
('Carlos López', 'carlos@empresa.com', 4200.00, 'TI', '2019-07-22'),
('María Ruiz', 'maria@empresa.com', 3800.00, 'RRHH', '2021-01-10');

INSERT INTO proyectos (nombre, presupuesto) VALUES
('Sistema Web', 50000.00),
('App Móvil', 75000.00);
```

---

## ➕ Parte 1: Agregar Elementos

### 1.1 Agregar Columnas

```sql
-- Columna simple
ALTER TABLE empleados ADD COLUMN telefono VARCHAR(20);

-- Verificar
\d empleados

-- Columna con valor por defecto
ALTER TABLE empleados ADD COLUMN activo BOOLEAN DEFAULT TRUE;

-- Columna con CHECK
ALTER TABLE empleados ADD COLUMN edad INTEGER CHECK (edad >= 18 AND edad <= 100);

-- Columna NOT NULL (requiere DEFAULT si hay datos existentes)
ALTER TABLE empleados ADD COLUMN pais VARCHAR(50) NOT NULL DEFAULT 'México';

-- Ver datos
SELECT nombre, telefono, activo, edad, pais FROM empleados;
```

**¿Qué?** Agrega nuevas columnas a una tabla existente.

**¿Para qué?** Extender el modelo sin recrear la tabla.

**Impacto:**

- Las columnas nuevas tendrán NULL o el DEFAULT especificado
- NOT NULL sin DEFAULT falla si hay filas existentes

---

### 1.2 Agregar Constraints

```sql
-- Agregar UNIQUE
ALTER TABLE empleados ADD CONSTRAINT uq_empleados_email UNIQUE (email);

-- Agregar CHECK
ALTER TABLE empleados ADD CONSTRAINT chk_salario_minimo CHECK (salario >= 1000);

-- Agregar FOREIGN KEY (primero creamos la tabla referenciada)
CREATE TABLE departamentos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);

INSERT INTO departamentos (nombre) VALUES ('TI'), ('RRHH'), ('Ventas');

-- Agregar columna para FK
ALTER TABLE empleados ADD COLUMN departamento_id INTEGER;

-- Agregar la FK
ALTER TABLE empleados ADD CONSTRAINT fk_empleados_departamento
    FOREIGN KEY (departamento_id) REFERENCES departamentos(id);
```

**¿Qué?** Agrega restricciones a columnas existentes.

**¿Para qué?** Mejorar la integridad de datos sin recrear tablas.

**Impacto:** ⚠️ Falla si hay datos que violan la nueva restricción.

---

### 1.3 Agregar Índices

```sql
-- Índice simple
CREATE INDEX idx_empleados_nombre ON empleados(nombre);

-- Índice compuesto
CREATE INDEX idx_empleados_depto_salario ON empleados(departamento_id, salario);

-- Índice único (equivale a UNIQUE constraint)
CREATE UNIQUE INDEX idx_empleados_email ON empleados(email);

-- Índice parcial (solo filas que cumplen condición)
CREATE INDEX idx_empleados_activos ON empleados(nombre) WHERE activo = TRUE;

-- Ver índices
\di empleados*
```

---

## ✏️ Parte 2: Modificar Elementos

### 2.1 Cambiar Tipo de Dato

```sql
-- Ampliar VARCHAR
ALTER TABLE empleados ALTER COLUMN nombre TYPE VARCHAR(100);

-- Cambiar a TEXT
ALTER TABLE empleados ALTER COLUMN nombre TYPE TEXT;

-- Cambiar precisión de DECIMAL
ALTER TABLE empleados ALTER COLUMN salario TYPE DECIMAL(12,2);

-- Cambiar con conversión explícita
ALTER TABLE empleados ALTER COLUMN salario TYPE INTEGER USING salario::INTEGER;
```

**¿Qué?** Modifica el tipo de dato de una columna.

**¿Para qué?** Adaptarse a nuevos requisitos sin perder datos.

**Impacto:**

- Algunos cambios son automáticos (VARCHAR más grande)
- Otros requieren `USING` para especificar la conversión

---

### 2.2 Modificar NULL/NOT NULL

```sql
-- Agregar NOT NULL (falla si hay NULLs)
ALTER TABLE empleados ALTER COLUMN nombre SET NOT NULL;

-- Primero llenar los NULL, luego agregar NOT NULL
UPDATE empleados SET telefono = 'No especificado' WHERE telefono IS NULL;
ALTER TABLE empleados ALTER COLUMN telefono SET NOT NULL;

-- Quitar NOT NULL
ALTER TABLE empleados ALTER COLUMN telefono DROP NOT NULL;
```

---

### 2.3 Modificar DEFAULT

```sql
-- Establecer nuevo DEFAULT
ALTER TABLE empleados ALTER COLUMN activo SET DEFAULT TRUE;
ALTER TABLE empleados ALTER COLUMN fecha_ingreso SET DEFAULT CURRENT_DATE;

-- Quitar DEFAULT
ALTER TABLE empleados ALTER COLUMN pais DROP DEFAULT;

-- Ver defaults en estructura
\d empleados
```

---

### 2.4 Renombrar

```sql
-- Renombrar columna
ALTER TABLE empleados RENAME COLUMN departamento TO depto_legacy;

-- Renombrar tabla
ALTER TABLE proyectos RENAME TO proyectos_activos;

-- Renombrar constraint
ALTER TABLE empleados RENAME CONSTRAINT uq_empleados_email TO uq_email;

-- Renombrar índice
ALTER INDEX idx_empleados_nombre RENAME TO idx_emp_nombre;
```

---

## ➖ Parte 3: Eliminar Elementos

### 3.1 Eliminar Columnas

```sql
-- Eliminar columna simple
ALTER TABLE empleados DROP COLUMN IF EXISTS depto_legacy;

-- Eliminar columna con dependencias
ALTER TABLE empleados DROP COLUMN departamento_id CASCADE;
-- NOTICE: drop cascades to constraint fk_empleados_departamento

-- Ver estructura actualizada
\d empleados
```

**¿Qué?** Elimina columnas de una tabla.

**¿Para qué?** Limpiar columnas obsoletas o mal diseñadas.

**Impacto:** ⚠️ **Pérdida permanente de datos** en esa columna.

---

### 3.2 Eliminar Constraints

```sql
-- Eliminar constraint por nombre
ALTER TABLE empleados DROP CONSTRAINT IF EXISTS chk_salario_minimo;

-- Eliminar PRIMARY KEY (primero eliminar FKs que la referencian)
-- ALTER TABLE empleados DROP CONSTRAINT empleados_pkey;

-- Eliminar UNIQUE
ALTER TABLE empleados DROP CONSTRAINT IF EXISTS uq_email;

-- Eliminar CHECK
ALTER TABLE empleados DROP CONSTRAINT IF EXISTS chk_salario_minimo;
```

---

### 3.3 Eliminar Índices

```sql
-- Eliminar índice
DROP INDEX IF EXISTS idx_emp_nombre;

-- Eliminar múltiples índices
DROP INDEX IF EXISTS idx_empleados_activos, idx_empleados_depto_salario;
```

---

## 🔄 Parte 4: Operaciones Complejas

### 4.1 Migrar Datos entre Columnas

```sql
-- Escenario: Dividir nombre completo en nombre y apellido

-- 1. Agregar nuevas columnas
ALTER TABLE empleados
    ADD COLUMN nombre_pila VARCHAR(50),
    ADD COLUMN apellido VARCHAR(50);

-- 2. Migrar datos
UPDATE empleados SET
    nombre_pila = SPLIT_PART(nombre, ' ', 1),
    apellido = SPLIT_PART(nombre, ' ', 2);

-- 3. Verificar
SELECT nombre, nombre_pila, apellido FROM empleados;

-- 4. Establecer NOT NULL en nuevas columnas
ALTER TABLE empleados ALTER COLUMN nombre_pila SET NOT NULL;

-- 5. (Opcional) Eliminar columna antigua
-- ALTER TABLE empleados DROP COLUMN nombre;
```

---

### 4.2 Cambiar PRIMARY KEY

```sql
-- Escenario: Cambiar de SERIAL a UUID

-- 1. Crear nueva columna UUID
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
ALTER TABLE empleados ADD COLUMN uuid UUID DEFAULT uuid_generate_v4();

-- 2. Generar UUIDs para filas existentes
UPDATE empleados SET uuid = uuid_generate_v4() WHERE uuid IS NULL;

-- 3. Eliminar PK antigua (primero eliminar dependencias)
ALTER TABLE empleados DROP CONSTRAINT empleados_pkey;

-- 4. Agregar nueva PK
ALTER TABLE empleados ADD CONSTRAINT empleados_pkey PRIMARY KEY (uuid);

-- 5. (Opcional) Eliminar columna id antigua
-- ALTER TABLE empleados DROP COLUMN id;
```

---

### 4.3 Agregar FK a Tabla con Datos

```sql
-- Problema: Queremos agregar FK pero hay datos que no coinciden

-- 1. Ver datos huérfanos
SELECT DISTINCT departamento FROM empleados
WHERE departamento NOT IN (SELECT nombre FROM departamentos);

-- 2. Opción A: Agregar los valores faltantes a la tabla padre
INSERT INTO departamentos (nombre)
SELECT DISTINCT departamento FROM empleados
WHERE departamento NOT IN (SELECT nombre FROM departamentos);

-- 3. Opción B: Actualizar los datos huérfanos
UPDATE empleados SET departamento = 'Sin asignar'
WHERE departamento NOT IN (SELECT nombre FROM departamentos);

-- 4. Agregar columna de referencia y llenarla
ALTER TABLE empleados ADD COLUMN nuevo_departamento_id INTEGER;

UPDATE empleados e SET nuevo_departamento_id = d.id
FROM departamentos d WHERE e.departamento = d.nombre;

-- 5. Agregar FK
ALTER TABLE empleados ADD CONSTRAINT fk_nuevo_departamento
    FOREIGN KEY (nuevo_departamento_id) REFERENCES departamentos(id);
```

---

## ⚠️ Buenas Prácticas

### 1. Siempre hacer backup antes

```bash
# Backup de tabla específica
pg_dump -U bootcamp -t empleados tienda_online > empleados_backup.sql
```

### 2. Usar transacciones para cambios múltiples

```sql
BEGIN;

ALTER TABLE empleados ADD COLUMN temp_col INTEGER;
UPDATE empleados SET temp_col = id * 10;
ALTER TABLE empleados ALTER COLUMN temp_col SET NOT NULL;

-- Si algo sale mal: ROLLBACK;
COMMIT;
```

### 3. Verificar impacto antes de eliminar

```sql
-- Ver dependencias de una tabla
SELECT
    tc.table_name AS tabla,
    kcu.column_name AS columna,
    ccu.table_name AS tabla_referenciada
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
JOIN information_schema.constraint_column_usage ccu
    ON tc.constraint_name = ccu.constraint_name
WHERE tc.constraint_type = 'FOREIGN KEY'
    AND ccu.table_name = 'empleados';
```

### 4. Documentar cambios

```sql
-- ============================================
-- Migración: 002_agregar_campo_telefono
-- Fecha: 2025-12-08
-- Descripción: Agrega campo de teléfono a empleados
-- ============================================

ALTER TABLE empleados ADD COLUMN telefono VARCHAR(20);
COMMENT ON COLUMN empleados.telefono IS 'Teléfono de contacto del empleado';
```

---

## ✅ Ejercicio Final

Realizar la siguiente migración en la tabla `empleados`:

1. Agregar columna `fecha_nacimiento` (DATE)
2. Agregar columna `codigo_empleado` (VARCHAR(10), UNIQUE, NOT NULL con DEFAULT 'PEND-XXX')
3. Agregar CHECK para que `salario` sea mayor que 0
4. Renombrar columna `email` a `correo_electronico`
5. Cambiar `nombre` de TEXT a VARCHAR(150)

---

## 📖 Navegación

|            ⬅️ Anterior             |      🏠 Semana 02      |                Siguiente ➡️                 |
| :--------------------------------: | :--------------------: | :-----------------------------------------: |
| [Crear Tablas](02-crear-tablas.md) | [README](../README.md) | [Ejercicios](../3-ejercicios/ejercicios.md) |
