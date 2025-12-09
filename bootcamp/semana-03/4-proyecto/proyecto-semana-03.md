# 🚀 Proyecto Semana 03: Sistema de Inventario

## 📋 Descripción

Implementarás las operaciones DML completas para un **sistema de gestión de inventario** de una tienda de tecnología.

---

## 🎯 Objetivos

- Aplicar INSERT, UPDATE, DELETE de forma práctica
- Usar SELECT para consultas de gestión
- Implementar lógica de negocio con SQL
- Manejar transacciones correctamente

---

## 📖 Contexto

La tienda "TechStore" necesita gestionar:

- **Productos**: Control de inventario
- **Proveedores**: Quién suministra productos
- **Entradas**: Registro de mercancía que llega
- **Salidas**: Registro de ventas/transferencias
- **Alertas**: Productos con stock bajo

---

## 📝 Parte 1: Estructura de Datos

### Crear las tablas necesarias

```sql
-- Esquema del proyecto
CREATE SCHEMA IF NOT EXISTS inventario;
SET search_path TO inventario, public;

-- Proveedores
CREATE TABLE proveedores (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(10) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    contacto VARCHAR(100),
    telefono VARCHAR(20),
    email VARCHAR(255),
    activo BOOLEAN DEFAULT TRUE
);

-- Productos de inventario
CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    sku VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    proveedor_id INTEGER REFERENCES proveedores(id),
    precio_compra DECIMAL(10,2) NOT NULL CHECK (precio_compra > 0),
    precio_venta DECIMAL(10,2) NOT NULL CHECK (precio_venta > 0),
    stock_actual INTEGER DEFAULT 0 CHECK (stock_actual >= 0),
    stock_minimo INTEGER DEFAULT 10,
    ubicacion VARCHAR(50),
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Movimientos de entrada
CREATE TABLE entradas (
    id SERIAL PRIMARY KEY,
    producto_id INTEGER REFERENCES productos(id),
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL,
    proveedor_id INTEGER REFERENCES proveedores(id),
    numero_factura VARCHAR(50),
    fecha TIMESTAMP DEFAULT NOW(),
    notas TEXT
);

-- Movimientos de salida
CREATE TABLE salidas (
    id SERIAL PRIMARY KEY,
    producto_id INTEGER REFERENCES productos(id),
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL,
    tipo VARCHAR(20) NOT NULL CHECK (tipo IN ('venta', 'transferencia', 'merma', 'devolucion')),
    referencia VARCHAR(50),
    fecha TIMESTAMP DEFAULT NOW(),
    notas TEXT
);

-- Vista de alertas de stock
CREATE VIEW alertas_stock AS
SELECT
    id,
    sku,
    nombre,
    stock_actual,
    stock_minimo,
    stock_actual - stock_minimo AS diferencia,
    CASE
        WHEN stock_actual = 0 THEN 'SIN STOCK'
        WHEN stock_actual < stock_minimo THEN 'BAJO'
        ELSE 'OK'
    END AS estado
FROM productos
WHERE stock_actual <= stock_minimo AND activo = TRUE;
```

---

## 📝 Parte 2: Poblar Datos Iniciales

### Tarea 1: Insertar Proveedores

Inserta al menos 5 proveedores con datos realistas.

**Requerimientos:**

- Códigos únicos con formato 'PROV-XXX'
- Al menos 2 con todos los datos completos
- Al menos 1 inactivo

---

### Tarea 2: Insertar Productos

Inserta al menos 15 productos distribuidos entre los proveedores.

**Requerimientos:**

- SKUs con formato por categoría (ELEC-XXX, COMP-XXX, etc.)
- Precios de venta > precios de compra (margen mínimo 20%)
- Stock variado (algunos en 0, algunos sobre mínimo, algunos bajo mínimo)
- Ubicaciones en formato 'PASILLO-ESTANTE' (ej: 'A1-01')

---

### Tarea 3: Registrar Movimientos

Inserta movimientos históricos:

- Al menos 10 entradas de mercancía
- Al menos 8 salidas (ventas, 1 merma, 1 transferencia)

---

## 📝 Parte 3: Operaciones de Gestión

### Tarea 4: Proceso de Compra (Entrada)

Crea un script que registre la recepción de mercancía:

```sql
-- Entrada de mercancía
-- Input: producto_id, cantidad, precio_compra, proveedor_id, factura

-- 1. Insertar en tabla entradas
-- 2. Actualizar stock del producto
-- 3. Actualizar precio_compra si es diferente
-- 4. Registrar fecha de actualización
```

---

### Tarea 5: Proceso de Venta (Salida)

Crea un script que registre una venta:

```sql
-- Venta de producto
-- Input: producto_id, cantidad, precio_venta

-- 1. Verificar stock disponible
-- 2. Insertar en tabla salidas
-- 3. Decrementar stock
-- 4. Si stock queda bajo mínimo, generar alerta
```

---

### Tarea 6: Ajuste de Inventario

Crea scripts para:

1. **Ajuste positivo**: Encontramos productos adicionales
2. **Ajuste negativo**: Productos dañados o perdidos (merma)
3. **Transferencia**: Mover a otra ubicación

---

## 📝 Parte 4: Consultas de Gestión

### Tarea 7: Reportes Requeridos

Escribe las consultas para estos reportes:

1. **Inventario Valorizado**

   - Producto, stock, precio compra, precio venta, valor total

2. **Productos con Stock Bajo**

   - Productos bajo mínimo, cuánto falta, proveedor sugerido

3. **Movimientos del Día**

   - Todas las entradas y salidas de hoy

4. **Rentabilidad por Producto**

   - Margen entre precio venta y compra, porcentaje

5. **Historial de un Producto**

   - Todos los movimientos de un SKU específico

6. **Resumen por Proveedor**
   - Total de productos, valor de inventario, movimientos

---

## 📝 Parte 5: Mantenimiento

### Tarea 8: Actualización Masiva

1. Aumentar 5% el precio de venta de todos los productos
2. Desactivar productos sin movimientos en 6 meses
3. Actualizar stock_minimo basado en ventas promedio

---

### Tarea 9: Limpieza de Datos

1. Eliminar movimientos de prueba (notas = 'TEST')
2. Archivar movimientos de más de 1 año a tabla histórica
3. Corregir ubicaciones con formato incorrecto

---

## 📦 Entregables

### Archivo 1: `01_crear_estructura.sql`

- CREATE TABLE para todas las tablas
- CREATE VIEW para alertas

### Archivo 2: `02_datos_iniciales.sql`

- INSERT de proveedores
- INSERT de productos
- INSERT de movimientos históricos

### Archivo 3: `03_procedimientos.sql`

- Script de entrada de mercancía
- Script de venta
- Script de ajustes

### Archivo 4: `04_reportes.sql`

- Todas las consultas de reporte

### Archivo 5: `05_mantenimiento.sql`

- Scripts de actualización masiva
- Scripts de limpieza

---

## 🎯 Rúbrica de Evaluación

| Criterio                        | Puntos  |
| ------------------------------- | :-----: |
| Estructura correcta             |   15    |
| Datos iniciales coherentes      |   15    |
| Proceso de compra funcional     |   15    |
| Proceso de venta con validación |   15    |
| Reportes correctos              |   20    |
| Manejo de transacciones         |   10    |
| Código documentado              |   10    |
| **Total**                       | **100** |

---

## 💡 Tips

1. Usa transacciones para operaciones que afectan múltiples tablas
2. Verifica con SELECT antes de UPDATE/DELETE
3. Usa RETURNING para confirmar operaciones
4. Mantén consistencia en formatos (SKU, códigos, ubicaciones)
5. Documenta la lógica de negocio en comentarios

---

## 🔍 Verificación

```sql
-- Verificar integridad de datos
SELECT
    (SELECT COUNT(*) FROM proveedores) AS proveedores,
    (SELECT COUNT(*) FROM productos) AS productos,
    (SELECT COUNT(*) FROM entradas) AS entradas,
    (SELECT COUNT(*) FROM salidas) AS salidas;

-- Verificar que los stocks cuadran
SELECT
    p.sku,
    p.stock_actual,
    COALESCE(e.total_entradas, 0) AS entradas,
    COALESCE(s.total_salidas, 0) AS salidas,
    COALESCE(e.total_entradas, 0) - COALESCE(s.total_salidas, 0) AS stock_calculado,
    p.stock_actual = (COALESCE(e.total_entradas, 0) - COALESCE(s.total_salidas, 0)) AS cuadra
FROM productos p
LEFT JOIN (
    SELECT producto_id, SUM(cantidad) AS total_entradas
    FROM entradas GROUP BY producto_id
) e ON p.id = e.producto_id
LEFT JOIN (
    SELECT producto_id, SUM(cantidad) AS total_salidas
    FROM salidas GROUP BY producto_id
) s ON p.id = s.producto_id;
```

---

## 📖 Navegación

|                ⬅️ Ejercicios                |      🏠 Semana 03      |             Siguiente ➡️              |
| :-----------------------------------------: | :--------------------: | :-----------------------------------: |
| [Soluciones](../3-ejercicios/soluciones.md) | [README](../README.md) | [Recursos](../5-recursos/recursos.md) |
