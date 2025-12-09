# 📖 Glosario: Semana 03 - DML

## A

### Alias

Nombre temporal asignado a una columna o tabla para mejorar legibilidad.

```sql
SELECT nombre AS producto FROM productos;
```

### ASC / DESC

Orden ascendente (A-Z, 1-100) o descendente (Z-A, 100-1) en ORDER BY.

---

## B

### BEGIN

Inicia un bloque de transacción. Todas las operaciones posteriores se confirman con COMMIT o revierten con ROLLBACK.

---

## C

### COMMIT

Confirma permanentemente todos los cambios realizados en una transacción.

### CRUD

Acrónimo de Create, Read, Update, Delete - las cuatro operaciones básicas sobre datos.

---

## D

### DEFAULT

Valor por defecto que se asigna a una columna cuando no se especifica en INSERT.

### DELETE

Comando DML para eliminar filas de una tabla.

```sql
DELETE FROM tabla WHERE condicion;
```

### DISTINCT

Elimina filas duplicadas del resultado de una consulta.

```sql
SELECT DISTINCT categoria_id FROM productos;
```

### DML (Data Manipulation Language)

Subconjunto de SQL para manipular datos: INSERT, UPDATE, DELETE, SELECT.

---

## E

### EXCLUDED

Pseudo-tabla que referencia los valores que se intentaban insertar, usada en ON CONFLICT.

```sql
ON CONFLICT DO UPDATE SET col = EXCLUDED.col
```

---

## F

### FROM

Cláusula que especifica la tabla origen de los datos en SELECT, UPDATE o DELETE.

---

## G

### GROUP BY

Agrupa filas que tienen valores iguales en columnas especificadas.

---

## H

### HAVING

Filtra grupos después de GROUP BY (similar a WHERE pero para grupos).

---

## I

### ILIKE

Comparación de patrones insensible a mayúsculas/minúsculas (extensión PostgreSQL).

```sql
WHERE nombre ILIKE '%samsung%'
```

### IN

Operador que verifica si un valor está en una lista.

```sql
WHERE estado IN ('activo', 'pendiente')
```

### INSERT

Comando DML para agregar filas a una tabla.

```sql
INSERT INTO tabla (columnas) VALUES (valores);
```

### IS NULL / IS NOT NULL

Operadores para verificar valores NULL. No usar = NULL.

---

## L

### LIKE

Comparación de patrones con comodines % (cualquier cadena) y \_ (un carácter).

```sql
WHERE nombre LIKE 'Smart%'
```

### LIMIT

Restringe el número de filas retornadas por una consulta.

```sql
SELECT * FROM productos LIMIT 10;
```

---

## N

### NULL

Representa ausencia de valor. No es igual a vacío ni a cero.

---

## O

### OFFSET

Omite un número de filas antes de comenzar a retornar resultados.

```sql
LIMIT 10 OFFSET 20  -- Filas 21-30
```

### ON CONFLICT

Cláusula para manejar violaciones de unicidad en INSERT (UPSERT).

```sql
INSERT INTO t (id) VALUES (1)
ON CONFLICT (id) DO UPDATE SET col = val;
```

### ORDER BY

Ordena el resultado de una consulta por una o más columnas.

---

## P

### Paginación

Técnica para dividir resultados en "páginas" usando LIMIT y OFFSET.

---

## R

### RETURNING

Devuelve las filas afectadas por INSERT, UPDATE o DELETE.

```sql
INSERT INTO t (col) VALUES ('val') RETURNING id;
```

### ROLLBACK

Revierte todos los cambios de una transacción al estado anterior a BEGIN.

---

## S

### SELECT

Comando DML para consultar datos de una o más tablas.

```sql
SELECT columnas FROM tabla WHERE condicion;
```

### SET

Cláusula de UPDATE que especifica las columnas a modificar.

### Soft Delete

Patrón donde en lugar de eliminar físicamente, se marca como inactivo.

```sql
UPDATE productos SET activo = FALSE WHERE id = 1;
```

---

## T

### Transacción

Secuencia de operaciones que se ejecutan como unidad atómica.

### TRUNCATE

Elimina todas las filas de una tabla rápidamente (más eficiente que DELETE sin WHERE).

---

## U

### UPDATE

Comando DML para modificar datos existentes.

```sql
UPDATE tabla SET columna = valor WHERE condicion;
```

### UPSERT

Operación que inserta o actualiza dependiendo si existe el registro.

---

## V

### VALUES

Cláusula de INSERT que proporciona los valores a insertar.

---

## W

### WHERE

Cláusula que filtra filas según una condición.

```sql
SELECT * FROM productos WHERE precio > 100;
```

---

## Operadores Comunes

| Operador    | Descripción               | Ejemplo                          |
| ----------- | ------------------------- | -------------------------------- |
| `=`         | Igual a                   | `WHERE id = 1`                   |
| `<>` o `!=` | Diferente de              | `WHERE estado <> 'inactivo'`     |
| `<`, `>`    | Menor/Mayor que           | `WHERE precio > 100`             |
| `<=`, `>=`  | Menor/Mayor o igual       | `WHERE stock >= 10`              |
| `BETWEEN`   | En un rango               | `WHERE precio BETWEEN 10 AND 50` |
| `IN`        | En una lista              | `WHERE id IN (1, 2, 3)`          |
| `LIKE`      | Patrón (case-sensitive)   | `WHERE nombre LIKE 'A%'`         |
| `ILIKE`     | Patrón (case-insensitive) | `WHERE nombre ILIKE 'a%'`        |
| `IS NULL`   | Es nulo                   | `WHERE telefono IS NULL`         |
| `AND`       | Y lógico                  | `WHERE a = 1 AND b = 2`          |
| `OR`        | O lógico                  | `WHERE a = 1 OR a = 2`           |
| `NOT`       | Negación                  | `WHERE NOT activo`               |

---

## Funciones Útiles con SELECT

| Función      | Descripción          | Ejemplo                                |
| ------------ | -------------------- | -------------------------------------- |
| `COUNT()`    | Cuenta filas         | `SELECT COUNT(*) FROM t`               |
| `SUM()`      | Suma valores         | `SELECT SUM(total) FROM pedidos`       |
| `AVG()`      | Promedio             | `SELECT AVG(precio) FROM productos`    |
| `MIN()`      | Valor mínimo         | `SELECT MIN(precio) FROM productos`    |
| `MAX()`      | Valor máximo         | `SELECT MAX(stock) FROM productos`     |
| `COALESCE()` | Primer valor no nulo | `COALESCE(telefono, 'N/A')`            |
| `NULLIF()`   | NULL si son iguales  | `NULLIF(stock, 0)`                     |
| `UPPER()`    | Mayúsculas           | `UPPER(nombre)`                        |
| `LOWER()`    | Minúsculas           | `LOWER(email)`                         |
| `TRIM()`     | Elimina espacios     | `TRIM(nombre)`                         |
| `NOW()`      | Fecha/hora actual    | `INSERT INTO t (fecha) VALUES (NOW())` |

---

## 📖 Navegación

|              ⬅️ Recursos              |      🏠 Semana 03      |            Siguiente ➡️             |
| :-----------------------------------: | :--------------------: | :---------------------------------: |
| [Recursos](../5-recursos/recursos.md) | [README](../README.md) | [Rúbrica](../rubrica-evaluacion.md) |
