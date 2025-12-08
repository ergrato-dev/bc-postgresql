# 📚 ¿Qué es una Base de Datos?

## 🎯 Objetivo

Comprender los conceptos fundamentales de bases de datos y por qué son esenciales en el desarrollo de software moderno.

---

## 📖 Definición

Una **base de datos** es una colección organizada de datos estructurados, almacenados electrónicamente y diseñados para ser accedidos, gestionados y actualizados de forma eficiente.

> 💡 **Analogía**: Piensa en una base de datos como un archivador digital ultra-eficiente que puede encontrar cualquier documento en milisegundos.

---

## 🗂️ Tipos de Bases de Datos

### Bases de Datos Relacionales (SQL)

Organizan los datos en **tablas** con filas y columnas, relacionadas entre sí mediante **claves**.

| Característica | Descripción                           |
| -------------- | ------------------------------------- |
| Estructura     | Tablas con esquema definido           |
| Lenguaje       | SQL (Structured Query Language)       |
| Relaciones     | Claves primarias y foráneas           |
| Ejemplos       | PostgreSQL, MySQL, Oracle, SQL Server |

### Bases de Datos No Relacionales (NoSQL)

Almacenan datos en formatos más flexibles como documentos, grafos o pares clave-valor.

| Característica | Descripción                      |
| -------------- | -------------------------------- |
| Estructura     | Flexible, sin esquema fijo       |
| Tipos          | Documentos, Grafos, Clave-Valor  |
| Ejemplos       | MongoDB, Redis, Neo4j, Cassandra |

---

## 🔄 Modelo Relacional

El modelo relacional organiza los datos en:

### Tablas (Relaciones)

```
┌─────────────────────────────────────────────┐
│                  clientes                    │
├────────┬────────────┬───────────────────────┤
│   id   │   nombre   │        email          │
├────────┼────────────┼───────────────────────┤
│   1    │   María    │  maria@email.com      │
│   2    │   Carlos   │  carlos@email.com     │
│   3    │   Ana      │  ana@email.com        │
└────────┴────────────┴───────────────────────┘
```

### Componentes

| Componente  | Descripción                     | Ejemplo                |
| ----------- | ------------------------------- | ---------------------- |
| **Tabla**   | Colección de datos relacionados | `clientes`             |
| **Columna** | Atributo o campo                | `nombre`, `email`      |
| **Fila**    | Registro individual             | María, maria@email.com |
| **Celda**   | Valor específico                | "María"                |

---

## 🔑 Conceptos Fundamentales

### Clave Primaria (Primary Key)

Identificador **único** de cada fila en una tabla.

```sql
-- La columna 'id' es la clave primaria
id SERIAL PRIMARY KEY
```

**Características:**

- ✅ Única (no se repite)
- ✅ No nula (siempre tiene valor)
- ✅ Inmutable (no cambia)

### Clave Foránea (Foreign Key)

Referencia a la clave primaria de **otra tabla**, creando relaciones.

```sql
-- cliente_id referencia a la tabla clientes
cliente_id INTEGER REFERENCES clientes(id)
```

---

## 💡 ¿Por qué usar Bases de Datos?

| Problema                       | Solución con BD                 |
| ------------------------------ | ------------------------------- |
| Datos dispersos en archivos    | Centralización en un solo lugar |
| Duplicación de información     | Normalización y relaciones      |
| Acceso lento a datos           | Índices y optimización          |
| Inconsistencia de datos        | Transacciones ACID              |
| Múltiples usuarios simultáneos | Control de concurrencia         |
| Pérdida de datos               | Backups y recuperación          |

---

## 🏗️ ACID: Propiedades de las Transacciones

Las bases de datos relacionales garantizan:

| Propiedad       | Significado                  | Ejemplo                                             |
| --------------- | ---------------------------- | --------------------------------------------------- |
| **A**tomicity   | Todo o nada                  | Transferencia bancaria: o se completa o se revierte |
| **C**onsistency | Datos siempre válidos        | Saldo nunca negativo (si hay restricción)           |
| **I**solation   | Transacciones independientes | Dos usuarios no interfieren entre sí                |
| **D**urability  | Cambios permanentes          | Datos guardados sobreviven a fallos                 |

---

## 📊 Ejemplo: Sistema de Tienda Online

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│  categorias  │     │   productos  │     │   clientes   │
├──────────────┤     ├──────────────┤     ├──────────────┤
│ id           │◄────│ categoria_id │     │ id           │
│ nombre       │     │ id           │     │ nombre       │
└──────────────┘     │ nombre       │     │ email        │
                     │ precio       │     └──────┬───────┘
                     └──────────────┘            │
                                                 │
                     ┌──────────────┐            │
                     │   pedidos    │            │
                     ├──────────────┤            │
                     │ id           │            │
                     │ cliente_id   │────────────┘
                     │ fecha        │
                     │ total        │
                     └──────────────┘
```

---

## ✅ Resumen

1. Una **base de datos** organiza información para acceso eficiente
2. Las **bases relacionales** usan tablas conectadas por claves
3. **SQL** es el lenguaje para interactuar con bases relacionales
4. Las propiedades **ACID** garantizan integridad de datos
5. **PostgreSQL** es un RDBMS potente y open source

---

## 📖 Siguiente

➡️ [Introducción a PostgreSQL](02-postgresql-intro.md)
