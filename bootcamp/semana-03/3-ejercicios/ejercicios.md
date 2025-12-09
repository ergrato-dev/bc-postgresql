# 🔧 Ejercicios: Semana 03 - DML

## 📋 Instrucciones

Resuelve cada ejercicio usando las tablas del bootcamp. Verifica tus respuestas ejecutando las consultas.

---

## 🟢 Nivel Básico

### Ejercicio 1: INSERT Simple

Inserta los siguientes datos en la tabla `categorias`:

| nombre   | descripcion             |
| -------- | ----------------------- |
| Hogar    | Artículos para el hogar |
| Deportes | Equipamiento deportivo  |
| Juguetes | Juguetes y juegos       |

---

### Ejercicio 2: INSERT Múltiple

Inserta 5 productos nuevos en una sola sentencia INSERT con estos datos:

| sku     | nombre        | precio | stock | categoria_id |
| ------- | ------------- | ------ | ----- | ------------ |
| HOG-001 | Aspiradora    | 199.99 | 25    | 5            |
| HOG-002 | Licuadora     | 79.99  | 50    | 5            |
| DEP-001 | Balón Fútbol  | 29.99  | 100   | 6            |
| DEP-002 | Raqueta Tenis | 89.99  | 30    | 6            |
| JUG-001 | LEGO Classic  | 49.99  | 75    | 7            |

---

### Ejercicio 3: UPDATE Simple

1. Aumenta el precio del producto 'Aspiradora' a $219.99
2. Cambia el stock del 'Balón Fútbol' a 150
3. Desactiva el producto con SKU 'JUG-001'

---

### Ejercicio 4: DELETE Simple

1. Elimina los productos que tengan stock = 0
2. Elimina la categoría 'Juguetes' (si no tiene productos asociados)

---

### Ejercicio 5: SELECT con WHERE

Escribe consultas para obtener:

1. Todos los productos con precio mayor a $100
2. Productos de la categoría 1 o categoría 2
3. Productos cuyo nombre contenga 'Samsung'
4. Clientes sin teléfono registrado
5. Productos activos con stock menor a 30

---

## 🟡 Nivel Intermedio

### Ejercicio 6: INSERT con RETURNING

1. Inserta un nuevo cliente y obtén su ID generado
2. Inserta un pedido para ese cliente y obtén el ID del pedido
3. Inserta 2 productos en el detalle del pedido

---

### Ejercicio 7: UPDATE con Expresiones

1. Aumenta 15% el precio de todos los productos de 'Electrónicos'
2. Reduce 5 unidades el stock de todos los productos con stock > 100
3. Actualiza el estado a 'procesando' para todos los pedidos 'pendiente' creados hoy

---

### Ejercicio 8: UPDATE con CASE

Escribe un UPDATE que:

- Si el precio < 50, aumentar 20%
- Si el precio está entre 50 y 200, aumentar 10%
- Si el precio > 200, aumentar 5%

Aplicar solo a productos activos.

---

### Ejercicio 9: SELECT Avanzado

Escribe consultas para:

1. Los 5 productos más caros de cada categoría (solo los primeros 5)
2. Productos cuyo valor de inventario (precio × stock) sea mayor a $10,000
3. Clientes registrados en el último mes
4. Productos ordenados por categoría y luego por precio descendente
5. El promedio de precio por categoría (usa GROUP BY)

---

### Ejercicio 10: UPSERT

1. Intenta insertar un producto con SKU existente - si existe, actualiza precio y stock
2. Inserta un producto nuevo, si ya existe el SKU, no hacer nada
3. Inserta productos desde un archivo CSV simulado (usa múltiples VALUES con ON CONFLICT)

---

## 🔴 Nivel Avanzado

### Ejercicio 11: Transacción Completa

Escribe una transacción que simule una venta:

1. Verificar que el producto tiene stock suficiente
2. Crear un nuevo pedido
3. Agregar productos al detalle
4. Decrementar el stock de cada producto
5. Calcular y actualizar el total del pedido
6. Si algo falla, revertir todo

---

### Ejercicio 12: DELETE Complejo

1. Elimina todos los detalles de pedidos cuyo pedido esté cancelado
2. Elimina pedidos sin detalles (pedidos vacíos)
3. Mueve productos inactivos a una tabla de histórico antes de eliminarlos

---

### Ejercicio 13: Consultas de Reporte

Escribe consultas para generar estos reportes:

1. **Inventario Bajo**: Productos con stock < 20, incluyendo valor del inventario
2. **Ventas por Estado**: Cantidad y total de pedidos agrupados por estado
3. **Productos Populares**: Los 10 productos más vendidos (por cantidad)
4. **Clientes VIP**: Clientes con más de 5 pedidos o total de compras > $1000

---

### Ejercicio 14: INSERT desde SELECT

1. Crea una tabla `productos_oferta` y copia productos con descuento
2. Genera un reporte mensual de ventas insertando en tabla de reportes
3. Crea una tabla de clientes activos (con pedidos en últimos 6 meses)

---

### Ejercicio 15: Migración de Datos

Escribe scripts para:

1. Normalizar emails (convertir a minúsculas)
2. Limpiar espacios en nombres de productos (TRIM)
3. Unificar formato de teléfonos
4. Generar SKUs faltantes con formato 'CAT-XXX'
5. Recalcular todos los totales de pedidos

---

## 📊 Criterios de Evaluación

| Criterio                        | Puntos |
| ------------------------------- | :----: |
| Sintaxis correcta               |   20   |
| Resultados esperados            |   30   |
| Uso de WHERE apropiado          |   20   |
| Uso de RETURNING cuando aplica  |   10   |
| Manejo de transacciones         |   10   |
| Buenas prácticas (no SELECT \*) |   10   |

---

## 📖 Navegación

|                        ⬅️ Práctica                         |        Siguiente ➡️         |
| :--------------------------------------------------------: | :-------------------------: |
| [Consultas Básicas](../2-practica/03-consultas-basicas.md) | [Soluciones](soluciones.md) |
