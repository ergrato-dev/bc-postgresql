# 💻 Práctica 02: Actualizar y Eliminar Datos

## 🎯 Objetivo

Practicar UPDATE y DELETE de forma segura en PostgreSQL.

---

## 📋 Preparación

Usaremos las tablas creadas en la práctica anterior. Si no las tienes:

```bash
docker exec -it postgres-bootcamp psql -U bootcamp -d tienda_online
```

Verifica que hay datos:

```sql
SELECT COUNT(*) FROM productos;
SELECT COUNT(*) FROM clientes;
```

---

## ✏️ PARTE 1: UPDATE

### 1.1 UPDATE Simple

```sql
-- Ver estado actual
SELECT id, nombre, precio FROM productos WHERE id = 1;

-- Actualizar precio
UPDATE productos
SET precio = 849.99
WHERE id = 1;

-- Verificar cambio
SELECT id, nombre, precio FROM productos WHERE id = 1;
```

**¿Qué?** Modifica el precio del producto con id = 1.

**¿Para qué?** Actualizar un valor específico.

**Impacto:** Una fila afectada.

---

### 1.2 UPDATE Múltiples Columnas

```sql
-- Actualizar varios campos a la vez
UPDATE productos
SET
    nombre = 'Smartphone Samsung Galaxy S24 Ultra',
    precio = 999.99,
    stock = 45
WHERE id = 1;

-- Verificar
SELECT id, nombre, precio, stock FROM productos WHERE id = 1;
```

---

### 1.3 UPDATE con Expresiones

```sql
-- Aumentar precio 10% a todos los electrónicos
UPDATE productos
SET precio = precio * 1.10
WHERE categoria_id = 1;

-- Verificar
SELECT id, nombre, precio FROM productos WHERE categoria_id = 1;
```

---

### 1.4 UPDATE con RETURNING

```sql
-- Aplicar descuento y ver resultado
UPDATE productos
SET precio = precio * 0.85
WHERE categoria_id = 3
RETURNING id, nombre, precio AS nuevo_precio;
```

**¿Qué?** Aplica 15% de descuento y muestra los valores actualizados.

**¿Para qué?** Ver inmediatamente qué se modificó.

**Impacto:** Muestra las filas afectadas sin SELECT adicional.

---

### 1.5 UPDATE Condicional con CASE

```sql
-- Ajustar stock según nivel actual
UPDATE productos
SET stock = CASE
    WHEN stock < 20 THEN stock + 50      -- Reabastecer bajo stock
    WHEN stock > 150 THEN stock - 30     -- Reducir exceso
    ELSE stock                            -- Mantener normal
END
WHERE activo = TRUE;

-- Ver resultado
SELECT id, nombre, stock FROM productos ORDER BY stock;
```

---

### 1.6 UPDATE con Subconsulta

```sql
-- Desactivar productos sin categoría activa
UPDATE productos
SET activo = FALSE
WHERE categoria_id IN (
    SELECT id FROM categorias WHERE activa = FALSE
);

-- O usando EXISTS
UPDATE productos p
SET activo = FALSE
WHERE EXISTS (
    SELECT 1 FROM categorias c
    WHERE c.id = p.categoria_id
    AND c.activa = FALSE
);
```

---

### 1.7 UPDATE con FROM (JOIN implícito)

```sql
-- Primero crear un descuento por categoría
ALTER TABLE categorias ADD COLUMN IF NOT EXISTS descuento DECIMAL(5,2) DEFAULT 0;

UPDATE categorias SET descuento = 0.10 WHERE nombre = 'Accesorios';
UPDATE categorias SET descuento = 0.05 WHERE nombre = 'Electrónicos';

-- Aplicar descuento de categoría a productos
UPDATE productos p
SET precio = precio * (1 - c.descuento)
FROM categorias c
WHERE p.categoria_id = c.id
AND c.descuento > 0
RETURNING p.id, p.nombre, p.precio, c.descuento;
```

---

## ⚠️ Práctica de Seguridad: UPDATE

### 1.8 Patrón Seguro: SELECT primero

```sql
-- 1. VER qué vas a actualizar
SELECT id, nombre, precio, stock
FROM productos
WHERE stock = 0;

-- 2. Si es correcto, ejecutar UPDATE
UPDATE productos
SET activo = FALSE
WHERE stock = 0;

-- 3. Verificar resultado
SELECT id, nombre, activo FROM productos WHERE stock = 0;
```

---

### 1.9 Usando Transacciones

```sql
BEGIN;

-- Hacer UPDATE
UPDATE productos
SET precio = precio * 0.5
WHERE categoria_id = 2;

-- Verificar resultado
SELECT id, nombre, precio FROM productos WHERE categoria_id = 2;

-- ¿Está bien? Si no:
-- ROLLBACK;

-- Si está bien:
COMMIT;
```

---

## 🗑️ PARTE 2: DELETE

### 2.1 DELETE Simple

```sql
-- Crear productos de prueba para eliminar
INSERT INTO productos (categoria_id, sku, nombre, precio, stock, activo)
VALUES
    (1, 'TEST-001', 'Producto Test 1', 9.99, 0, FALSE),
    (1, 'TEST-002', 'Producto Test 2', 19.99, 0, FALSE),
    (1, 'TEST-003', 'Producto Test 3', 29.99, 0, FALSE);

-- Verificar
SELECT * FROM productos WHERE sku LIKE 'TEST%';

-- Eliminar uno
DELETE FROM productos WHERE sku = 'TEST-001';

-- Verificar
SELECT * FROM productos WHERE sku LIKE 'TEST%';
```

---

### 2.2 DELETE con Múltiples Condiciones

```sql
-- Eliminar productos de prueba inactivos sin stock
DELETE FROM productos
WHERE sku LIKE 'TEST%'
AND activo = FALSE
AND stock = 0;

-- Verificar que se eliminaron
SELECT * FROM productos WHERE sku LIKE 'TEST%';
```

---

### 2.3 DELETE con RETURNING

```sql
-- Insertar más datos de prueba
INSERT INTO productos (categoria_id, sku, nombre, precio, stock)
VALUES
    (3, 'TEMP-001', 'Temporal 1', 5.99, 0),
    (3, 'TEMP-002', 'Temporal 2', 6.99, 0);

-- Eliminar y ver qué se eliminó
DELETE FROM productos
WHERE sku LIKE 'TEMP%'
RETURNING id, sku, nombre;
```

---

### 2.4 DELETE con Subconsulta

```sql
-- Crear categoría temporal
INSERT INTO categorias (nombre, activa) VALUES ('Temporal', FALSE);

-- Agregar producto a categoría temporal
INSERT INTO productos (categoria_id, sku, nombre, precio)
SELECT id, 'CAT-TEMP-001', 'Producto Categoría Temporal', 1.99
FROM categorias WHERE nombre = 'Temporal';

-- Eliminar productos de categorías inactivas
DELETE FROM productos
WHERE categoria_id IN (
    SELECT id FROM categorias WHERE activa = FALSE
)
RETURNING *;

-- Eliminar la categoría temporal
DELETE FROM categorias WHERE nombre = 'Temporal';
```

---

### 2.5 DELETE con USING

```sql
-- Ejemplo: Eliminar detalles de pedidos cancelados
-- Primero crear escenario
INSERT INTO pedidos (cliente_id, estado) VALUES (1, 'cancelado') RETURNING id;
-- Supongamos id = 3

INSERT INTO detalle_pedidos (pedido_id, producto_id, cantidad, precio_unitario)
VALUES (3, 1, 1, 999.99);

-- Eliminar detalles de pedidos cancelados usando USING
DELETE FROM detalle_pedidos d
USING pedidos p
WHERE d.pedido_id = p.id
AND p.estado = 'cancelado'
RETURNING d.*;

-- Eliminar pedidos cancelados
DELETE FROM pedidos WHERE estado = 'cancelado';
```

---

## ⚠️ Práctica de Seguridad: DELETE

### 2.6 Patrón Seguro

```sql
-- 1. SIEMPRE ver qué vas a eliminar primero
SELECT * FROM productos
WHERE created_at < NOW() - INTERVAL '1 year'
AND activo = FALSE;

-- 2. Contar cuántas filas
SELECT COUNT(*) FROM productos
WHERE created_at < NOW() - INTERVAL '1 year'
AND activo = FALSE;

-- 3. Si es correcto, dentro de transacción
BEGIN;

DELETE FROM productos
WHERE created_at < NOW() - INTERVAL '1 year'
AND activo = FALSE;

-- 4. Verificar
SELECT COUNT(*) FROM productos;

-- 5. Confirmar o revertir
COMMIT;  -- o ROLLBACK;
```

---

### 2.7 Soft Delete (Eliminación Lógica)

```sql
-- En lugar de eliminar, marcar como eliminado
ALTER TABLE productos ADD COLUMN IF NOT EXISTS
    deleted_at TIMESTAMP NULL;

-- "Eliminar" (soft delete)
UPDATE productos
SET
    deleted_at = NOW(),
    activo = FALSE
WHERE id = 6;

-- Las consultas normales filtran eliminados
SELECT * FROM productos WHERE deleted_at IS NULL;

-- Restaurar
UPDATE productos
SET deleted_at = NULL, activo = TRUE
WHERE id = 6;
```

---

## 🔄 PARTE 3: Ejercicios Combinados

### 3.1 Actualizar Totales de Pedidos

```sql
-- Recalcular total de todos los pedidos
UPDATE pedidos p
SET total = (
    SELECT COALESCE(SUM(cantidad * precio_unitario), 0)
    FROM detalle_pedidos d
    WHERE d.pedido_id = p.id
);

-- Verificar
SELECT id, cliente_id, total FROM pedidos;
```

---

### 3.2 Decrementar Stock al Vender

```sql
BEGIN;

-- Simular venta: decrementar stock
UPDATE productos
SET stock = stock - 1
WHERE id = 1 AND stock > 0
RETURNING id, nombre, stock;

-- Si no hay stock suficiente, no actualiza nada

COMMIT;
```

---

### 3.3 Limpiar Datos Antiguos

```sql
BEGIN;

-- Ver registros antiguos
SELECT COUNT(*) AS pedidos_antiguos
FROM pedidos
WHERE fecha < NOW() - INTERVAL '2 years';

-- Eliminar detalles primero (por FK) o usar CASCADE
DELETE FROM pedidos
WHERE fecha < NOW() - INTERVAL '2 years';

COMMIT;
```

---

## ✅ Verificación Final

```sql
-- Estado final de las tablas
SELECT
    'productos' AS tabla,
    COUNT(*) AS total,
    COUNT(*) FILTER (WHERE activo = TRUE) AS activos
FROM productos
UNION ALL
SELECT
    'categorias',
    COUNT(*),
    COUNT(*) FILTER (WHERE activa = TRUE)
FROM categorias;
```

---

## 📖 Navegación

|              ⬅️ Anterior               |                 Siguiente ➡️                 |
| :------------------------------------: | :------------------------------------------: |
| [Insertar Datos](01-insertar-datos.md) | [Consultas Básicas](03-consultas-basicas.md) |
