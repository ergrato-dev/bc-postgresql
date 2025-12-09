# 🚀 Proyecto Semana 02: Diseño de Base de Datos

## 📋 Descripción

Diseñarás y crearás la estructura completa de base de datos para un **sistema de gestión de biblioteca**.

---

## 🎯 Objetivos

- Aplicar DDL para crear una base de datos desde cero
- Elegir tipos de datos apropiados para cada caso
- Implementar todas las restricciones necesarias
- Crear relaciones entre tablas

---

## 📖 Contexto

La biblioteca "El Saber" necesita un sistema para gestionar:

- **Libros**: catálogo completo con autores y editoriales
- **Socios**: miembros registrados que pueden tomar préstamos
- **Préstamos**: control de libros prestados y devueltos
- **Multas**: penalizaciones por retrasos
- **Personal**: empleados de la biblioteca

---

## 📝 Requisitos

### Esquema General

Crear un esquema llamado `biblioteca` con las siguientes tablas:

### 1. `autores`

| Columna             | Tipo             | Restricciones |
| ------------------- | ---------------- | ------------- |
| id                  | Auto-incremental | PK            |
| nombre              | Texto (100)      | NOT NULL      |
| apellido            | Texto (100)      | NOT NULL      |
| pais                | Texto (50)       | -             |
| fecha_nacimiento    | Fecha            | -             |
| fecha_fallecimiento | Fecha            | -             |
| biografia           | Texto largo      | -             |

**Validaciones**:

- fecha_fallecimiento debe ser posterior a fecha_nacimiento

### 2. `editoriales`

| Columna   | Tipo             | Restricciones    |
| --------- | ---------------- | ---------------- |
| id        | Auto-incremental | PK               |
| nombre    | Texto (100)      | NOT NULL, UNIQUE |
| pais      | Texto (50)       | -                |
| sitio_web | Texto (255)      | -                |
| activa    | Booleano         | DEFAULT TRUE     |

### 3. `libros`

| Columna                | Tipo             | Restricciones     |
| ---------------------- | ---------------- | ----------------- |
| id                     | Auto-incremental | PK                |
| isbn                   | Texto (20)       | UNIQUE, NOT NULL  |
| titulo                 | Texto (200)      | NOT NULL          |
| editorial_id           | Entero           | FK → editoriales  |
| anio_publicacion       | Entero           | -                 |
| paginas                | Entero           | -                 |
| idioma                 | Texto (30)       | DEFAULT 'Español' |
| ejemplares_totales     | Entero           | DEFAULT 1         |
| ejemplares_disponibles | Entero           | DEFAULT 1         |
| ubicacion              | Texto (50)       | -                 |
| created_at             | Timestamp        | DEFAULT NOW()     |

**Validaciones**:

- anio_publicacion entre 1000 y año actual + 1
- paginas > 0
- ejemplares_totales >= 1
- ejemplares_disponibles <= ejemplares_totales
- ejemplares_disponibles >= 0

### 4. `libros_autores`

Relación muchos a muchos entre libros y autores.

| Columna  | Tipo       | Restricciones    |
| -------- | ---------- | ---------------- |
| libro_id | Entero     | PK, FK → libros  |
| autor_id | Entero     | PK, FK → autores |
| rol      | Texto (30) | DEFAULT 'Autor'  |

**Valores de rol**: 'Autor', 'Coautor', 'Editor', 'Traductor', 'Ilustrador'

### 5. `categorias`

| Columna            | Tipo             | Restricciones                     |
| ------------------ | ---------------- | --------------------------------- |
| id                 | Auto-incremental | PK                                |
| nombre             | Texto (50)       | NOT NULL, UNIQUE                  |
| descripcion        | Texto            | -                                 |
| categoria_padre_id | Entero           | FK → categorias (autorreferencia) |

### 6. `libros_categorias`

| Columna      | Tipo   | Restricciones       |
| ------------ | ------ | ------------------- |
| libro_id     | Entero | PK, FK → libros     |
| categoria_id | Entero | PK, FK → categorias |

### 7. `socios`

| Columna           | Tipo             | Restricciones        |
| ----------------- | ---------------- | -------------------- |
| id                | Auto-incremental | PK                   |
| numero_socio      | Texto (10)       | UNIQUE, NOT NULL     |
| dni               | Texto (20)       | UNIQUE, NOT NULL     |
| nombre            | Texto (100)      | NOT NULL             |
| apellido          | Texto (100)      | NOT NULL             |
| email             | Texto (255)      | UNIQUE               |
| telefono          | Texto (20)       | -                    |
| direccion         | Texto            | -                    |
| fecha_nacimiento  | Fecha            | -                    |
| fecha_alta        | Fecha            | DEFAULT CURRENT_DATE |
| fecha_vencimiento | Fecha            | -                    |
| activo            | Booleano         | DEFAULT TRUE         |
| tipo_socio        | Texto (20)       | DEFAULT 'regular'    |
| prestamos_maximos | Entero           | DEFAULT 3            |

**Validaciones**:

- tipo_socio: 'regular', 'estudiante', 'docente', 'senior'
- prestamos_maximos entre 1 y 10
- fecha_vencimiento > fecha_alta

### 8. `empleados`

| Columna       | Tipo             | Restricciones        |
| ------------- | ---------------- | -------------------- |
| id            | Auto-incremental | PK                   |
| legajo        | Texto (10)       | UNIQUE, NOT NULL     |
| nombre        | Texto (100)      | NOT NULL             |
| apellido      | Texto (100)      | NOT NULL             |
| email         | Texto (255)      | UNIQUE               |
| cargo         | Texto (50)       | NOT NULL             |
| fecha_ingreso | Fecha            | DEFAULT CURRENT_DATE |
| salario       | Decimal (10,2)   | -                    |
| activo        | Booleano         | DEFAULT TRUE         |

**Validaciones**:

- salario > 0

### 9. `prestamos`

| Columna                   | Tipo             | Restricciones    |
| ------------------------- | ---------------- | ---------------- |
| id                        | Auto-incremental | PK               |
| libro_id                  | Entero           | FK → libros      |
| socio_id                  | Entero           | FK → socios      |
| empleado_prestamo_id      | Entero           | FK → empleados   |
| empleado_devolucion_id    | Entero           | FK → empleados   |
| fecha_prestamo            | Timestamp        | DEFAULT NOW()    |
| fecha_devolucion_esperada | Date             | NOT NULL         |
| fecha_devolucion_real     | Timestamp        | -                |
| estado                    | Texto (20)       | DEFAULT 'activo' |
| notas                     | Texto            | -                |

**Validaciones**:

- estado: 'activo', 'devuelto', 'atrasado', 'perdido'
- fecha_devolucion_esperada > fecha_prestamo
- fecha_devolucion_real >= fecha_prestamo (si no es NULL)

### 10. `multas`

| Columna       | Tipo             | Restricciones  |
| ------------- | ---------------- | -------------- |
| id            | Auto-incremental | PK             |
| prestamo_id   | Entero           | FK → prestamos |
| monto         | Decimal (10,2)   | NOT NULL       |
| motivo        | Texto (100)      | NOT NULL       |
| fecha_emision | Timestamp        | DEFAULT NOW()  |
| fecha_pago    | Timestamp        | -              |
| pagada        | Booleano         | DEFAULT FALSE  |

**Validaciones**:

- monto > 0
- motivo: 'retraso', 'deterioro', 'perdida'

---

## 📦 Entregables

### Archivo 1: `01_crear_esquema.sql`

```sql
-- Crear esquema y extensiones necesarias
CREATE SCHEMA IF NOT EXISTS biblioteca;
SET search_path TO biblioteca, public;
```

### Archivo 2: `02_crear_tablas.sql`

Todas las sentencias CREATE TABLE en orden (primero las tablas sin dependencias).

### Archivo 3: `03_datos_iniciales.sql`

Insertar datos de prueba:

- Al menos 5 autores
- Al menos 3 editoriales
- Al menos 5 categorías (con al menos una subcategoría)
- Al menos 10 libros
- Al menos 5 socios
- Al menos 3 empleados
- Al menos 5 préstamos (algunos activos, algunos devueltos)
- Al menos 2 multas

### Archivo 4: `04_indices.sql`

Crear índices para:

- Búsqueda de libros por título
- Búsqueda de libros por ISBN
- Búsqueda de socios por número de socio y DNI
- Préstamos activos
- Multas no pagadas

---

## 🎯 Rúbrica de Evaluación

| Criterio                                   | Puntos  |
| ------------------------------------------ | :-----: |
| Esquema creado correctamente               |    5    |
| Tablas con tipos de datos apropiados       |   20    |
| Primary Keys en todas las tablas           |   10    |
| Foreign Keys con acciones ON DELETE/UPDATE |   15    |
| Constraints CHECK implementados            |   15    |
| Valores DEFAULT correctos                  |   10    |
| Índices creados                            |   10    |
| Datos de prueba coherentes                 |   10    |
| Código limpio y comentado                  |    5    |
| **Total**                                  | **100** |

---

## 💡 Tips

1. Crea las tablas en orden: primero las que no tienen FK
2. Usa nombres descriptivos para las constraints
3. Comenta cada sección del código
4. Prueba cada tabla antes de crear la siguiente
5. Verifica las FK insertando datos de prueba

---

## 🔍 Verificación

Después de crear todo, ejecuta estos comandos para verificar:

```sql
-- Ver todas las tablas del esquema
\dt biblioteca.*

-- Ver estructura de cada tabla
\d+ biblioteca.libros
\d+ biblioteca.prestamos

-- Ver constraints
SELECT table_name, constraint_name, constraint_type
FROM information_schema.table_constraints
WHERE table_schema = 'biblioteca';

-- Ver foreign keys
SELECT
    tc.table_name,
    kcu.column_name,
    ccu.table_name AS foreign_table,
    ccu.column_name AS foreign_column
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
JOIN information_schema.constraint_column_usage ccu
    ON tc.constraint_name = ccu.constraint_name
WHERE tc.constraint_type = 'FOREIGN KEY'
    AND tc.table_schema = 'biblioteca';
```

---

## 📖 Navegación

|                ⬅️ Ejercicios                |      🏠 Semana 02      |             Siguiente ➡️              |
| :-----------------------------------------: | :--------------------: | :-----------------------------------: |
| [Soluciones](../3-ejercicios/soluciones.md) | [README](../README.md) | [Recursos](../5-recursos/recursos.md) |
