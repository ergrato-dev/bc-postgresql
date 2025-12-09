# ✅ Soluciones: Semana 03 - DML

---

## 🟢 Nivel Básico

### Ejercicio 1: INSERT Simple

```sql
INSERT INTO categorias (nombre, descripcion)
VALUES ('Hogar', 'Artículos para el hogar');

INSERT INTO categorias (nombre, descripcion)
VALUES ('Deportes', 'Equipamiento deportivo');

INSERT INTO categorias (nombre, descripcion)
VALUES ('Juguetes', 'Juguetes y juegos');

-- O todo junto:
INSERT INTO categorias (nombre, descripcion) VALUES
    ('Hogar', 'Artículos para el hogar'),
    ('Deportes', 'Equipamiento deportivo'),
    ('Juguetes', 'Juguetes y juegos');
```

---

### Ejercicio 2: INSERT Múltiple

```sql
INSERT INTO productos (sku, nombre, precio, stock, categoria_id) VALUES
    ('HOG-001', 'Aspiradora', 199.99, 25, 5),
    ('HOG-002', 'Licuadora', 79.99, 50, 5),
    ('DEP-001', 'Balón Fútbol', 29.99, 100, 6),
    ('DEP-002', 'Raqueta Tenis', 89.99, 30, 6),
    ('JUG-001', 'LEGO Classic', 49.99, 75, 7);
```

---

### Ejercicio 3: UPDATE Simple

```sql
-- 1. Aumentar precio de Aspiradora
UPDATE productos
SET precio = 219.99
WHERE nombre = 'Aspiradora';

-- 2. Cambiar stock de Balón Fútbol
UPDATE productos
SET stock = 150
WHERE nombre = 'Balón Fútbol';

-- 3. Desactivar producto
UPDATE productos
SET activo = FALSE
WHERE sku = 'JUG-001';
```

---

### Ejercicio 4: DELETE Simple

```sql
-- 1. Eliminar productos sin stock
DELETE FROM productos WHERE stock = 0;

-- 2. Eliminar categoría Juguetes
-- Primero verificar que no tiene productos
SELECT COUNT(*) FROM productos WHERE categoria_id = (
    SELECT id FROM categorias WHERE nombre = 'Juguetes'
);

-- Si count = 0, eliminar
DELETE FROM categorias WHERE nombre = 'Juguetes';
```

---

### Ejercicio 5: SELECT con WHERE

```sql
-- 1. Productos con precio > $100
SELECT nombre, precio FROM productos WHERE precio > 100;

-- 2. Productos de categoría 1 o 2
SELECT nombre, categoria_id FROM productos
WHERE categoria_id IN (1, 2);

-- 3. Productos con 'Samsung' en el nombre
SELECT nombre FROM productos WHERE nombre ILIKE '%Samsung%';

-- 4. Clientes sin teléfono
SELECT nombre, email FROM clientes WHERE telefono IS NULL;

-- 5. Productos activos con stock bajo
SELECT nombre, stock FROM productos
WHERE activo = TRUE AND stock < 30;
```

---

## 🟡 Nivel Intermedio

### Ejercicio 6: INSERT con RETURNING

```sql
-- 1. Insertar cliente y obtener ID
INSERT INTO clientes (email, nombre, telefono)
VALUES ('nuevo@email.com', 'Cliente Nuevo', '555-0000')
RETURNING id;
-- Supongamos que devuelve id = 6

-- 2. Insertar pedido
INSERT INTO pedidos (cliente_id, estado)
VALUES (6, 'pendiente')
RETURNING id;
-- Supongamos que devuelve id = 4

-- 3. Insertar detalles
INSERT INTO detalle_pedidos (pedido_id, producto_id, cantidad, precio_unitario)
VALUES
    (4, 1, 2, 899.99),
    (4, 6, 1, 79.99)
RETURNING *;
```

---

### Ejercicio 7: UPDATE con Expresiones

```sql
-- 1. Aumentar 15% en Electrónicos
UPDATE productos
SET precio = precio * 1.15
WHERE categoria_id = (
    SELECT id FROM categorias WHERE nombre = 'Electrónicos'
);

-- 2. Reducir stock
UPDATE productos
SET stock = stock - 5
WHERE stock > 100;

-- 3. Actualizar pedidos de hoy
UPDATE pedidos
SET estado = 'procesando'
WHERE estado = 'pendiente'
AND DATE(fecha) = CURRENT_DATE;
```

---

### Ejercicio 8: UPDATE con CASE

```sql
UPDATE productos
SET precio = CASE
    WHEN precio < 50 THEN precio * 1.20
    WHEN precio BETWEEN 50 AND 200 THEN precio * 1.10
    ELSE precio * 1.05
END
WHERE activo = TRUE
RETURNING id, nombre, precio;
```

---

### Ejercicio 9: SELECT Avanzado

```sql
-- 1. Top 5 productos más caros (general, no por categoría - eso requiere window functions)
SELECT nombre, precio, categoria_id
FROM productos
ORDER BY precio DESC
LIMIT 5;

-- 2. Valor de inventario > $10,000
SELECT
    nombre,
    precio,
    stock,
    precio * stock AS valor_inventario
FROM productos
WHERE precio * stock > 10000
ORDER BY valor_inventario DESC;

-- 3. Clientes del último mes
SELECT nombre, email, created_at
FROM clientes
WHERE created_at >= NOW() - INTERVAL '1 month';

-- 4. Ordenados por categoría y precio
SELECT categoria_id, nombre, precio
FROM productos
ORDER BY categoria_id ASC, precio DESC;

-- 5. Promedio por categoría
SELECT
    categoria_id,
    ROUND(AVG(precio)::numeric, 2) AS precio_promedio,
    COUNT(*) AS total_productos
FROM productos
GROUP BY categoria_id
ORDER BY categoria_id;
```

---

### Ejercicio 10: UPSERT

```sql
-- 1. Upsert: actualizar si existe
INSERT INTO productos (categoria_id, sku, nombre, precio, stock)
VALUES (1, 'ELEC-001', 'Smartphone Actualizado', 999.99, 100)
ON CONFLICT (sku) DO UPDATE SET
    precio = EXCLUDED.precio,
    stock = EXCLUDED.stock;

-- 2. Ignorar si existe
INSERT INTO productos (categoria_id, sku, nombre, precio, stock)
VALUES (1, 'ELEC-999', 'Nuevo Producto', 149.99, 50)
ON CONFLICT (sku) DO NOTHING;

-- 3. Múltiples upserts
INSERT INTO productos (categoria_id, sku, nombre, precio, stock) VALUES
    (1, 'ELEC-100', 'Producto A', 100, 10),
    (1, 'ELEC-101', 'Producto B', 200, 20),
    (1, 'ELEC-102', 'Producto C', 300, 30)
ON CONFLICT (sku) DO UPDATE SET
    precio = EXCLUDED.precio,
    stock = productos.stock + EXCLUDED.stock;
```

---

## 🔴 Nivel Avanzado

### Ejercicio 11: Transacción Completa

```sql
BEGIN;

-- Variables para la venta
-- producto_id = 1, cantidad = 2

-- 1. Verificar stock (si no hay suficiente, abortar)
DO $$
DECLARE
    v_stock INTEGER;
BEGIN
    SELECT stock INTO v_stock FROM productos WHERE id = 1;
    IF v_stock < 2 THEN
        RAISE EXCEPTION 'Stock insuficiente';
    END IF;
END $$;

-- 2. Crear pedido
INSERT INTO pedidos (cliente_id, estado)
VALUES (1, 'confirmado')
RETURNING id;
-- Usar el ID retornado (ej: 5)

-- 3. Agregar detalle
INSERT INTO detalle_pedidos (pedido_id, producto_id, cantidad, precio_unitario)
SELECT 5, 1, 2, precio FROM productos WHERE id = 1;

-- 4. Decrementar stock
UPDATE productos
SET stock = stock - 2
WHERE id = 1;

-- 5. Calcular total
UPDATE pedidos
SET total = (
    SELECT SUM(cantidad * precio_unitario)
    FROM detalle_pedidos
    WHERE pedido_id = 5
)
WHERE id = 5;

-- Verificar
SELECT * FROM pedidos WHERE id = 5;
SELECT * FROM productos WHERE id = 1;

COMMIT;
```

---

### Ejercicio 12: DELETE Complejo

```sql
-- 1. Eliminar detalles de pedidos cancelados
DELETE FROM detalle_pedidos
WHERE pedido_id IN (
    SELECT id FROM pedidos WHERE estado = 'cancelado'
);

-- 2. Eliminar pedidos sin detalles
DELETE FROM pedidos p
WHERE NOT EXISTS (
    SELECT 1 FROM detalle_pedidos d WHERE d.pedido_id = p.id
);

-- 3. Mover a histórico antes de eliminar
CREATE TABLE IF NOT EXISTS productos_historico (
    LIKE productos INCLUDING ALL,
    eliminado_at TIMESTAMP DEFAULT NOW()
);

WITH eliminados AS (
    DELETE FROM productos
    WHERE activo = FALSE
    AND created_at < NOW() - INTERVAL '1 year'
    RETURNING *
)
INSERT INTO productos_historico
SELECT *, NOW() FROM eliminados;
```

---

### Ejercicio 13: Consultas de Reporte

```sql
-- 1. Inventario Bajo
SELECT
    sku,
    nombre,
    stock,
    precio,
    precio * stock AS valor_inventario,
    CASE
        WHEN stock = 0 THEN 'SIN STOCK'
        WHEN stock < 10 THEN 'CRÍTICO'
        ELSE 'BAJO'
    END AS alerta
FROM productos
WHERE stock < 20
ORDER BY stock ASC;

-- 2. Ventas por Estado
SELECT
    estado,
    COUNT(*) AS cantidad_pedidos,
    SUM(total) AS total_ventas,
    ROUND(AVG(total)::numeric, 2) AS promedio_pedido
FROM pedidos
GROUP BY estado
ORDER BY total_ventas DESC;

-- 3. Productos Populares (Top 10)
SELECT
    p.nombre,
    SUM(d.cantidad) AS total_vendido,
    SUM(d.cantidad * d.precio_unitario) AS ingresos
FROM detalle_pedidos d
JOIN productos p ON d.producto_id = p.id
GROUP BY p.id, p.nombre
ORDER BY total_vendido DESC
LIMIT 10;

-- 4. Clientes VIP
SELECT
    c.nombre,
    c.email,
    COUNT(p.id) AS total_pedidos,
    COALESCE(SUM(p.total), 0) AS total_compras
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre, c.email
HAVING COUNT(p.id) > 5 OR COALESCE(SUM(p.total), 0) > 1000
ORDER BY total_compras DESC;
```

---

### Ejercicio 14: INSERT desde SELECT

```sql
-- 1. Productos en oferta
CREATE TABLE productos_oferta AS
SELECT
    id,
    sku,
    nombre,
    precio AS precio_original,
    precio * 0.8 AS precio_oferta,
    stock,
    NOW() AS fecha_oferta
FROM productos
WHERE stock > 50 AND activo = TRUE;

-- 2. Reporte mensual
CREATE TABLE IF NOT EXISTS reportes_ventas (
    id SERIAL PRIMARY KEY,
    mes DATE,
    total_pedidos INTEGER,
    total_ventas DECIMAL(12,2),
    generado_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO reportes_ventas (mes, total_pedidos, total_ventas)
SELECT
    DATE_TRUNC('month', fecha) AS mes,
    COUNT(*) AS total_pedidos,
    SUM(total) AS total_ventas
FROM pedidos
WHERE estado NOT IN ('cancelado')
GROUP BY DATE_TRUNC('month', fecha);

-- 3. Clientes activos
CREATE TABLE clientes_activos AS
SELECT DISTINCT c.*
FROM clientes c
JOIN pedidos p ON c.id = p.cliente_id
WHERE p.fecha >= NOW() - INTERVAL '6 months';
```

---

### Ejercicio 15: Migración de Datos

```sql
-- 1. Normalizar emails
UPDATE clientes
SET email = LOWER(TRIM(email))
WHERE email <> LOWER(TRIM(email));

-- 2. Limpiar espacios en nombres
UPDATE productos
SET nombre = TRIM(REGEXP_REPLACE(nombre, '\s+', ' ', 'g'))
WHERE nombre <> TRIM(REGEXP_REPLACE(nombre, '\s+', ' ', 'g'));

-- 3. Unificar teléfonos (solo dígitos)
UPDATE clientes
SET telefono = REGEXP_REPLACE(telefono, '[^0-9]', '', 'g')
WHERE telefono IS NOT NULL
AND telefono <> REGEXP_REPLACE(telefono, '[^0-9]', '', 'g');

-- 4. Generar SKUs faltantes
UPDATE productos
SET sku = 'CAT' || categoria_id || '-' || LPAD(id::TEXT, 3, '0')
WHERE sku IS NULL OR sku = '';

-- 5. Recalcular totales
UPDATE pedidos p
SET total = (
    SELECT COALESCE(SUM(cantidad * precio_unitario), 0)
    FROM detalle_pedidos d
    WHERE d.pedido_id = p.id
);
```

---

## 📖 Navegación

|        ⬅️ Ejercicios        |      🏠 Semana 03      |                  Siguiente ➡️                   |
| :-------------------------: | :--------------------: | :---------------------------------------------: |
| [Ejercicios](ejercicios.md) | [README](../README.md) | [Proyecto](../4-proyecto/proyecto-semana-03.md) |
