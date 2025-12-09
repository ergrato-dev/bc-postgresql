# 🔍 SELECT Básico

## 🎯 Objetivo

Dominar las consultas básicas con SELECT para recuperar datos.

---

## 📖 Sintaxis Básica

```sql
SELECT columnas
FROM tabla
WHERE condicion
ORDER BY columna
LIMIT n;
```

---

## 1️⃣ SELECT Todas las Columnas

```sql
-- Todas las columnas de la tabla
SELECT * FROM productos;
```

**¿Qué?** Recupera todas las columnas de todas las filas.

**¿Para qué?** Exploración rápida de datos.

**Impacto:** ⚠️ Puede ser lento en tablas grandes.

---

## 2️⃣ SELECT Columnas Específicas

```sql
-- Solo columnas necesarias
SELECT id, nombre, precio FROM productos;

-- Con alias de columna
SELECT
    id,
    nombre AS producto,
    precio AS precio_unitario
FROM productos;
```

**¿Qué?** Recupera solo las columnas especificadas.

**¿Para qué?** Mejor rendimiento y claridad.

**Impacto:** Menos datos transferidos.

---

## 3️⃣ SELECT con Expresiones

```sql
-- Cálculos
SELECT
    nombre,
    precio,
    precio * 1.16 AS precio_con_iva,
    stock,
    precio * stock AS valor_inventario
FROM productos;

-- Concatenación
SELECT
    nombre || ' - $' || precio AS descripcion
FROM productos;

-- Funciones
SELECT
    UPPER(nombre) AS nombre_mayusculas,
    ROUND(precio, 0) AS precio_redondeado,
    LENGTH(nombre) AS longitud_nombre
FROM productos;
```

---

## 4️⃣ SELECT DISTINCT

Elimina filas duplicadas:

```sql
-- Valores únicos de una columna
SELECT DISTINCT categoria_id FROM productos;

-- Combinación única de columnas
SELECT DISTINCT categoria_id, activo FROM productos;

-- Contar valores únicos
SELECT COUNT(DISTINCT categoria_id) AS total_categorias
FROM productos;
```

---

## 5️⃣ WHERE - Filtrar Resultados

### Operadores de Comparación

| Operador    | Descripción   | Ejemplo               |
| ----------- | ------------- | --------------------- |
| `=`         | Igual         | `WHERE id = 5`        |
| `<>` o `!=` | Diferente     | `WHERE id <> 5`       |
| `<`         | Menor que     | `WHERE precio < 100`  |
| `>`         | Mayor que     | `WHERE precio > 100`  |
| `<=`        | Menor o igual | `WHERE precio <= 100` |
| `>=`        | Mayor o igual | `WHERE precio >= 100` |

```sql
SELECT * FROM productos WHERE precio > 100;
SELECT * FROM productos WHERE stock <= 10;
SELECT * FROM productos WHERE categoria_id = 3;
```

---

### Operadores Lógicos

```sql
-- AND: Ambas condiciones deben cumplirse
SELECT * FROM productos
WHERE precio > 100 AND stock > 0;

-- OR: Al menos una condición debe cumplirse
SELECT * FROM productos
WHERE categoria_id = 1 OR categoria_id = 2;

-- NOT: Niega la condición
SELECT * FROM productos
WHERE NOT activo;

-- Combinados (usar paréntesis para claridad)
SELECT * FROM productos
WHERE (categoria_id = 1 OR categoria_id = 2)
AND precio < 500
AND activo = TRUE;
```

---

### BETWEEN

```sql
-- Rango inclusivo
SELECT * FROM productos
WHERE precio BETWEEN 50 AND 100;
-- Equivale a: WHERE precio >= 50 AND precio <= 100

-- Fechas
SELECT * FROM pedidos
WHERE fecha BETWEEN '2025-01-01' AND '2025-12-31';
```

---

### IN

```sql
-- Lista de valores
SELECT * FROM productos
WHERE categoria_id IN (1, 3, 5, 7);

-- Equivale a OR múltiple
SELECT * FROM productos
WHERE categoria_id = 1
   OR categoria_id = 3
   OR categoria_id = 5
   OR categoria_id = 7;

-- NOT IN
SELECT * FROM productos
WHERE categoria_id NOT IN (1, 2);
```

---

### LIKE (Patrones de texto)

| Patrón | Descripción                       |
| ------ | --------------------------------- |
| `%`    | Cualquier secuencia de caracteres |
| `_`    | Un solo carácter                  |

```sql
-- Empieza con 'Laptop'
SELECT * FROM productos WHERE nombre LIKE 'Laptop%';

-- Termina con 'Pro'
SELECT * FROM productos WHERE nombre LIKE '%Pro';

-- Contiene 'Gaming'
SELECT * FROM productos WHERE nombre LIKE '%Gaming%';

-- Segunda letra es 'a'
SELECT * FROM productos WHERE nombre LIKE '_a%';

-- ILIKE: Insensible a mayúsculas (PostgreSQL)
SELECT * FROM productos WHERE nombre ILIKE '%laptop%';
```

---

### IS NULL / IS NOT NULL

```sql
-- Valores NULL
SELECT * FROM productos WHERE descripcion IS NULL;

-- Valores no NULL
SELECT * FROM productos WHERE descripcion IS NOT NULL;

-- ⚠️ Esto NO funciona:
-- SELECT * FROM productos WHERE descripcion = NULL;
```

---

## 6️⃣ ORDER BY - Ordenar Resultados

```sql
-- Orden ascendente (por defecto)
SELECT * FROM productos ORDER BY precio;
SELECT * FROM productos ORDER BY precio ASC;

-- Orden descendente
SELECT * FROM productos ORDER BY precio DESC;

-- Múltiples columnas
SELECT * FROM productos
ORDER BY categoria_id ASC, precio DESC;

-- Por posición de columna
SELECT nombre, precio FROM productos ORDER BY 2 DESC;

-- NULLs primero/último
SELECT * FROM productos ORDER BY precio NULLS FIRST;
SELECT * FROM productos ORDER BY precio NULLS LAST;
```

---

## 7️⃣ LIMIT y OFFSET - Paginar Resultados

```sql
-- Primeras 10 filas
SELECT * FROM productos LIMIT 10;

-- Filas 11-20 (saltar las primeras 10)
SELECT * FROM productos LIMIT 10 OFFSET 10;

-- Top 5 más caros
SELECT * FROM productos ORDER BY precio DESC LIMIT 5;

-- Paginación típica (página 3, 20 items por página)
SELECT * FROM productos
ORDER BY id
LIMIT 20 OFFSET 40;  -- (página - 1) * items_por_página
```

---

## 8️⃣ Alias

### Alias de Columna

```sql
SELECT
    nombre AS producto,
    precio AS "Precio Unitario",  -- Con espacios: usar comillas
    precio * 1.16 AS precio_iva
FROM productos;
```

### Alias de Tabla

```sql
SELECT p.nombre, p.precio
FROM productos p
WHERE p.activo = TRUE;

-- Útil en subconsultas y JOINs (semana 05)
SELECT p.nombre, c.nombre AS categoria
FROM productos p, categorias c
WHERE p.categoria_id = c.id;
```

---

## 📊 Ejemplos Combinados

### Consulta completa típica

```sql
SELECT
    id,
    nombre,
    precio,
    stock,
    precio * stock AS valor_inventario
FROM productos
WHERE activo = TRUE
  AND stock > 0
  AND precio BETWEEN 50 AND 500
ORDER BY valor_inventario DESC
LIMIT 20;
```

### Búsqueda con múltiples criterios

```sql
SELECT id, nombre, precio, categoria_id
FROM productos
WHERE
    (nombre ILIKE '%laptop%' OR nombre ILIKE '%notebook%')
    AND precio < 1000
    AND stock > 0
    AND activo = TRUE
ORDER BY precio ASC
LIMIT 10;
```

### Reporte básico

```sql
SELECT
    categoria_id,
    COUNT(*) AS total_productos,
    MIN(precio) AS precio_minimo,
    MAX(precio) AS precio_maximo,
    ROUND(AVG(precio), 2) AS precio_promedio
FROM productos
WHERE activo = TRUE
GROUP BY categoria_id
ORDER BY total_productos DESC;
```

> 💡 GROUP BY se verá en detalle en la Semana 06.

---

## ✅ Buenas Prácticas

### 1. Evita SELECT \*

```sql
-- ❌ Evitar
SELECT * FROM productos;

-- ✅ Especificar columnas
SELECT id, nombre, precio FROM productos;
```

### 2. Usa alias descriptivos

```sql
-- ✅ Claro
SELECT
    p.nombre AS producto,
    p.precio * 1.16 AS precio_con_iva
FROM productos p;
```

### 3. Siempre limita resultados en desarrollo

```sql
-- ✅ Evita traer millones de filas
SELECT * FROM logs ORDER BY fecha DESC LIMIT 100;
```

### 4. Usa paréntesis en condiciones complejas

```sql
-- ✅ Claro
WHERE (a = 1 OR b = 2) AND c = 3

-- ❌ Ambiguo
WHERE a = 1 OR b = 2 AND c = 3
```

---

## ✅ Resumen

| Cláusula | Propósito        | Orden |
| -------- | ---------------- | :---: |
| SELECT   | Qué columnas     |   1   |
| FROM     | De qué tabla     |   2   |
| WHERE    | Filtrar filas    |   3   |
| ORDER BY | Ordenar          |   4   |
| LIMIT    | Limitar cantidad |   5   |
| OFFSET   | Saltar filas     |   6   |

---

## 📖 Navegación

|              ⬅️ Anterior               |      🏠 Semana 03      |                  Siguiente ➡️                  |
| :------------------------------------: | :--------------------: | :--------------------------------------------: |
| [UPDATE y DELETE](03-update-delete.md) | [README](../README.md) | [Práctica](../2-practica/01-insertar-datos.md) |
