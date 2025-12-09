# 💻 Práctica 01: Insertar Datos

## 🎯 Objetivo

Practicar todas las formas de INSERT en PostgreSQL.

---

## 📋 Preparación

### Conectarse a PostgreSQL

```bash
docker exec -it postgres-bootcamp psql -U bootcamp -d tienda_online
```

### Crear tablas de práctica

```sql
-- Limpiar si existen
DROP TABLE IF EXISTS detalle_pedidos CASCADE;
DROP TABLE IF EXISTS pedidos CASCADE;
DROP TABLE IF EXISTS productos CASCADE;
DROP TABLE IF EXISTS categorias CASCADE;
DROP TABLE IF EXISTS clientes CASCADE;

-- Crear estructura
CREATE TABLE categorias (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT,
    activa BOOLEAN DEFAULT TRUE
);

CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    categoria_id INTEGER REFERENCES categorias(id),
    sku VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    stock INTEGER DEFAULT 0 CHECK (stock >= 0),
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    direccion TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES clientes(id),
    fecha TIMESTAMP DEFAULT NOW(),
    estado VARCHAR(20) DEFAULT 'pendiente',
    total DECIMAL(12,2) DEFAULT 0
);

CREATE TABLE detalle_pedidos (
    id SERIAL PRIMARY KEY,
    pedido_id INTEGER REFERENCES pedidos(id) ON DELETE CASCADE,
    producto_id INTEGER REFERENCES productos(id),
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL
);
```

---

## 1️⃣ INSERT Simple

### Ejercicio 1.1: Insertar una categoría

```sql
INSERT INTO categorias (nombre, descripcion)
VALUES ('Electrónicos', 'Dispositivos electrónicos y accesorios');
```

**¿Qué?** Inserta una categoría especificando nombre y descripción.

**¿Para qué?** El id se genera automáticamente (SERIAL).

**Impacto:** Una fila creada con id = 1.

---

### Ejercicio 1.2: Verificar la inserción

```sql
SELECT * FROM categorias;
```

---

### Ejercicio 1.3: Insertar más categorías

```sql
INSERT INTO categorias (nombre, descripcion)
VALUES ('Computadoras', 'Laptops, desktops y servidores');

INSERT INTO categorias (nombre, descripcion)
VALUES ('Accesorios', 'Periféricos y complementos');

INSERT INTO categorias (nombre)
VALUES ('Redes');  -- Sin descripción (será NULL)
```

---

## 2️⃣ INSERT Múltiple

### Ejercicio 2.1: Insertar varios productos a la vez

```sql
INSERT INTO productos (categoria_id, sku, nombre, precio, stock) VALUES
    (1, 'ELEC-001', 'Smartphone Samsung Galaxy', 799.99, 50),
    (1, 'ELEC-002', 'Tablet iPad Pro', 999.99, 30),
    (1, 'ELEC-003', 'Smartwatch Apple', 399.99, 100),
    (2, 'COMP-001', 'Laptop HP Pavilion', 1299.99, 25),
    (2, 'COMP-002', 'Desktop Dell Optiplex', 899.99, 15),
    (3, 'ACCE-001', 'Mouse Logitech MX', 79.99, 200),
    (3, 'ACCE-002', 'Teclado Mecánico', 129.99, 150),
    (3, 'ACCE-003', 'Monitor 27" LG', 349.99, 40);
```

**¿Qué?** Inserta 8 productos en una sola operación.

**¿Para qué?** Más eficiente que 8 INSERT separados.

**Impacto:** 8 filas creadas.

---

### Ejercicio 2.2: Verificar productos

```sql
SELECT id, sku, nombre, precio, stock FROM productos;
```

---

## 3️⃣ INSERT con RETURNING

### Ejercicio 3.1: Obtener el ID generado

```sql
INSERT INTO clientes (email, nombre, telefono)
VALUES ('maria@email.com', 'María García', '555-1234')
RETURNING id;
```

**¿Qué?** Inserta y devuelve el ID generado.

**¿Para qué?** Usar el ID inmediatamente (ej: para un pedido).

**Impacto:** Evita hacer SELECT adicional.

---

### Ejercicio 3.2: Obtener múltiples columnas

```sql
INSERT INTO clientes (email, nombre)
VALUES ('carlos@email.com', 'Carlos López')
RETURNING id, email, created_at;
```

---

### Ejercicio 3.3: Insertar más clientes y guardar resultados

```sql
-- Insertar y ver todo lo insertado
INSERT INTO clientes (email, nombre, telefono, direccion) VALUES
    ('ana@email.com', 'Ana Martínez', '555-5678', 'Calle Principal 123'),
    ('pedro@email.com', 'Pedro Sánchez', '555-9012', 'Av. Central 456'),
    ('laura@email.com', 'Laura Rodríguez', NULL, 'Plaza Mayor 789')
RETURNING *;
```

---

## 4️⃣ INSERT desde SELECT

### Ejercicio 4.1: Crear tabla de backup

```sql
-- Crear tabla de backup para productos
CREATE TABLE productos_backup (
    id INTEGER,
    sku VARCHAR(20),
    nombre VARCHAR(100),
    precio DECIMAL(10,2),
    backup_fecha TIMESTAMP DEFAULT NOW()
);

-- Copiar productos activos
INSERT INTO productos_backup (id, sku, nombre, precio)
SELECT id, sku, nombre, precio
FROM productos
WHERE activo = TRUE;

-- Verificar
SELECT * FROM productos_backup;
```

**¿Qué?** Copia datos de productos a backup.

**¿Para qué?** Respaldo rápido de datos.

**Impacto:** Tantas filas como productos activos.

---

### Ejercicio 4.2: Insertar datos transformados

```sql
-- Crear tabla de reporte
CREATE TABLE reporte_categorias (
    categoria VARCHAR(50),
    total_productos INTEGER,
    valor_inventario DECIMAL(12,2),
    generado_at TIMESTAMP DEFAULT NOW()
);

-- Insertar resumen
INSERT INTO reporte_categorias (categoria, total_productos, valor_inventario)
SELECT
    c.nombre,
    COUNT(p.id),
    SUM(p.precio * p.stock)
FROM categorias c
LEFT JOIN productos p ON c.id = p.categoria_id
GROUP BY c.nombre;

-- Ver reporte
SELECT * FROM reporte_categorias;
```

---

## 5️⃣ INSERT con ON CONFLICT (UPSERT)

### Ejercicio 5.1: Preparar escenario

```sql
-- Ver producto existente
SELECT id, sku, nombre, precio, stock FROM productos WHERE sku = 'ELEC-001';
```

---

### Ejercicio 5.2: ON CONFLICT DO NOTHING

```sql
-- Intentar insertar SKU duplicado - no hace nada
INSERT INTO productos (categoria_id, sku, nombre, precio, stock)
VALUES (1, 'ELEC-001', 'Otro Smartphone', 599.99, 10)
ON CONFLICT (sku) DO NOTHING;

-- Verificar que no cambió
SELECT id, sku, nombre, precio FROM productos WHERE sku = 'ELEC-001';
```

**¿Qué?** Si hay conflicto, ignora la inserción.

**¿Para qué?** Evitar errores de duplicado.

**Impacto:** No se inserta ni se modifica nada.

---

### Ejercicio 5.3: ON CONFLICT DO UPDATE

```sql
-- Actualizar si existe, insertar si no
INSERT INTO productos (categoria_id, sku, nombre, precio, stock)
VALUES (1, 'ELEC-001', 'Smartphone Samsung Galaxy S24', 899.99, 75)
ON CONFLICT (sku) DO UPDATE SET
    nombre = EXCLUDED.nombre,
    precio = EXCLUDED.precio,
    stock = EXCLUDED.stock;

-- Verificar actualización
SELECT id, sku, nombre, precio, stock FROM productos WHERE sku = 'ELEC-001';
```

**¿Qué?** Actualiza el producto existente con nuevos valores.

**¿Para qué?** Sincronizar datos de fuentes externas.

**Impacto:** El producto fue actualizado (no insertado).

---

### Ejercicio 5.4: UPSERT con incremento

```sql
-- Agregar stock en lugar de reemplazar
INSERT INTO productos (categoria_id, sku, nombre, precio, stock)
VALUES (3, 'ACCE-001', 'Mouse Logitech MX Master', 89.99, 50)
ON CONFLICT (sku) DO UPDATE SET
    stock = productos.stock + EXCLUDED.stock;  -- Suma al existente

-- Verificar (debe tener 200 + 50 = 250)
SELECT sku, nombre, stock FROM productos WHERE sku = 'ACCE-001';
```

---

## 6️⃣ Crear Pedidos Completos

### Ejercicio 6.1: Flujo completo de pedido

```sql
-- 1. Crear pedido y obtener ID
INSERT INTO pedidos (cliente_id, estado)
VALUES (1, 'pendiente')
RETURNING id AS pedido_id;
-- Supongamos que devuelve id = 1

-- 2. Agregar productos al pedido
INSERT INTO detalle_pedidos (pedido_id, producto_id, cantidad, precio_unitario)
VALUES
    (1, 1, 2, 899.99),   -- 2 smartphones
    (1, 6, 1, 79.99),    -- 1 mouse
    (1, 7, 1, 129.99);   -- 1 teclado

-- 3. Calcular y actualizar total
UPDATE pedidos
SET total = (
    SELECT SUM(cantidad * precio_unitario)
    FROM detalle_pedidos
    WHERE pedido_id = 1
)
WHERE id = 1
RETURNING id, total;
```

---

### Ejercicio 6.2: Todo en una transacción

```sql
BEGIN;

-- Insertar pedido
INSERT INTO pedidos (cliente_id) VALUES (2) RETURNING id;
-- Supongamos id = 2

-- Insertar detalles
INSERT INTO detalle_pedidos (pedido_id, producto_id, cantidad, precio_unitario)
SELECT 2, id, 1, precio FROM productos WHERE id IN (4, 5);

-- Actualizar total
UPDATE pedidos p
SET total = (
    SELECT SUM(cantidad * precio_unitario)
    FROM detalle_pedidos
    WHERE pedido_id = p.id
)
WHERE p.id = 2;

COMMIT;

-- Verificar
SELECT * FROM pedidos WHERE id = 2;
SELECT * FROM detalle_pedidos WHERE pedido_id = 2;
```

---

## ✅ Verificación Final

```sql
-- Resumen de datos insertados
SELECT 'categorias' AS tabla, COUNT(*) AS filas FROM categorias
UNION ALL
SELECT 'productos', COUNT(*) FROM productos
UNION ALL
SELECT 'clientes', COUNT(*) FROM clientes
UNION ALL
SELECT 'pedidos', COUNT(*) FROM pedidos
UNION ALL
SELECT 'detalle_pedidos', COUNT(*) FROM detalle_pedidos;
```

---

## 📖 Navegación

|                    ⬅️ Teoría                     |                    Siguiente ➡️                    |
| :----------------------------------------------: | :------------------------------------------------: |
| [SELECT Básico](../1-teoria/04-select-basico.md) | [Actualizar y Eliminar](02-actualizar-eliminar.md) |
