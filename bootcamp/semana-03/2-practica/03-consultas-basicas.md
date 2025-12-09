# 💻 Práctica 03: Consultas Básicas con SELECT

## 🎯 Objetivo

Dominar consultas SELECT básicas para recuperar y filtrar datos.

---

## 📋 Preparación

```bash
docker exec -it postgres-bootcamp psql -U bootcamp -d tienda_online
```

Verificar que hay datos:

```sql
SELECT COUNT(*) AS productos FROM productos;
SELECT COUNT(*) AS clientes FROM clientes;
```

---

## 1️⃣ SELECT Básico

### 1.1 Todas las columnas

```sql
-- Todas las columnas y filas
SELECT * FROM categorias;
```

---

### 1.2 Columnas específicas

```sql
-- Solo algunas columnas
SELECT id, nombre, precio FROM productos;

-- Con alias
SELECT
    id AS codigo,
    nombre AS producto,
    precio AS "Precio Unitario"
FROM productos;
```

**¿Qué?** Selecciona columnas específicas con nombres personalizados.

**¿Para qué?** Claridad y reducción de datos transferidos.

---

### 1.3 Expresiones calculadas

```sql
-- Cálculos en SELECT
SELECT
    nombre,
    precio,
    precio * 1.16 AS precio_con_iva,
    stock,
    precio * stock AS valor_inventario
FROM productos;
```

---

### 1.4 Funciones en SELECT

```sql
-- Funciones de texto
SELECT
    UPPER(nombre) AS nombre_mayusculas,
    LOWER(nombre) AS nombre_minusculas,
    LENGTH(nombre) AS longitud,
    LEFT(nombre, 10) AS primeros_10
FROM productos;

-- Funciones numéricas
SELECT
    nombre,
    precio,
    ROUND(precio) AS precio_redondeado,
    CEIL(precio) AS precio_techo,
    FLOOR(precio) AS precio_piso
FROM productos;

-- Funciones de fecha
SELECT
    nombre,
    created_at,
    DATE(created_at) AS solo_fecha,
    EXTRACT(YEAR FROM created_at) AS anio,
    AGE(created_at) AS antiguedad
FROM productos;
```

---

## 2️⃣ WHERE - Filtros

### 2.1 Comparaciones simples

```sql
-- Igualdad
SELECT * FROM productos WHERE categoria_id = 1;

-- Mayor que
SELECT nombre, precio FROM productos WHERE precio > 100;

-- Menor o igual
SELECT nombre, stock FROM productos WHERE stock <= 50;

-- Diferente
SELECT * FROM productos WHERE categoria_id <> 1;
```

---

### 2.2 Operadores lógicos

```sql
-- AND: Ambas condiciones
SELECT nombre, precio, stock
FROM productos
WHERE precio > 100 AND stock > 20;

-- OR: Al menos una condición
SELECT nombre, categoria_id
FROM productos
WHERE categoria_id = 1 OR categoria_id = 2;

-- NOT: Negación
SELECT nombre, activo
FROM productos
WHERE NOT activo;

-- Combinación con paréntesis
SELECT nombre, precio, categoria_id
FROM productos
WHERE (categoria_id = 1 OR categoria_id = 3)
  AND precio < 500
  AND activo = TRUE;
```

---

### 2.3 BETWEEN

```sql
-- Rango de precios
SELECT nombre, precio
FROM productos
WHERE precio BETWEEN 50 AND 200;

-- Rango de fechas
SELECT nombre, created_at
FROM productos
WHERE created_at BETWEEN '2025-01-01' AND '2025-12-31';
```

---

### 2.4 IN

```sql
-- Lista de valores
SELECT nombre, categoria_id
FROM productos
WHERE categoria_id IN (1, 2);

-- NOT IN
SELECT nombre, categoria_id
FROM productos
WHERE categoria_id NOT IN (1, 2);

-- IN con subconsulta
SELECT nombre
FROM productos
WHERE categoria_id IN (
    SELECT id FROM categorias WHERE activa = TRUE
);
```

---

### 2.5 LIKE e ILIKE

```sql
-- Empieza con 'S'
SELECT nombre FROM productos WHERE nombre LIKE 'S%';

-- Termina con 'Pro'
SELECT nombre FROM productos WHERE nombre LIKE '%Pro';

-- Contiene 'Samsung'
SELECT nombre FROM productos WHERE nombre LIKE '%Samsung%';

-- ILIKE: Insensible a mayúsculas (PostgreSQL)
SELECT nombre FROM productos WHERE nombre ILIKE '%laptop%';

-- Un carácter cualquiera
SELECT nombre FROM productos WHERE nombre LIKE '_a%';

-- Combinar patrones
SELECT nombre FROM productos
WHERE nombre ILIKE '%smart%'
   OR nombre ILIKE '%tablet%';
```

---

### 2.6 IS NULL / IS NOT NULL

```sql
-- Buscar NULLs
SELECT nombre, descripcion
FROM productos
WHERE descripcion IS NULL;

-- Buscar no NULLs
SELECT nombre, descripcion
FROM productos
WHERE descripcion IS NOT NULL;

-- Clientes sin teléfono
SELECT nombre, email
FROM clientes
WHERE telefono IS NULL;
```

---

## 3️⃣ ORDER BY - Ordenamiento

### 3.1 Orden ascendente

```sql
-- Por precio (menor a mayor)
SELECT nombre, precio FROM productos ORDER BY precio;
SELECT nombre, precio FROM productos ORDER BY precio ASC;

-- Por nombre alfabético
SELECT nombre FROM productos ORDER BY nombre;
```

---

### 3.2 Orden descendente

```sql
-- Por precio (mayor a menor)
SELECT nombre, precio FROM productos ORDER BY precio DESC;

-- Los más nuevos primero
SELECT nombre, created_at FROM productos ORDER BY created_at DESC;
```

---

### 3.3 Múltiples columnas

```sql
-- Por categoría, luego por precio descendente
SELECT categoria_id, nombre, precio
FROM productos
ORDER BY categoria_id ASC, precio DESC;
```

---

### 3.4 Ordenar por expresión

```sql
-- Por valor de inventario
SELECT nombre, precio, stock, precio * stock AS valor
FROM productos
ORDER BY precio * stock DESC;

-- Por longitud del nombre
SELECT nombre, LENGTH(nombre) AS longitud
FROM productos
ORDER BY LENGTH(nombre);
```

---

### 3.5 NULLs en ordenamiento

```sql
-- NULLs al final
SELECT nombre, descripcion
FROM productos
ORDER BY descripcion NULLS LAST;

-- NULLs al principio
SELECT nombre, descripcion
FROM productos
ORDER BY descripcion NULLS FIRST;
```

---

## 4️⃣ LIMIT y OFFSET - Paginación

### 4.1 Primeras N filas

```sql
-- Top 5 más caros
SELECT nombre, precio
FROM productos
ORDER BY precio DESC
LIMIT 5;

-- Primeros 3 productos
SELECT * FROM productos LIMIT 3;
```

---

### 4.2 Paginación

```sql
-- Página 1 (primeros 5)
SELECT id, nombre, precio
FROM productos
ORDER BY id
LIMIT 5 OFFSET 0;

-- Página 2 (siguientes 5)
SELECT id, nombre, precio
FROM productos
ORDER BY id
LIMIT 5 OFFSET 5;

-- Página 3
SELECT id, nombre, precio
FROM productos
ORDER BY id
LIMIT 5 OFFSET 10;
```

**Fórmula**: `OFFSET = (número_página - 1) * items_por_página`

---

### 4.3 Combinación completa

```sql
-- Los 3 productos más caros de electrónicos
SELECT nombre, precio, stock
FROM productos
WHERE categoria_id = 1 AND activo = TRUE
ORDER BY precio DESC
LIMIT 3;
```

---

## 5️⃣ DISTINCT - Valores Únicos

### 5.1 Valores únicos de una columna

```sql
-- Categorías únicas que tienen productos
SELECT DISTINCT categoria_id FROM productos;

-- Estados únicos de pedidos
SELECT DISTINCT estado FROM pedidos;
```

---

### 5.2 Combinaciones únicas

```sql
-- Combinaciones únicas de categoría y estado activo
SELECT DISTINCT categoria_id, activo
FROM productos
ORDER BY categoria_id;
```

---

### 5.3 Contar valores únicos

```sql
-- Cuántas categorías diferentes tienen productos
SELECT COUNT(DISTINCT categoria_id) AS categorias_con_productos
FROM productos;
```

---

## 6️⃣ Consultas Prácticas

### 6.1 Reporte de inventario bajo

```sql
SELECT
    id,
    sku,
    nombre,
    stock,
    CASE
        WHEN stock = 0 THEN '🔴 Sin stock'
        WHEN stock < 20 THEN '🟡 Stock bajo'
        ELSE '🟢 Stock OK'
    END AS estado_stock
FROM productos
WHERE stock < 30
ORDER BY stock ASC;
```

---

### 6.2 Búsqueda de productos

```sql
-- Buscar productos que contengan ciertas palabras
SELECT id, nombre, precio
FROM productos
WHERE (nombre ILIKE '%laptop%' OR nombre ILIKE '%computadora%')
  AND precio < 2000
  AND activo = TRUE
ORDER BY precio ASC
LIMIT 10;
```

---

### 6.3 Productos por rango de precio

```sql
SELECT
    nombre,
    precio,
    CASE
        WHEN precio < 50 THEN 'Económico'
        WHEN precio < 200 THEN 'Medio'
        WHEN precio < 500 THEN 'Premium'
        ELSE 'Lujo'
    END AS segmento
FROM productos
WHERE activo = TRUE
ORDER BY precio;
```

---

### 6.4 Clientes recientes

```sql
SELECT
    nombre,
    email,
    DATE(created_at) AS fecha_registro,
    AGE(created_at) AS hace_tiempo
FROM clientes
ORDER BY created_at DESC
LIMIT 5;
```

---

### 6.5 Resumen rápido

```sql
-- Vista general del catálogo
SELECT
    COUNT(*) AS total_productos,
    COUNT(*) FILTER (WHERE activo = TRUE) AS activos,
    COUNT(*) FILTER (WHERE stock = 0) AS sin_stock,
    MIN(precio) AS precio_minimo,
    MAX(precio) AS precio_maximo,
    ROUND(AVG(precio)::numeric, 2) AS precio_promedio,
    SUM(precio * stock) AS valor_total_inventario
FROM productos;
```

---

## ✅ Ejercicio Final

Escribe consultas para:

1. Los 5 productos más baratos con stock disponible
2. Productos cuyo nombre empiece con vocal
3. Clientes sin dirección registrada
4. Productos con precio entre 100 y 500, ordenados por stock descendente
5. Las 3 categorías que existen (sin repetir)

---

## 📖 Navegación

|                    ⬅️ Anterior                     |      🏠 Semana 03      |                Siguiente ➡️                 |
| :------------------------------------------------: | :--------------------: | :-----------------------------------------: |
| [Actualizar y Eliminar](02-actualizar-eliminar.md) | [README](../README.md) | [Ejercicios](../3-ejercicios/ejercicios.md) |
