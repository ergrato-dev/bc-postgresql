# ⌨️ Comandos Básicos de SQL

## 🎯 Objetivo

Aprender los comandos SQL fundamentales para consultar y explorar datos en PostgreSQL.

---

## 📖 Introducción a SQL

**SQL** (Structured Query Language) es el lenguaje estándar para interactuar con bases de datos relacionales.

### Categorías de Comandos SQL

| Categoría | Comandos               | Descripción         |
| --------- | ---------------------- | ------------------- |
| **DQL**   | SELECT                 | Consultar datos     |
| **DML**   | INSERT, UPDATE, DELETE | Modificar datos     |
| **DDL**   | CREATE, ALTER, DROP    | Definir estructuras |
| **DCL**   | GRANT, REVOKE          | Control de acceso   |
| **TCL**   | COMMIT, ROLLBACK       | Transacciones       |

> 📌 Esta semana nos enfocamos en **SELECT** (consultas básicas).

---

## 🔍 SELECT: La Base de Todo

### Sintaxis Básica

```sql
SELECT columnas
FROM tabla;
```

### Seleccionar Todas las Columnas

```sql
-- El asterisco (*) significa "todas las columnas"
SELECT * FROM categorias;
```

**Resultado:**

```
 id |    nombre    |              descripcion
----+--------------+----------------------------------------
  1 | Electrónica  | Dispositivos electrónicos y gadgets
  2 | Ropa         | Vestimenta y accesorios
  3 | Hogar        | Artículos para el hogar
  4 | Deportes     | Equipamiento deportivo
  5 | Libros       | Libros y material de lectura
```

### Seleccionar Columnas Específicas

```sql
SELECT nombre, precio FROM productos;
```

> 💡 **Buena práctica**: Evita `SELECT *` en producción. Especifica las columnas que necesitas.

---

## 🏷️ Alias con AS

Puedes renombrar columnas en el resultado:

```sql
SELECT
    nombre AS producto,
    precio AS precio_unitario
FROM productos;
```

**Resultado:**

```
      producto       | precio_unitario
---------------------+-----------------
 Laptop ProMax 15"   |         1299.99
 Auriculares Bluetooth |           89.99
```

---

## 🔢 Operaciones en SELECT

### Operaciones Matemáticas

```sql
SELECT
    nombre,
    precio,
    precio * 1.21 AS precio_con_iva
FROM productos;
```

### Concatenación de Texto

```sql
SELECT
    nombre || ' ' || apellido AS nombre_completo
FROM clientes;
```

**Resultado:**

```
 nombre_completo
-----------------
 María García
 Carlos López
 Ana Martínez
```

---

## 🎯 WHERE: Filtrar Resultados

### Sintaxis

```sql
SELECT columnas
FROM tabla
WHERE condicion;
```

### Operadores de Comparación

| Operador    | Significado   |
| ----------- | ------------- |
| `=`         | Igual a       |
| `<>` o `!=` | Diferente de  |
| `>`         | Mayor que     |
| `<`         | Menor que     |
| `>=`        | Mayor o igual |
| `<=`        | Menor o igual |

### Ejemplos

```sql
-- Productos con precio mayor a 100
SELECT nombre, precio
FROM productos
WHERE precio > 100;

-- Clientes de Madrid
SELECT nombre, apellido
FROM clientes
WHERE ciudad = 'Madrid';

-- Productos con stock bajo (menos de 50)
SELECT nombre, stock
FROM productos
WHERE stock < 50;
```

---

## 🔗 Operadores Lógicos

### AND (ambas condiciones deben cumplirse)

```sql
SELECT nombre, precio, stock
FROM productos
WHERE precio > 50 AND stock > 20;
```

### OR (al menos una condición debe cumplirse)

```sql
SELECT nombre, ciudad
FROM clientes
WHERE ciudad = 'Madrid' OR ciudad = 'Barcelona';
```

### NOT (negación)

```sql
SELECT nombre, precio
FROM productos
WHERE NOT precio > 100;
-- Equivalente a: WHERE precio <= 100
```

### Combinando operadores

```sql
SELECT nombre, precio, categoria_id
FROM productos
WHERE (precio > 50 AND precio < 200)
   OR categoria_id = 1;
```

---

## 📝 LIKE: Búsqueda de Patrones

### Comodines

| Comodín | Significado                      |
| ------- | -------------------------------- |
| `%`     | Cualquier cantidad de caracteres |
| `_`     | Un solo carácter                 |

### Ejemplos

```sql
-- Nombres que empiezan con 'A'
SELECT nombre FROM clientes WHERE nombre LIKE 'A%';

-- Nombres que terminan en 'a'
SELECT nombre FROM clientes WHERE nombre LIKE '%a';

-- Nombres que contienen 'ar'
SELECT nombre FROM clientes WHERE nombre LIKE '%ar%';

-- Nombres de exactamente 5 caracteres
SELECT nombre FROM clientes WHERE nombre LIKE '_____';
```

### ILIKE (insensible a mayúsculas/minúsculas)

```sql
-- PostgreSQL específico
SELECT nombre FROM productos WHERE nombre ILIKE '%laptop%';
```

---

## 📋 IN: Lista de Valores

```sql
-- En lugar de múltiples OR:
SELECT nombre, ciudad
FROM clientes
WHERE ciudad IN ('Madrid', 'Barcelona', 'Valencia');
```

### NOT IN

```sql
SELECT nombre, ciudad
FROM clientes
WHERE ciudad NOT IN ('Madrid', 'Barcelona');
```

---

## 📏 BETWEEN: Rangos

```sql
-- Productos con precio entre 20 y 100
SELECT nombre, precio
FROM productos
WHERE precio BETWEEN 20 AND 100;

-- Equivalente a:
-- WHERE precio >= 20 AND precio <= 100
```

---

## ❓ NULL: Valores Nulos

`NULL` representa la ausencia de valor. No se compara con `=`:

```sql
-- ❌ Incorrecto
SELECT * FROM clientes WHERE telefono = NULL;

-- ✅ Correcto
SELECT * FROM clientes WHERE telefono IS NULL;

-- Clientes CON teléfono
SELECT * FROM clientes WHERE telefono IS NOT NULL;
```

---

## 📊 ORDER BY: Ordenar Resultados

### Orden Ascendente (por defecto)

```sql
SELECT nombre, precio
FROM productos
ORDER BY precio;
-- o explícitamente:
ORDER BY precio ASC;
```

### Orden Descendente

```sql
SELECT nombre, precio
FROM productos
ORDER BY precio DESC;
```

### Ordenar por múltiples columnas

```sql
SELECT nombre, categoria_id, precio
FROM productos
ORDER BY categoria_id ASC, precio DESC;
```

---

## 🔢 LIMIT: Limitar Resultados

```sql
-- Solo los primeros 5 productos
SELECT nombre, precio
FROM productos
LIMIT 5;
```

### OFFSET: Saltar registros

```sql
-- Productos del 6 al 10 (paginación)
SELECT nombre, precio
FROM productos
LIMIT 5 OFFSET 5;
```

---

## 🏆 DISTINCT: Valores Únicos

```sql
-- Ciudades únicas de clientes
SELECT DISTINCT ciudad
FROM clientes;

-- Categorías que tienen productos
SELECT DISTINCT categoria_id
FROM productos;
```

---

## 📝 Consulta Completa

Combinando todo lo aprendido:

```sql
SELECT
    nombre,
    precio,
    precio * 1.21 AS precio_con_iva
FROM productos
WHERE categoria_id = 1
  AND precio > 50
  AND activo = TRUE
ORDER BY precio DESC
LIMIT 10;
```

### Orden de las Cláusulas

```sql
SELECT ...      -- 1. Qué columnas
FROM ...        -- 2. De qué tabla
WHERE ...       -- 3. Filtrar filas
ORDER BY ...    -- 4. Ordenar
LIMIT ...       -- 5. Limitar cantidad
```

---

## ✅ Resumen de Comandos

| Comando    | Propósito            | Ejemplo                          |
| ---------- | -------------------- | -------------------------------- |
| `SELECT`   | Elegir columnas      | `SELECT nombre, precio`          |
| `FROM`     | Especificar tabla    | `FROM productos`                 |
| `WHERE`    | Filtrar filas        | `WHERE precio > 100`             |
| `AND/OR`   | Combinar condiciones | `WHERE a AND b`                  |
| `LIKE`     | Buscar patrones      | `WHERE nombre LIKE '%a'`         |
| `IN`       | Lista de valores     | `WHERE id IN (1,2,3)`            |
| `BETWEEN`  | Rango de valores     | `WHERE precio BETWEEN 10 AND 50` |
| `IS NULL`  | Verificar nulos      | `WHERE campo IS NULL`            |
| `ORDER BY` | Ordenar resultados   | `ORDER BY precio DESC`           |
| `LIMIT`    | Limitar cantidad     | `LIMIT 10`                       |
| `DISTINCT` | Valores únicos       | `SELECT DISTINCT ciudad`         |

---

## 📖 Navegación

|                ⬅️ Anterior                 |      🏠 Semana 01      |                Siguiente ➡️                 |
| :----------------------------------------: | :--------------------: | :-----------------------------------------: |
| [Primera Conexión](02-primera-conexion.md) | [README](../README.md) | [Ejercicios](../3-ejercicios/ejercicios.md) |
