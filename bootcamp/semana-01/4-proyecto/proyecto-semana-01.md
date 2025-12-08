# 🚀 Proyecto Semana 01: Explorador de Tienda

## 🎯 Objetivo

Crear un conjunto de consultas SQL que funcionen como un "explorador" de la tienda online, permitiendo obtener información útil sobre productos, clientes y categorías.

---

## 📋 Contexto

Eres el nuevo analista de datos de una tienda online. Tu primera tarea es crear un conjunto de consultas que permitan al equipo de negocio obtener información rápida sobre el inventario y los clientes.

---

## 📝 Entregables

Debes crear un archivo SQL con las siguientes consultas, cada una comentada con su propósito.

### Estructura del archivo

```sql
-- ============================================
-- Proyecto Semana 01: Explorador de Tienda
-- Autor: [Tu nombre]
-- Fecha: [Fecha]
-- ============================================

-- Consulta 1: ...
-- Consulta 2: ...
-- etc.
```

---

## 🏗️ Consultas a Desarrollar

### Consulta 1: Catálogo de Productos

**Requisito del negocio**: "Necesitamos ver el catálogo completo con precios"

```
Crea una consulta que muestre:
- Nombre del producto
- Precio
- Stock disponible
- Si está activo o no

Ordenar por nombre alfabéticamente.
```

---

### Consulta 2: Productos Destacados

**Requisito del negocio**: "Queremos promocionar los productos más caros"

```
Crea una consulta que muestre los 5 productos más caros que:
- Tengan stock disponible (> 0)
- Estén activos

Mostrar: nombre, precio, stock
```

---

### Consulta 3: Inventario Bajo

**Requisito del negocio**: "Alertar sobre productos con poco stock"

```
Crea una consulta que muestre productos con stock menor a 50 unidades.

Mostrar: nombre, stock, precio
Ordenar por stock (de menor a mayor) para ver los más urgentes primero.
```

---

### Consulta 4: Búsqueda de Productos

**Requisito del negocio**: "Los clientes buscan productos tecnológicos"

```
Crea una consulta que encuentre productos relacionados con tecnología.
Busca en el nombre palabras como: 'Laptop', 'Auriculares', 'Teclado', 'LED'

Mostrar: nombre, precio, stock
```

---

### Consulta 5: Directorio de Clientes

**Requisito del negocio**: "Necesitamos un directorio de clientes por ciudad"

```
Crea una consulta que muestre:
- Nombre completo (nombre + apellido)
- Email
- Ciudad

Ordenar por ciudad y luego por apellido.
```

---

### Consulta 6: Clientes por Región

**Requisito del negocio**: "¿Cuántos clientes tenemos en cada ciudad?"

```
Crea una consulta que muestre las ciudades únicas donde tenemos clientes.
Ordenar alfabéticamente.

(La próxima semana aprenderás a contar cuántos hay en cada una)
```

---

### Consulta 7: Rango de Precios

**Requisito del negocio**: "Productos accesibles para promoción"

```
Crea una consulta que muestre productos con precio entre 15 y 50 euros.

Mostrar: nombre, precio
Ordenar por precio.
```

---

### Consulta 8: Reporte de Valor de Inventario

**Requisito del negocio**: "¿Cuánto dinero tenemos en inventario por producto?"

```
Crea una consulta que muestre:
- Nombre del producto
- Precio unitario
- Stock
- Valor total en inventario (precio × stock)

Solo productos activos.
Ordenar por valor total (descendente).
Limitar a los 10 productos con más valor en inventario.
```

---

### Consulta 9: Productos sin Categoría

**Requisito del negocio**: "Verificar integridad de datos"

```
Crea una consulta que encuentre productos sin categoría asignada
(categoria_id es NULL).

Si no hay ninguno, la consulta debe devolver 0 filas (lo cual es correcto).
```

---

### Consulta 10: Ficha de Producto

**Requisito del negocio**: "Mostrar detalle de un producto específico"

```
Crea una consulta que muestre toda la información de un producto específico.
Usa el producto con id = 1.

Mostrar todas las columnas formateadas con alias descriptivos en español.
```

---

## 📁 Plantilla del Archivo

Guarda tu trabajo en: `bootcamp/semana-01/4-proyecto/explorador_tienda.sql`

```sql
-- ============================================
-- Proyecto Semana 01: Explorador de Tienda
-- Bootcamp PostgreSQL - Zero to Hero
-- Autor: [Tu nombre]
-- Fecha: [Fecha]
-- ============================================

-- ============================================
-- CONSULTA 1: Catálogo de Productos
-- Requisito: Ver el catálogo completo con precios
-- ============================================
SELECT
    -- Tu código aquí
FROM productos
ORDER BY nombre;

-- ============================================
-- CONSULTA 2: Productos Destacados
-- Requisito: Top 5 productos más caros disponibles
-- ============================================
-- Tu código aquí

-- [Continúa con las demás consultas...]
```

---

## ✅ Criterios de Evaluación

| Criterio                                  | Puntos  |
| ----------------------------------------- | :-----: |
| Todas las consultas funcionan sin errores |   30    |
| Consultas devuelven los datos correctos   |   30    |
| Uso correcto de alias y formato           |   15    |
| Comentarios claros y descriptivos         |   15    |
| Código limpio y bien indentado            |   10    |
| **Total**                                 | **100** |

---

## 🎁 Bonus

Si terminaste todo, intenta estos extras:

### Bonus 1: Etiquetas de precio

```
Añade a la Consulta 1 una columna 'rango_precio' que muestre:
- 'ECONÓMICO' si precio < 30
- 'MEDIO' si precio entre 30 y 100
- 'PREMIUM' si precio > 100
```

### Bonus 2: Formato de moneda

```
En la Consulta 8, formatea el valor del inventario como texto con símbolo €
Ejemplo: 1299.99 → '€ 1,299.99'
Pista: Investiga la función TO_CHAR()
```

---

## 📤 Entrega

1. Crea el archivo `explorador_tienda.sql` en la carpeta `4-proyecto/`
2. Ejecuta cada consulta para verificar que funciona
3. Asegúrate de que los comentarios explican cada consulta

---

## 📖 Navegación

|                 ⬅️ Anterior                 |      🏠 Semana 01      |             Siguiente ➡️              |
| :-----------------------------------------: | :--------------------: | :-----------------------------------: |
| [Soluciones](../3-ejercicios/soluciones.md) | [README](../README.md) | [Recursos](../5-recursos/recursos.md) |
