# 🔧 Ejercicios: Semana 02 - DDL

## 📋 Instrucciones

Resuelve cada ejercicio de forma independiente. Verifica tus respuestas con los comandos `\d` y `\d+` después de cada ejercicio.

---

## 🟢 Nivel Básico

### Ejercicio 1: Crear Tabla de Productos

Crea una tabla `articulos` con las siguientes columnas:

- `id`: Entero autoincremental, clave primaria
- `codigo`: Cadena de máximo 20 caracteres, único, no nulo
- `nombre`: Cadena de máximo 100 caracteres, no nulo
- `precio`: Decimal con 10 dígitos totales y 2 decimales
- `disponible`: Booleano con valor por defecto TRUE

---

### Ejercicio 2: Tipos de Datos Correctos

Para cada dato, indica el tipo de dato más apropiado:

| Dato                 | Tipo de Dato |
| -------------------- | ------------ |
| Número de teléfono   | ?            |
| Salario mensual      | ?            |
| Fecha de nacimiento  | ?            |
| Biografía de usuario | ?            |
| Cantidad en stock    | ?            |
| ¿Es miembro VIP?     | ?            |
| Hora de apertura     | ?            |
| Código postal        | ?            |
| Coordenadas GPS      | ?            |
| Configuración JSON   | ?            |

---

### Ejercicio 3: Agregar Columnas

Tienes la siguiente tabla:

```sql
CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);
```

Agrega las siguientes columnas:

1. `email` (VARCHAR 255, único, no nulo)
2. `fecha_registro` (TIMESTAMP con valor por defecto NOW())
3. `credito_disponible` (DECIMAL con CHECK > 0 o NULL)
4. `activo` (BOOLEAN, por defecto TRUE)

---

## 🟡 Nivel Intermedio

### Ejercicio 4: Sistema de Cursos

Diseña y crea las tablas para un sistema de cursos online:

1. **profesores**: id, nombre, email (único), especialidad
2. **cursos**: id, titulo, descripcion, profesor_id (FK), precio, duracion_horas
3. **estudiantes**: id, nombre, email (único), fecha_inscripcion
4. **inscripciones**: estudiante_id, curso_id, fecha, calificacion (0-100), completado

Requisitos:

- Todas las tablas deben tener clave primaria
- Las FKs deben tener nombres descriptivos
- Agregar CHECK para calificacion entre 0 y 100
- La tabla inscripciones debe evitar duplicados (mismo estudiante en mismo curso)

---

### Ejercicio 5: Modificaciones Complejas

Dada la siguiente tabla:

```sql
CREATE TABLE empleados (
    id SERIAL PRIMARY KEY,
    nombre_completo VARCHAR(200),
    salario NUMERIC,
    departamento VARCHAR(50)
);
```

Realiza las siguientes modificaciones:

1. Divide `nombre_completo` en `nombre` y `apellido` (ambos VARCHAR(100) NOT NULL)
2. Cambia `salario` a DECIMAL(12,2) con CHECK > 0
3. Crea una tabla `departamentos` y reemplaza la columna `departamento` por `departamento_id` (FK)
4. Agrega columna `fecha_contratacion` (DATE, por defecto hoy)
5. Agrega columna `email` (VARCHAR 255, UNIQUE)

---

### Ejercicio 6: Constraints

Para cada escenario, escribe la restricción CHECK apropiada:

1. El campo `edad` debe estar entre 0 y 150
2. El campo `porcentaje` debe estar entre 0 y 100
3. El campo `email` debe contener '@'
4. El campo `fecha_fin` debe ser mayor o igual a `fecha_inicio`
5. El campo `estado` solo puede ser 'activo', 'inactivo' o 'pendiente'
6. El campo `codigo` debe tener exactamente 10 caracteres
7. El campo `precio` debe ser positivo
8. El campo `stock` no puede ser negativo

---

## 🔴 Nivel Avanzado

### Ejercicio 7: Sistema de E-commerce

Diseña el esquema completo para un sistema de e-commerce con:

**Esquema `catalogo`**:

- `marcas`: id, nombre, pais_origen, logo_url
- `categorias`: id, nombre, categoria_padre_id (autorreferencia)
- `productos`: id, sku (único), nombre, marca_id, categoria_id, precio, descripcion, specs (JSONB)

**Esquema `ventas`**:

- `clientes`: id, uuid (UUID único), email, password_hash, datos_personales (JSONB)
- `direcciones`: id, cliente_id, tipo (envio/facturacion), direccion_completa (TEXT)
- `carritos`: id, cliente_id, creado_at, actualizado_at
- `carrito_items`: carrito_id, producto_id, cantidad
- `ordenes`: id, numero_orden (único), cliente_id, direccion_envio_id, estado (ENUM), total
- `orden_items`: orden_id, producto_id, cantidad, precio_unitario, subtotal (calculado)

**Esquema `inventario`**:

- `almacenes`: id, codigo, nombre, ubicacion (POINT)
- `stock`: almacen_id, producto_id, cantidad, minimo_alerta

Requisitos:

- Usar ENUM para estados de orden
- Columnas calculadas donde aplique
- Índices en campos de búsqueda frecuente
- Todas las relaciones con ON DELETE apropiado

---

### Ejercicio 8: Migraciones

Escribe los comandos para migrar la siguiente tabla:

```sql
CREATE TABLE usuarios_v1 (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    datos TEXT  -- Contiene JSON como string
);
```

A esta estructura:

```sql
CREATE TABLE usuarios_v2 (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_legacy INTEGER,  -- Guardar el id antiguo
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100),
    perfil JSONB DEFAULT '{}',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

---

### Ejercicio 9: Tabla de Auditoría

Crea una tabla `auditoria.cambios` que registre:

- ID del cambio (UUID)
- Tabla afectada
- Operación (INSERT/UPDATE/DELETE)
- Datos anteriores (JSONB, NULL para INSERT)
- Datos nuevos (JSONB, NULL para DELETE)
- Usuario que hizo el cambio
- Fecha y hora con zona horaria
- IP del cliente (INET)

Incluye:

- Índices para búsqueda por tabla y fecha
- Partición por rango de fechas (mensual)
- Constraint CHECK para operación válida

---

### Ejercicio 10: Optimización de Tipos

La siguiente tabla tiene problemas de diseño. Identifícalos y corrígelos:

```sql
CREATE TABLE pedidos_mal_disenados (
    id VARCHAR(50),                    -- Problema 1
    fecha TEXT,                        -- Problema 2
    cliente_nombre VARCHAR(1000),      -- Problema 3
    total REAL,                        -- Problema 4
    items TEXT,                        -- Problema 5
    estado VARCHAR(255),               -- Problema 6
    descuento VARCHAR(10),             -- Problema 7
    activo VARCHAR(5),                 -- Problema 8
    ip_cliente VARCHAR(50),            -- Problema 9
    metadata VARCHAR(MAX)              -- Problema 10
);
```

Para cada columna, explica:

1. Cuál es el problema
2. Qué tipo debería usar
3. Qué constraints agregarías

---

## 📊 Criterios de Evaluación

| Criterio                            | Puntos |
| ----------------------------------- | :----: |
| Sintaxis correcta                   |   20   |
| Tipos de datos apropiados           |   20   |
| Constraints adecuadas               |   20   |
| Relaciones bien definidas           |   20   |
| Buenas prácticas (nombres, índices) |   20   |

---

## 📖 Navegación

|                            ⬅️ Práctica                             |        Siguiente ➡️         |
| :----------------------------------------------------------------: | :-------------------------: |
| [Modificar Estructuras](../2-practica/03-modificar-estructuras.md) | [Soluciones](soluciones.md) |
