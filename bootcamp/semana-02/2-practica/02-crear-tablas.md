# 💻 Práctica 02: Crear Tablas

## 🎯 Objetivo

Dominar la creación de tablas con tipos de datos apropiados y restricciones.

---

## 📋 Preparación

```bash
docker exec -it postgres-bootcamp psql -U bootcamp -d tienda_online
```

---

## 🔨 Parte 1: CREATE TABLE Básico

### 1.1 Tabla Simple

```sql
-- Tabla más básica posible
CREATE TABLE productos_simple (
    id INTEGER,
    nombre VARCHAR(100),
    precio DECIMAL(10,2)
);

-- Verificar estructura
\d productos_simple
```

**¿Qué?** Crea una tabla con 3 columnas sin restricciones.

**¿Para qué?** Almacenar datos de productos.

**Impacto:** Sin restricciones, acepta duplicados, NULLs, etc.

---

### 1.2 Tabla con Restricciones

```sql
-- Tabla con restricciones de integridad
CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    stock INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Ver estructura detallada
\d+ productos
```

**¿Qué?** Crea tabla con restricciones completas.

**¿Para qué?**

- `SERIAL PRIMARY KEY`: ID autoincremental único
- `NOT NULL`: Campos obligatorios
- `CHECK`: Validación de valores
- `DEFAULT`: Valores por defecto

**Impacto:** Garantiza integridad de datos desde el diseño.

---

## 🔗 Parte 2: Tablas Relacionadas

### 2.1 Crear Jerarquía de Tablas

```sql
-- 1. Tabla padre (sin dependencias)
CREATE TABLE categorias (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT,
    activa BOOLEAN DEFAULT TRUE
);

-- 2. Tabla hija (depende de categorias)
CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    categoria_id INTEGER NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    stock INTEGER DEFAULT 0 CHECK (stock >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_productos_categoria
        FOREIGN KEY (categoria_id)
        REFERENCES categorias(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);
```

**¿Qué?** Crea relación padre-hijo entre tablas.

**¿Para qué?**

- `ON DELETE RESTRICT`: No permite borrar categoría con productos
- `ON UPDATE CASCADE`: Si cambia el ID de categoría, actualiza productos

**Impacto:** Garantiza que todo producto tenga una categoría válida.

---

### 2.2 Sistema Completo de Ventas

```sql
-- Clientes
CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    direccion TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Pedidos
CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER NOT NULL,
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) DEFAULT 'pendiente'
        CHECK (estado IN ('pendiente', 'confirmado', 'enviado', 'entregado', 'cancelado')),
    total DECIMAL(12,2) DEFAULT 0,
    notas TEXT,

    CONSTRAINT fk_pedidos_cliente
        FOREIGN KEY (cliente_id)
        REFERENCES clientes(id)
        ON DELETE RESTRICT
);

-- Detalle de pedidos (tabla intermedia)
CREATE TABLE detalle_pedidos (
    id SERIAL PRIMARY KEY,
    pedido_id INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL CHECK (precio_unitario > 0),
    subtotal DECIMAL(12,2) GENERATED ALWAYS AS (cantidad * precio_unitario) STORED,

    CONSTRAINT fk_detalle_pedido
        FOREIGN KEY (pedido_id)
        REFERENCES pedidos(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_detalle_producto
        FOREIGN KEY (producto_id)
        REFERENCES productos(id)
        ON DELETE RESTRICT,

    CONSTRAINT uq_pedido_producto
        UNIQUE (pedido_id, producto_id)
);
```

**¿Qué?** Sistema completo de pedidos con múltiples relaciones.

**¿Para qué?**

- `GENERATED ALWAYS AS ... STORED`: Columna calculada automáticamente
- `UNIQUE (pedido_id, producto_id)`: Evita duplicar producto en mismo pedido
- `ON DELETE CASCADE` en detalle: Al eliminar pedido, elimina sus detalles

**Impacto:** Modelo de datos robusto para e-commerce.

---

## 📊 Parte 3: Tipos de Datos Avanzados

### 3.1 JSON y Arrays

```sql
CREATE TABLE configuraciones_usuario (
    id SERIAL PRIMARY KEY,
    usuario_id INTEGER UNIQUE NOT NULL,
    preferencias JSONB DEFAULT '{}',
    roles TEXT[] DEFAULT ARRAY['usuario'],
    permisos TEXT[],
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insertar datos
INSERT INTO configuraciones_usuario (usuario_id, preferencias, roles) VALUES
(1, '{"tema": "oscuro", "idioma": "es", "notificaciones": true}', ARRAY['admin', 'editor']);

-- Consultar JSON
SELECT usuario_id, preferencias->>'tema' AS tema FROM configuraciones_usuario;

-- Consultar Arrays
SELECT * FROM configuraciones_usuario WHERE 'admin' = ANY(roles);
```

---

### 3.2 UUID como Primary Key

```sql
-- Habilitar extensión
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE sesiones (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    usuario_id INTEGER NOT NULL,
    token VARCHAR(500) NOT NULL,
    ip_address INET,
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP NOT NULL
);

-- Insertar (el ID se genera automáticamente)
INSERT INTO sesiones (usuario_id, token, expires_at) VALUES
(1, 'abc123token', NOW() + INTERVAL '24 hours');

-- Ver resultado
SELECT id, usuario_id, expires_at FROM sesiones;
-- id: 550e8400-e29b-41d4-a716-446655440000
```

---

### 3.3 ENUM Personalizado

```sql
-- Crear tipo ENUM
CREATE TYPE prioridad AS ENUM ('baja', 'media', 'alta', 'urgente');
CREATE TYPE estado_tarea AS ENUM ('pendiente', 'en_progreso', 'completada', 'cancelada');

CREATE TABLE tareas (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    descripcion TEXT,
    prioridad prioridad DEFAULT 'media',
    estado estado_tarea DEFAULT 'pendiente',
    fecha_limite DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insertar
INSERT INTO tareas (titulo, prioridad, estado) VALUES
('Revisar código', 'alta', 'en_progreso');

-- Los valores inválidos fallan
-- INSERT INTO tareas (titulo, prioridad) VALUES ('Test', 'invalido');
-- ERROR: invalid input value for enum prioridad: "invalido"
```

---

## 🔄 Parte 4: Tablas Temporales

### 4.1 Tabla Temporal de Sesión

```sql
-- Solo existe durante la sesión actual
CREATE TEMPORARY TABLE resultados_temp (
    id SERIAL PRIMARY KEY,
    valor NUMERIC,
    procesado BOOLEAN DEFAULT FALSE
);

INSERT INTO resultados_temp (valor) VALUES (100), (200), (300);
SELECT * FROM resultados_temp;

-- Al cerrar la sesión, la tabla desaparece
```

---

### 4.2 CREATE TABLE AS (copiar datos)

```sql
-- Crear tabla a partir de una consulta
CREATE TABLE productos_activos AS
SELECT id, nombre, precio
FROM productos
WHERE activo = TRUE;

-- Crear tabla vacía con misma estructura
CREATE TABLE productos_backup (LIKE productos INCLUDING ALL);
```

---

## 🛠️ Parte 5: Modificar Tablas

### 5.1 Agregar Columnas

```sql
-- Agregar columna simple
ALTER TABLE productos ADD COLUMN marca VARCHAR(50);

-- Agregar con restricciones
ALTER TABLE productos ADD COLUMN peso_kg DECIMAL(8,3) CHECK (peso_kg > 0);

-- Agregar columna NOT NULL (necesita default si hay datos)
ALTER TABLE productos ADD COLUMN sku VARCHAR(50) NOT NULL DEFAULT 'PENDIENTE';
```

---

### 5.2 Modificar Columnas

```sql
-- Cambiar tipo de dato
ALTER TABLE productos ALTER COLUMN nombre TYPE VARCHAR(200);

-- Agregar NOT NULL
ALTER TABLE productos ALTER COLUMN marca SET NOT NULL;

-- Quitar NOT NULL
ALTER TABLE productos ALTER COLUMN marca DROP NOT NULL;

-- Cambiar valor por defecto
ALTER TABLE productos ALTER COLUMN stock SET DEFAULT 10;

-- Quitar default
ALTER TABLE productos ALTER COLUMN stock DROP DEFAULT;
```

---

### 5.3 Eliminar Columnas

```sql
-- Eliminar columna
ALTER TABLE productos DROP COLUMN IF EXISTS marca;

-- Eliminar con dependencias
ALTER TABLE productos DROP COLUMN categoria_id CASCADE;
```

---

### 5.4 Renombrar

```sql
-- Renombrar tabla
ALTER TABLE productos RENAME TO catalogo;

-- Renombrar columna
ALTER TABLE catalogo RENAME COLUMN nombre TO titulo;

-- Renombrar de vuelta
ALTER TABLE catalogo RENAME TO productos;
ALTER TABLE productos RENAME COLUMN titulo TO nombre;
```

---

## 🗑️ Parte 6: Eliminar Tablas

```sql
-- Eliminar tabla (falla si no existe)
DROP TABLE productos_simple;

-- Eliminar si existe
DROP TABLE IF EXISTS productos_simple;

-- Eliminar con dependencias (FK que apuntan a esta tabla)
DROP TABLE categorias CASCADE;
-- NOTICE: drop cascades to constraint fk_productos_categoria on table productos

-- Eliminar múltiples tablas
DROP TABLE IF EXISTS tabla1, tabla2, tabla3;

-- TRUNCATE: Vaciar tabla (más rápido que DELETE)
TRUNCATE TABLE productos;

-- TRUNCATE con reinicio de secuencia
TRUNCATE TABLE productos RESTART IDENTITY;

-- TRUNCATE en cascada
TRUNCATE TABLE pedidos CASCADE;
```

---

## ✅ Ejercicio Final

Crear el esquema para un **sistema de biblioteca**:

```sql
-- Tu turno: Crea las siguientes tablas

-- 1. autores (id, nombre, nacionalidad, fecha_nacimiento)
-- 2. editoriales (id, nombre, pais, website)
-- 3. libros (id, isbn, titulo, editorial_id, anio_publicacion, paginas)
-- 4. libros_autores (relación muchos a muchos)
-- 5. socios (id, numero_socio, nombre, email, fecha_alta)
-- 6. prestamos (id, libro_id, socio_id, fecha_prestamo, fecha_devolucion, devuelto)

-- Incluye:
-- - Claves primarias y foráneas
-- - Validaciones CHECK
-- - Valores DEFAULT
-- - Campos UNIQUE donde corresponda
```

---

## 📖 Navegación

|                  ⬅️ Anterior                   |                     Siguiente ➡️                     |
| :--------------------------------------------: | :--------------------------------------------------: |
| [Crear BD y Esquemas](01-crear-bases-datos.md) | [Modificar Estructuras](03-modificar-estructuras.md) |
