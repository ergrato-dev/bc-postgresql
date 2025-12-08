# ✅ Soluciones - Semana 01

> ⚠️ **Advertencia**: Intenta resolver los ejercicios por tu cuenta antes de ver las soluciones.

---

## Nivel 1: Básico

### Ejercicio 1.1 - Exploración de tablas

```sql
-- Listar tablas
\dt

-- Describir estructura de productos
\d productos
```

---

### Ejercicio 1.2 - SELECT simple

```sql
SELECT * FROM categorias;
```

---

### Ejercicio 1.3 - SELECT con columnas específicas

```sql
SELECT nombre, email FROM clientes;
```

---

### Ejercicio 1.4 - Alias de columnas

```sql
SELECT
    nombre AS producto,
    precio AS costo
FROM productos;
```

---

## Nivel 2: Filtros con WHERE

### Ejercicio 2.1 - Filtro numérico

```sql
SELECT nombre, precio
FROM productos
WHERE precio > 50;
```

---

### Ejercicio 2.2 - Filtro de texto

```sql
SELECT nombre, apellido, email
FROM clientes
WHERE ciudad = 'Barcelona';
```

---

### Ejercicio 2.3 - Múltiples condiciones (AND)

```sql
SELECT nombre, precio, stock
FROM productos
WHERE precio > 30 AND stock > 40;
```

---

### Ejercicio 2.4 - Múltiples condiciones (OR)

```sql
SELECT nombre, apellido, ciudad
FROM clientes
WHERE ciudad = 'Madrid' OR ciudad = 'Valencia';
```

---

## Nivel 3: Búsqueda y Patrones

### Ejercicio 3.1 - LIKE básico

```sql
SELECT nombre, precio
FROM productos
WHERE nombre LIKE 'L%';
```

---

### Ejercicio 3.2 - LIKE con comodín

```sql
SELECT nombre, precio
FROM productos
WHERE nombre ILIKE '%bluetooth%';
```

---

### Ejercicio 3.3 - IN

```sql
SELECT nombre, precio, categoria_id
FROM productos
WHERE categoria_id IN (1, 4, 5);
```

---

### Ejercicio 3.4 - BETWEEN

```sql
SELECT nombre, precio
FROM productos
WHERE precio BETWEEN 20 AND 100
ORDER BY precio ASC;
```

---

## Nivel 4: Ordenación y Límites

### Ejercicio 4.1 - ORDER BY simple

```sql
SELECT nombre, precio
FROM productos
ORDER BY precio DESC;
```

---

### Ejercicio 4.2 - ORDER BY múltiple

```sql
SELECT categoria_id, nombre, precio
FROM productos
ORDER BY categoria_id ASC, precio DESC;
```

---

### Ejercicio 4.3 - LIMIT

```sql
SELECT nombre, precio
FROM productos
ORDER BY precio DESC
LIMIT 3;
```

---

### Ejercicio 4.4 - OFFSET (paginación)

```sql
SELECT nombre, precio
FROM productos
ORDER BY id
LIMIT 5 OFFSET 5;
```

---

## Nivel 5: Combinación de Conceptos

### Ejercicio 5.1 - Consulta compleja

```sql
SELECT nombre, precio, stock
FROM productos
WHERE categoria_id = 1
  AND stock > 0
ORDER BY precio ASC
LIMIT 3;
```

---

### Ejercicio 5.2 - Cálculos

```sql
SELECT
    nombre,
    precio AS precio_original,
    ROUND(precio * 1.21, 2) AS precio_con_iva,
    ROUND(precio * 0.90, 2) AS precio_con_descuento
FROM productos
WHERE precio > 50;
```

---

### Ejercicio 5.3 - DISTINCT

```sql
SELECT DISTINCT ciudad
FROM clientes
ORDER BY ciudad;
```

---

### Ejercicio 5.4 - Búsqueda avanzada

```sql
SELECT nombre, apellido, telefono, ciudad
FROM clientes
WHERE (nombre ILIKE '%a%' OR apellido ILIKE '%a%')
  AND telefono IS NOT NULL
ORDER BY apellido;
```

---

## 🏆 Desafío Extra

### Desafío: Reporte de inventario

```sql
SELECT
    nombre,
    precio,
    stock,
    ROUND(precio * stock, 2) AS valor_inventario,
    CASE
        WHEN stock < 30 THEN 'BAJO'
        ELSE 'NORMAL'
    END AS estado_stock
FROM productos
WHERE activo = TRUE
ORDER BY valor_inventario DESC
LIMIT 5;
```

**Explicación del CASE WHEN:**

```sql
CASE
    WHEN condicion1 THEN resultado1
    WHEN condicion2 THEN resultado2
    ELSE resultado_default
END
```

---

## 📊 Resumen de Funciones Usadas

| Función       | Descripción                  | Ejemplo                    |
| ------------- | ---------------------------- | -------------------------- |
| `ROUND(n, d)` | Redondea n a d decimales     | `ROUND(10.567, 2)` → 10.57 |
| `CASE WHEN`   | Condicional en SQL           | Ver ejemplo arriba         |
| `ILIKE`       | LIKE insensible a mayúsculas | `nombre ILIKE '%test%'`    |

---

## 📖 Navegación

|         ⬅️ Anterior         |                  Siguiente ➡️                   |
| :-------------------------: | :---------------------------------------------: |
| [Ejercicios](ejercicios.md) | [Proyecto](../4-proyecto/proyecto-semana-01.md) |
