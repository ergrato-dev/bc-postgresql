# ✏️ UPDATE y DELETE

## 🎯 Objetivo

Dominar la modificación y eliminación de datos de forma segura.

---

## ✏️ UPDATE - Modificar Datos

### Sintaxis Básica

```sql
UPDATE nombre_tabla
SET columna1 = valor1, columna2 = valor2, ...
WHERE condicion;
```

---

## 📋 Formas de UPDATE

### 1. UPDATE Simple

```sql
-- Actualizar un campo
UPDATE productos
SET precio = 899.99
WHERE id = 5;
```

**¿Qué?** Modifica el precio del producto con id = 5.

**¿Para qué?** Actualizar un valor específico.

**Impacto:** Solo afecta filas que cumplen la condición.

---

### 2. UPDATE Múltiples Columnas

```sql
-- Actualizar varios campos
UPDATE productos
SET
    precio = 899.99,
    stock = 100,
    updated_at = NOW()
WHERE id = 5;
```

---

### 3. UPDATE con Expresiones

```sql
-- Aumentar precio 10%
UPDATE productos
SET precio = precio * 1.10
WHERE categoria_id = 3;

-- Decrementar stock
UPDATE productos
SET stock = stock - 1
WHERE id = 5 AND stock > 0;

-- Concatenar texto
UPDATE productos
SET nombre = nombre || ' (Descontinuado)'
WHERE activo = FALSE;
```

---

### 4. UPDATE con Subconsulta

```sql
-- Actualizar basándose en otra tabla
UPDATE productos
SET categoria_id = (
    SELECT id FROM categorias WHERE nombre = 'Electrónicos'
)
WHERE nombre LIKE '%Laptop%';

-- Actualizar con datos de otra tabla
UPDATE pedidos
SET total = (
    SELECT SUM(cantidad * precio_unitario)
    FROM detalle_pedidos
    WHERE pedido_id = pedidos.id
);
```

---

### 5. UPDATE con FROM (PostgreSQL)

```sql
-- Actualizar usando JOIN implícito
UPDATE productos p
SET precio = p.precio * c.descuento
FROM categorias c
WHERE p.categoria_id = c.id
AND c.nombre = 'Liquidación';
```

**¿Qué?** Actualiza productos usando datos de otra tabla.

**¿Para qué?** Updates complejos basados en relaciones.

**Impacto:** Más legible que subconsultas para JOINs.

---

### 6. UPDATE con RETURNING

```sql
-- Ver qué se actualizó
UPDATE productos
SET precio = precio * 0.9
WHERE categoria_id = 5
RETURNING id, nombre, precio;

-- Obtener valores anteriores y nuevos (truco)
UPDATE productos
SET precio = precio * 0.9
WHERE id = 5
RETURNING id, precio AS nuevo_precio;
```

---

### 7. UPDATE Condicional con CASE

```sql
-- Diferentes actualizaciones según condiciones
UPDATE productos
SET precio = CASE
    WHEN stock > 100 THEN precio * 0.9   -- Descuento si hay mucho stock
    WHEN stock < 10 THEN precio * 1.1    -- Aumentar si hay poco
    ELSE precio                           -- Mantener si es normal
END
WHERE categoria_id = 3;
```

---

## 🗑️ DELETE - Eliminar Datos

### Sintaxis Básica

```sql
DELETE FROM nombre_tabla
WHERE condicion;
```

---

## 📋 Formas de DELETE

### 1. DELETE Simple

```sql
-- Eliminar una fila específica
DELETE FROM productos
WHERE id = 5;
```

**¿Qué?** Elimina el producto con id = 5.

**¿Para qué?** Remover un registro específico.

**Impacto:** La fila se elimina permanentemente.

---

### 2. DELETE con Condiciones Múltiples

```sql
-- Eliminar con múltiples condiciones
DELETE FROM productos
WHERE activo = FALSE
AND created_at < '2024-01-01';

-- Eliminar usando IN
DELETE FROM productos
WHERE id IN (1, 3, 5, 7, 9);

-- Eliminar usando BETWEEN
DELETE FROM logs
WHERE fecha BETWEEN '2024-01-01' AND '2024-06-30';
```

---

### 3. DELETE con Subconsulta

```sql
-- Eliminar productos sin ventas
DELETE FROM productos
WHERE id NOT IN (
    SELECT DISTINCT producto_id FROM detalle_pedidos
);

-- Eliminar usando EXISTS
DELETE FROM clientes c
WHERE NOT EXISTS (
    SELECT 1 FROM pedidos p WHERE p.cliente_id = c.id
);
```

---

### 4. DELETE con USING (PostgreSQL)

```sql
-- Eliminar usando otra tabla
DELETE FROM productos
USING categorias c
WHERE productos.categoria_id = c.id
AND c.nombre = 'Obsoleto';
```

---

### 5. DELETE con RETURNING

```sql
-- Ver qué se eliminó
DELETE FROM productos
WHERE stock = 0
RETURNING id, nombre;

-- Mover a histórico antes de eliminar
WITH eliminados AS (
    DELETE FROM productos
    WHERE activo = FALSE
    RETURNING *
)
INSERT INTO productos_historico
SELECT *, NOW() AS eliminado_at FROM eliminados;
```

---

### 6. DELETE Todo (Truncate es más eficiente)

```sql
-- Eliminar todas las filas (lento para tablas grandes)
DELETE FROM logs;

-- Mejor alternativa: TRUNCATE (DDL, más rápido)
TRUNCATE TABLE logs;

-- TRUNCATE con reinicio de secuencia
TRUNCATE TABLE logs RESTART IDENTITY;

-- TRUNCATE en cascada
TRUNCATE TABLE pedidos CASCADE;
```

---

## ⚠️ Seguridad en UPDATE y DELETE

### La Regla de Oro

```sql
-- ⚠️⚠️⚠️ NUNCA ejecutar sin WHERE ⚠️⚠️⚠️
UPDATE productos SET precio = 0;        -- Todos los precios a 0
DELETE FROM clientes;                   -- Elimina TODOS los clientes

-- ✅ Siempre usar WHERE
UPDATE productos SET precio = 0 WHERE id = 5;
DELETE FROM clientes WHERE id = 10;
```

---

### Patrón Seguro: SELECT Primero

```sql
-- 1. Ver qué vas a afectar
SELECT id, nombre, precio
FROM productos
WHERE categoria_id = 5 AND stock < 10;

-- 2. Si es correcto, ejecutar UPDATE/DELETE
UPDATE productos
SET activo = FALSE
WHERE categoria_id = 5 AND stock < 10;
```

---

### Patrón Seguro: Transacciones

```sql
BEGIN;

-- Ejecutar UPDATE/DELETE
DELETE FROM productos WHERE stock = 0;

-- Verificar resultado
SELECT COUNT(*) FROM productos;

-- Si está bien: COMMIT
-- Si hay error: ROLLBACK
COMMIT;
```

---

### Patrón Seguro: LIMIT (PostgreSQL)

```sql
-- Eliminar en lotes
DELETE FROM logs
WHERE id IN (
    SELECT id FROM logs
    WHERE fecha < '2024-01-01'
    LIMIT 1000
);
```

---

## 📊 Comparación: UPDATE vs DELETE

| Aspecto    | UPDATE                      | DELETE                      |
| ---------- | --------------------------- | --------------------------- |
| Propósito  | Modificar valores           | Eliminar filas              |
| Sintaxis   | SET columna = valor         | Sin SET                     |
| Datos      | Preserva la fila            | Elimina la fila             |
| Reversible | Sí (con valores anteriores) | Sí (con RETURNING + INSERT) |
| TRUNCATE   | N/A                         | Alternativa más rápida      |

---

## 🔄 Soft Delete vs Hard Delete

### Hard Delete (Eliminación física)

```sql
-- La fila desaparece completamente
DELETE FROM usuarios WHERE id = 5;
```

### Soft Delete (Eliminación lógica)

```sql
-- La fila permanece pero se marca como eliminada
UPDATE usuarios
SET
    eliminado = TRUE,
    eliminado_at = NOW()
WHERE id = 5;

-- Las consultas deben filtrar
SELECT * FROM usuarios WHERE eliminado = FALSE;
```

**Ventajas del Soft Delete:**

- Datos recuperables
- Auditoría completa
- Integridad referencial preservada

**Desventajas:**

- Más espacio en disco
- Consultas más complejas
- Necesita mantenimiento

---

## ✅ Buenas Prácticas

### 1. Siempre usa WHERE

```sql
-- ✅ Correcto
UPDATE t SET col = 'x' WHERE id = 5;
DELETE FROM t WHERE id = 5;
```

### 2. Verifica antes de ejecutar

```sql
-- ✅ Primero SELECT
SELECT * FROM t WHERE condicion;
-- Luego UPDATE/DELETE
```

### 3. Usa transacciones

```sql
-- ✅ Poder revertir
BEGIN;
DELETE FROM t WHERE ...;
-- COMMIT o ROLLBACK
```

### 4. Usa RETURNING

```sql
-- ✅ Ver qué se afectó
DELETE FROM t WHERE ... RETURNING *;
```

### 5. Considera Soft Delete

```sql
-- ✅ Para datos importantes
UPDATE t SET deleted = TRUE WHERE id = 5;
```

---

## ✅ Resumen

| Comando  | Sintaxis                           | Clave                 |
| -------- | ---------------------------------- | --------------------- |
| UPDATE   | `UPDATE t SET col = val WHERE ...` | Siempre WHERE         |
| DELETE   | `DELETE FROM t WHERE ...`          | Siempre WHERE         |
| TRUNCATE | `TRUNCATE TABLE t`                 | Más rápido que DELETE |

---

## 📖 Navegación

|      ⬅️ Anterior       |             Siguiente ➡️             |
| :--------------------: | :----------------------------------: |
| [INSERT](02-insert.md) | [SELECT Básico](04-select-basico.md) |
