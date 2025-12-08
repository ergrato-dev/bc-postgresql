# 🔧 Ejercicios - Semana 01

## 🎯 Objetivo

Practicar los comandos SQL básicos aprendidos durante la semana.

---

## 📋 Instrucciones

1. Conéctate a PostgreSQL: `docker exec -it postgres-bootcamp psql -U bootcamp -d tienda_online`
2. Resuelve cada ejercicio escribiendo la consulta SQL
3. Verifica que el resultado sea correcto
4. Si te atascas, consulta las [soluciones](soluciones.md) (¡pero intenta primero!)

---

## 🏋️ Ejercicios

### Nivel 1: Básico

#### Ejercicio 1.1 - Exploración de tablas

**Objetivo**: Familiarizarse con las tablas existentes

```
Usando el comando \dt, lista todas las tablas de la base de datos.
Luego, describe la estructura de la tabla 'productos' usando \d productos.
```

---

#### Ejercicio 1.2 - SELECT simple

**Objetivo**: Seleccionar todas las columnas

```
Muestra todos los datos de la tabla 'categorias'.
```

**Resultado esperado**: 5 filas con id, nombre y descripcion.

---

#### Ejercicio 1.3 - SELECT con columnas específicas

**Objetivo**: Seleccionar columnas específicas

```
Muestra solo el nombre y email de todos los clientes.
```

---

#### Ejercicio 1.4 - Alias de columnas

**Objetivo**: Usar alias para renombrar columnas

```
Muestra el nombre del producto como 'producto' y el precio como 'costo'.
```

---

### Nivel 2: Filtros con WHERE

#### Ejercicio 2.1 - Filtro numérico

**Objetivo**: Filtrar por valor numérico

```
Muestra los productos con precio mayor a 50 euros.
Columnas: nombre, precio
```

---

#### Ejercicio 2.2 - Filtro de texto

**Objetivo**: Filtrar por valor de texto

```
Muestra los clientes que viven en 'Barcelona'.
Columnas: nombre, apellido, email
```

---

#### Ejercicio 2.3 - Múltiples condiciones (AND)

**Objetivo**: Combinar condiciones con AND

```
Muestra los productos que tienen:
- Precio mayor a 30 euros
- Stock mayor a 40 unidades

Columnas: nombre, precio, stock
```

---

#### Ejercicio 2.4 - Múltiples condiciones (OR)

**Objetivo**: Combinar condiciones con OR

```
Muestra los clientes de Madrid O Valencia.
Columnas: nombre, apellido, ciudad
```

---

### Nivel 3: Búsqueda y Patrones

#### Ejercicio 3.1 - LIKE básico

**Objetivo**: Buscar patrones en texto

```
Encuentra productos cuyo nombre empiece con 'L'.
Columnas: nombre, precio
```

---

#### Ejercicio 3.2 - LIKE con comodín

**Objetivo**: Buscar texto que contenga una palabra

```
Encuentra productos que contengan 'Bluetooth' o 'bluetooth' en el nombre.
(Pista: usa ILIKE para búsqueda insensible a mayúsculas)
Columnas: nombre, precio
```

---

#### Ejercicio 3.3 - IN

**Objetivo**: Buscar en una lista de valores

```
Muestra los productos de las categorías 1, 4 y 5.
Columnas: nombre, precio, categoria_id
```

---

#### Ejercicio 3.4 - BETWEEN

**Objetivo**: Buscar en un rango

```
Encuentra productos con precio entre 20 y 100 euros (inclusive).
Columnas: nombre, precio
Ordenar por precio ascendente.
```

---

### Nivel 4: Ordenación y Límites

#### Ejercicio 4.1 - ORDER BY simple

**Objetivo**: Ordenar resultados

```
Muestra todos los productos ordenados por precio de mayor a menor.
Columnas: nombre, precio
```

---

#### Ejercicio 4.2 - ORDER BY múltiple

**Objetivo**: Ordenar por varias columnas

```
Muestra los productos ordenados primero por categoria_id (ascendente)
y luego por precio (descendente).
Columnas: categoria_id, nombre, precio
```

---

#### Ejercicio 4.3 - LIMIT

**Objetivo**: Limitar resultados

```
Muestra los 3 productos más caros.
Columnas: nombre, precio
```

---

#### Ejercicio 4.4 - OFFSET (paginación)

**Objetivo**: Paginación de resultados

```
Simula la "página 2" de productos (saltando los primeros 5).
Muestra 5 productos.
Columnas: nombre, precio
Ordenar por id.
```

---

### Nivel 5: Combinación de Conceptos

#### Ejercicio 5.1 - Consulta compleja

**Objetivo**: Combinar múltiples cláusulas

```
Encuentra los 3 productos más baratos de la categoría 'Electrónica' (categoria_id = 1)
que tengan stock disponible (stock > 0).
Columnas: nombre, precio, stock
```

---

#### Ejercicio 5.2 - Cálculos

**Objetivo**: Realizar operaciones matemáticas

```
Muestra los productos con:
- Nombre
- Precio original
- Precio con IVA (21%)
- Precio con descuento del 10%

Solo productos con precio > 50 euros.
Usa alias descriptivos.
```

---

#### Ejercicio 5.3 - DISTINCT

**Objetivo**: Obtener valores únicos

```
Obtén la lista de ciudades únicas donde hay clientes.
Ordénalas alfabéticamente.
```

---

#### Ejercicio 5.4 - Búsqueda avanzada

**Objetivo**: Consulta completa

```
Busca clientes cuyo:
- Nombre O apellido contenga la letra 'a' (insensible a mayúsculas)
- Tengan teléfono registrado (no nulo)

Muestra: nombre, apellido, telefono, ciudad
Ordena por apellido.
```

---

## 🏆 Desafío Extra

#### Desafío: Reporte de inventario

**Objetivo**: Crear un mini-reporte

```
Crea una consulta que muestre:
- Nombre del producto
- Precio
- Stock
- Valor en inventario (precio * stock) como 'valor_inventario'
- Una columna 'estado_stock' que muestre:
  - 'BAJO' si stock < 30
  - 'NORMAL' si stock >= 30

Solo productos activos.
Ordenar por valor en inventario (descendente).
Limitar a los 5 primeros.

Pista: Para el estado_stock, puedes usar CASE WHEN:
CASE WHEN condicion THEN 'valor1' ELSE 'valor2' END
```

---

## ✅ Checklist

- [ ] Completé los ejercicios de Nivel 1 (4/4)
- [ ] Completé los ejercicios de Nivel 2 (4/4)
- [ ] Completé los ejercicios de Nivel 3 (4/4)
- [ ] Completé los ejercicios de Nivel 4 (4/4)
- [ ] Completé los ejercicios de Nivel 5 (4/4)
- [ ] Intenté el desafío extra

---

## 📖 Navegación

|                       ⬅️ Anterior                        |        Siguiente ➡️         |
| :------------------------------------------------------: | :-------------------------: |
| [Comandos Básicos](../2-practica/03-comandos-basicos.md) | [Soluciones](soluciones.md) |
