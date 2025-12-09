# ✅ Soluciones: Semana 02 - DDL

---

## 🟢 Nivel Básico

### Ejercicio 1: Crear Tabla de Productos

```sql
CREATE TABLE articulos (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2),
    disponible BOOLEAN DEFAULT TRUE
);
```

---

### Ejercicio 2: Tipos de Datos Correctos

| Dato                 | Tipo de Dato                | Explicación                             |
| -------------------- | --------------------------- | --------------------------------------- |
| Número de teléfono   | `VARCHAR(20)`               | Puede incluir símbolos (+, -, espacios) |
| Salario mensual      | `DECIMAL(10,2)`             | Precisión exacta para dinero            |
| Fecha de nacimiento  | `DATE`                      | Solo necesita fecha, no hora            |
| Biografía de usuario | `TEXT`                      | Longitud variable sin límite            |
| Cantidad en stock    | `INTEGER`                   | Número entero positivo                  |
| ¿Es miembro VIP?     | `BOOLEAN`                   | Sí/No                                   |
| Hora de apertura     | `TIME`                      | Solo hora, sin fecha                    |
| Código postal        | `VARCHAR(10)`               | Puede tener letras (ej: UK)             |
| Coordenadas GPS      | `POINT` o `DECIMAL(9,6)` x2 | Lat/Long con precisión                  |
| Configuración JSON   | `JSONB`                     | Datos semiestructurados                 |

---

### Ejercicio 3: Agregar Columnas

```sql
-- 1. Email único y no nulo
ALTER TABLE clientes ADD COLUMN email VARCHAR(255) UNIQUE NOT NULL;

-- 2. Fecha de registro con default
ALTER TABLE clientes ADD COLUMN fecha_registro TIMESTAMP DEFAULT NOW();

-- 3. Crédito con CHECK (permite NULL)
ALTER TABLE clientes ADD COLUMN credito_disponible DECIMAL(10,2)
    CHECK (credito_disponible > 0 OR credito_disponible IS NULL);

-- 4. Activo con default
ALTER TABLE clientes ADD COLUMN activo BOOLEAN DEFAULT TRUE;

-- Verificar
\d clientes
```

---

## 🟡 Nivel Intermedio

### Ejercicio 4: Sistema de Cursos

```sql
-- Tabla de profesores
CREATE TABLE profesores (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    especialidad VARCHAR(100)
);

-- Tabla de cursos
CREATE TABLE cursos (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    descripcion TEXT,
    profesor_id INTEGER NOT NULL,
    precio DECIMAL(10,2) CHECK (precio >= 0),
    duracion_horas INTEGER CHECK (duracion_horas > 0),

    CONSTRAINT fk_cursos_profesor
        FOREIGN KEY (profesor_id)
        REFERENCES profesores(id)
        ON DELETE RESTRICT
);

-- Tabla de estudiantes
CREATE TABLE estudiantes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    fecha_inscripcion DATE DEFAULT CURRENT_DATE
);

-- Tabla de inscripciones (relación muchos a muchos)
CREATE TABLE inscripciones (
    estudiante_id INTEGER NOT NULL,
    curso_id INTEGER NOT NULL,
    fecha TIMESTAMP DEFAULT NOW(),
    calificacion INTEGER CHECK (calificacion >= 0 AND calificacion <= 100),
    completado BOOLEAN DEFAULT FALSE,

    CONSTRAINT pk_inscripciones PRIMARY KEY (estudiante_id, curso_id),

    CONSTRAINT fk_inscripciones_estudiante
        FOREIGN KEY (estudiante_id)
        REFERENCES estudiantes(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_inscripciones_curso
        FOREIGN KEY (curso_id)
        REFERENCES cursos(id)
        ON DELETE CASCADE
);
```

---

### Ejercicio 5: Modificaciones Complejas

```sql
-- 1. Dividir nombre_completo en nombre y apellido
ALTER TABLE empleados
    ADD COLUMN nombre VARCHAR(100),
    ADD COLUMN apellido VARCHAR(100);

UPDATE empleados SET
    nombre = SPLIT_PART(nombre_completo, ' ', 1),
    apellido = COALESCE(NULLIF(SPLIT_PART(nombre_completo, ' ', 2), ''), 'Sin apellido');

ALTER TABLE empleados
    ALTER COLUMN nombre SET NOT NULL,
    ALTER COLUMN apellido SET NOT NULL;

-- 2. Cambiar salario a DECIMAL con CHECK
ALTER TABLE empleados ALTER COLUMN salario TYPE DECIMAL(12,2);
ALTER TABLE empleados ADD CONSTRAINT chk_salario_positivo CHECK (salario > 0);

-- 3. Crear tabla departamentos y agregar FK
CREATE TABLE departamentos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);

-- Migrar datos únicos de departamento
INSERT INTO departamentos (nombre)
SELECT DISTINCT departamento FROM empleados WHERE departamento IS NOT NULL;

-- Agregar columna FK
ALTER TABLE empleados ADD COLUMN departamento_id INTEGER;

-- Llenar la FK
UPDATE empleados e
SET departamento_id = d.id
FROM departamentos d
WHERE e.departamento = d.nombre;

-- Agregar constraint FK
ALTER TABLE empleados ADD CONSTRAINT fk_empleados_departamento
    FOREIGN KEY (departamento_id) REFERENCES departamentos(id);

-- Eliminar columna antigua
ALTER TABLE empleados DROP COLUMN departamento;

-- 4. Agregar fecha_contratacion
ALTER TABLE empleados ADD COLUMN fecha_contratacion DATE DEFAULT CURRENT_DATE;

-- 5. Agregar email único
ALTER TABLE empleados ADD COLUMN email VARCHAR(255) UNIQUE;
```

---

### Ejercicio 6: Constraints

```sql
-- 1. Edad entre 0 y 150
CHECK (edad >= 0 AND edad <= 150)
-- O usando BETWEEN:
CHECK (edad BETWEEN 0 AND 150)

-- 2. Porcentaje entre 0 y 100
CHECK (porcentaje BETWEEN 0 AND 100)

-- 3. Email contiene '@'
CHECK (email LIKE '%@%')
-- Más robusto:
CHECK (email ~ '^[^@]+@[^@]+\.[^@]+$')

-- 4. fecha_fin >= fecha_inicio
CHECK (fecha_fin >= fecha_inicio)

-- 5. Estado con valores específicos
CHECK (estado IN ('activo', 'inactivo', 'pendiente'))

-- 6. Código de exactamente 10 caracteres
CHECK (LENGTH(codigo) = 10)

-- 7. Precio positivo
CHECK (precio > 0)

-- 8. Stock no negativo
CHECK (stock >= 0)
```

---

## 🔴 Nivel Avanzado

### Ejercicio 7: Sistema de E-commerce

```sql
-- Habilitar extensiones
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Crear esquemas
CREATE SCHEMA IF NOT EXISTS catalogo;
CREATE SCHEMA IF NOT EXISTS ventas;
CREATE SCHEMA IF NOT EXISTS inventario;

-- =========== ESQUEMA CATALOGO ===========

-- Marcas
CREATE TABLE catalogo.marcas (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    pais_origen VARCHAR(50),
    logo_url TEXT
);

-- Categorías (autorreferencia)
CREATE TABLE catalogo.categorias (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    categoria_padre_id INTEGER,

    CONSTRAINT fk_categoria_padre
        FOREIGN KEY (categoria_padre_id)
        REFERENCES catalogo.categorias(id)
        ON DELETE SET NULL
);

-- Productos
CREATE TABLE catalogo.productos (
    id SERIAL PRIMARY KEY,
    sku VARCHAR(50) UNIQUE NOT NULL,
    nombre VARCHAR(200) NOT NULL,
    marca_id INTEGER,
    categoria_id INTEGER,
    precio DECIMAL(12,2) NOT NULL CHECK (precio > 0),
    descripcion TEXT,
    specs JSONB DEFAULT '{}',
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),

    CONSTRAINT fk_producto_marca
        FOREIGN KEY (marca_id)
        REFERENCES catalogo.marcas(id)
        ON DELETE SET NULL,

    CONSTRAINT fk_producto_categoria
        FOREIGN KEY (categoria_id)
        REFERENCES catalogo.categorias(id)
        ON DELETE SET NULL
);

CREATE INDEX idx_productos_sku ON catalogo.productos(sku);
CREATE INDEX idx_productos_nombre ON catalogo.productos USING gin(to_tsvector('spanish', nombre));
CREATE INDEX idx_productos_specs ON catalogo.productos USING gin(specs);

-- =========== ESQUEMA VENTAS ===========

-- ENUM para estados de orden
CREATE TYPE ventas.estado_orden AS ENUM (
    'pendiente', 'confirmado', 'procesando',
    'enviado', 'entregado', 'cancelado', 'devuelto'
);

-- Clientes
CREATE TABLE ventas.clientes (
    id SERIAL PRIMARY KEY,
    uuid UUID UNIQUE DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    datos_personales JSONB DEFAULT '{}',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_clientes_email ON ventas.clientes(email);

-- Direcciones
CREATE TABLE ventas.direcciones (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER NOT NULL,
    tipo VARCHAR(20) CHECK (tipo IN ('envio', 'facturacion')),
    direccion_completa TEXT NOT NULL,
    predeterminada BOOLEAN DEFAULT FALSE,

    CONSTRAINT fk_direccion_cliente
        FOREIGN KEY (cliente_id)
        REFERENCES ventas.clientes(id)
        ON DELETE CASCADE
);

-- Carritos
CREATE TABLE ventas.carritos (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER UNIQUE NOT NULL,
    creado_at TIMESTAMPTZ DEFAULT NOW(),
    actualizado_at TIMESTAMPTZ DEFAULT NOW(),

    CONSTRAINT fk_carrito_cliente
        FOREIGN KEY (cliente_id)
        REFERENCES ventas.clientes(id)
        ON DELETE CASCADE
);

-- Items del carrito
CREATE TABLE ventas.carrito_items (
    carrito_id INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    agregado_at TIMESTAMPTZ DEFAULT NOW(),

    PRIMARY KEY (carrito_id, producto_id),

    CONSTRAINT fk_carrito_item_carrito
        FOREIGN KEY (carrito_id)
        REFERENCES ventas.carritos(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_carrito_item_producto
        FOREIGN KEY (producto_id)
        REFERENCES catalogo.productos(id)
        ON DELETE CASCADE
);

-- Ordenes
CREATE TABLE ventas.ordenes (
    id SERIAL PRIMARY KEY,
    numero_orden VARCHAR(20) UNIQUE NOT NULL,
    cliente_id INTEGER NOT NULL,
    direccion_envio_id INTEGER,
    estado ventas.estado_orden DEFAULT 'pendiente',
    total DECIMAL(12,2) NOT NULL CHECK (total >= 0),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),

    CONSTRAINT fk_orden_cliente
        FOREIGN KEY (cliente_id)
        REFERENCES ventas.clientes(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_orden_direccion
        FOREIGN KEY (direccion_envio_id)
        REFERENCES ventas.direcciones(id)
        ON DELETE SET NULL
);

CREATE INDEX idx_ordenes_numero ON ventas.ordenes(numero_orden);
CREATE INDEX idx_ordenes_cliente ON ventas.ordenes(cliente_id);
CREATE INDEX idx_ordenes_estado ON ventas.ordenes(estado);

-- Items de orden
CREATE TABLE ventas.orden_items (
    orden_id INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL CHECK (precio_unitario > 0),
    subtotal DECIMAL(12,2) GENERATED ALWAYS AS (cantidad * precio_unitario) STORED,

    PRIMARY KEY (orden_id, producto_id),

    CONSTRAINT fk_orden_item_orden
        FOREIGN KEY (orden_id)
        REFERENCES ventas.ordenes(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_orden_item_producto
        FOREIGN KEY (producto_id)
        REFERENCES catalogo.productos(id)
        ON DELETE RESTRICT
);

-- =========== ESQUEMA INVENTARIO ===========

-- Almacenes
CREATE TABLE inventario.almacenes (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(10) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    ubicacion POINT,
    activo BOOLEAN DEFAULT TRUE
);

-- Stock
CREATE TABLE inventario.stock (
    almacen_id INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    cantidad INTEGER NOT NULL DEFAULT 0 CHECK (cantidad >= 0),
    minimo_alerta INTEGER DEFAULT 10,
    updated_at TIMESTAMPTZ DEFAULT NOW(),

    PRIMARY KEY (almacen_id, producto_id),

    CONSTRAINT fk_stock_almacen
        FOREIGN KEY (almacen_id)
        REFERENCES inventario.almacenes(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_stock_producto
        FOREIGN KEY (producto_id)
        REFERENCES catalogo.productos(id)
        ON DELETE CASCADE
);

CREATE INDEX idx_stock_bajo ON inventario.stock(producto_id)
    WHERE cantidad < minimo_alerta;
```

---

### Ejercicio 8: Migraciones

```sql
-- Habilitar extensión UUID
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. Crear nueva tabla
CREATE TABLE usuarios_v2 (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_legacy INTEGER,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100),
    perfil JSONB DEFAULT '{}',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Migrar datos
INSERT INTO usuarios_v2 (id_legacy, nombre, apellido, perfil)
SELECT
    id,
    SPLIT_PART(nombre, ' ', 1),
    NULLIF(SPLIT_PART(nombre, ' ', 2), ''),
    CASE
        WHEN datos IS NOT NULL AND datos != ''
        THEN datos::JSONB
        ELSE '{}'::JSONB
    END
FROM usuarios_v1;

-- 3. Verificar migración
SELECT COUNT(*) FROM usuarios_v1;
SELECT COUNT(*) FROM usuarios_v2;

-- 4. (Opcional) Renombrar tablas
ALTER TABLE usuarios_v1 RENAME TO usuarios_deprecated;
ALTER TABLE usuarios_v2 RENAME TO usuarios;
```

---

### Ejercicio 9: Tabla de Auditoría

```sql
-- Crear esquema
CREATE SCHEMA IF NOT EXISTS auditoria;

-- Habilitar UUID
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Crear tabla de auditoría
CREATE TABLE auditoria.cambios (
    id UUID DEFAULT uuid_generate_v4(),
    tabla_afectada VARCHAR(100) NOT NULL,
    operacion VARCHAR(10) NOT NULL,
    datos_anteriores JSONB,
    datos_nuevos JSONB,
    usuario VARCHAR(100) DEFAULT current_user,
    fecha_hora TIMESTAMPTZ DEFAULT NOW(),
    ip_cliente INET,

    CONSTRAINT chk_operacion_valida
        CHECK (operacion IN ('INSERT', 'UPDATE', 'DELETE')),

    CONSTRAINT chk_datos_coherentes
        CHECK (
            (operacion = 'INSERT' AND datos_anteriores IS NULL) OR
            (operacion = 'DELETE' AND datos_nuevos IS NULL) OR
            (operacion = 'UPDATE')
        )
) PARTITION BY RANGE (fecha_hora);

-- Crear particiones mensuales
CREATE TABLE auditoria.cambios_2025_12 PARTITION OF auditoria.cambios
    FOR VALUES FROM ('2025-12-01') TO ('2026-01-01');

CREATE TABLE auditoria.cambios_2026_01 PARTITION OF auditoria.cambios
    FOR VALUES FROM ('2026-01-01') TO ('2026-02-01');

-- Índices
CREATE INDEX idx_cambios_tabla ON auditoria.cambios(tabla_afectada);
CREATE INDEX idx_cambios_fecha ON auditoria.cambios(fecha_hora);
CREATE INDEX idx_cambios_usuario ON auditoria.cambios(usuario);
```

---

### Ejercicio 10: Optimización de Tipos

```sql
-- Tabla corregida
CREATE TABLE pedidos_optimizado (
    -- Problema 1: VARCHAR para ID
    -- Solución: SERIAL o UUID para identificadores
    id SERIAL PRIMARY KEY,

    -- Problema 2: TEXT para fecha
    -- Solución: TIMESTAMPTZ para fechas
    fecha TIMESTAMPTZ DEFAULT NOW() NOT NULL,

    -- Problema 3: VARCHAR(1000) excesivo para nombre
    -- Solución: VARCHAR(150) es suficiente para nombres
    cliente_nombre VARCHAR(150) NOT NULL,

    -- Problema 4: REAL para dinero (impreciso)
    -- Solución: DECIMAL para valores monetarios exactos
    total DECIMAL(12,2) NOT NULL CHECK (total >= 0),

    -- Problema 5: TEXT para items estructurados
    -- Solución: JSONB para datos semiestructurados
    items JSONB NOT NULL DEFAULT '[]',

    -- Problema 6: VARCHAR(255) sin restricción para estados
    -- Solución: ENUM o CHECK con valores específicos
    estado VARCHAR(20) DEFAULT 'pendiente'
        CHECK (estado IN ('pendiente', 'pagado', 'enviado', 'entregado', 'cancelado')),

    -- Problema 7: VARCHAR para número
    -- Solución: DECIMAL para porcentajes/descuentos
    descuento DECIMAL(5,2) DEFAULT 0 CHECK (descuento BETWEEN 0 AND 100),

    -- Problema 8: VARCHAR para booleano
    -- Solución: BOOLEAN nativo
    activo BOOLEAN DEFAULT TRUE NOT NULL,

    -- Problema 9: VARCHAR para IP
    -- Solución: INET tipo nativo de PostgreSQL
    ip_cliente INET,

    -- Problema 10: VARCHAR(MAX) no existe en PostgreSQL
    -- Solución: JSONB para metadata flexible
    metadata JSONB DEFAULT '{}'
);

-- Índices recomendados
CREATE INDEX idx_pedidos_fecha ON pedidos_optimizado(fecha);
CREATE INDEX idx_pedidos_estado ON pedidos_optimizado(estado);
CREATE INDEX idx_pedidos_cliente ON pedidos_optimizado(cliente_nombre);
CREATE INDEX idx_pedidos_metadata ON pedidos_optimizado USING gin(metadata);
```

---

## 📖 Navegación

|        ⬅️ Ejercicios        |      🏠 Semana 02      |                  Siguiente ➡️                   |
| :-------------------------: | :--------------------: | :---------------------------------------------: |
| [Ejercicios](ejercicios.md) | [README](../README.md) | [Proyecto](../4-proyecto/proyecto-semana-02.md) |
