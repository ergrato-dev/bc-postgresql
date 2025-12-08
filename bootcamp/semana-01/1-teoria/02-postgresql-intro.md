# 🐘 Introducción a PostgreSQL

## 🎯 Objetivo

Conocer PostgreSQL, su historia, características principales y por qué es una excelente elección para proyectos modernos.

---

## 📖 ¿Qué es PostgreSQL?

**PostgreSQL** (pronunciado "post-gres-Q-L" o simplemente "Postgres") es un sistema de gestión de bases de datos relacional orientado a objetos (ORDBMS) de código abierto.

> 🐘 El elefante es su mascota oficial, simbolizando memoria, poder y fiabilidad.

---

## 📜 Historia Breve

| Año  | Evento                                       |
| ---- | -------------------------------------------- |
| 1986 | Nace como proyecto POSTGRES en UC Berkeley   |
| 1996 | Se renombra a PostgreSQL y añade soporte SQL |
| 2005 | Introducción de características enterprise   |
| 2017 | Replicación lógica nativa                    |
| 2024 | PostgreSQL 17 con mejoras de rendimiento     |
| 2025 | PostgreSQL 18 (versión actual del bootcamp)  |

---

## ⭐ ¿Por qué elegir PostgreSQL?

### Ventajas Principales

| Característica     | Beneficio                                  |
| ------------------ | ------------------------------------------ |
| **Open Source**    | Gratuito, sin costos de licencia           |
| **Estándar SQL**   | Compatible con SQL:2016                    |
| **Extensible**     | Tipos de datos personalizados, extensiones |
| **Confiable**      | +35 años de desarrollo activo              |
| **ACID Compliant** | Transacciones seguras                      |
| **Escalable**      | Desde pequeñas apps hasta enterprise       |

### Características Destacadas

```
┌─────────────────────────────────────────────────────────┐
│                  PostgreSQL 18                          │
├─────────────────────────────────────────────────────────┤
│  ✓ JSON/JSONB nativo          ✓ Full-text search       │
│  ✓ Tipos geoespaciales        ✓ Replicación            │
│  ✓ Particionamiento           ✓ Paralelismo            │
│  ✓ CTEs recursivos            ✓ Window functions       │
│  ✓ Triggers avanzados         ✓ Procedimientos PL/pgSQL│
│  ✓ Row-level security         ✓ Logical replication    │
└─────────────────────────────────────────────────────────┘
```

---

## 🆚 PostgreSQL vs Otros RDBMS

| Característica  | PostgreSQL |  MySQL   | SQL Server |
| --------------- | :--------: | :------: | :--------: |
| Open Source     |     ✅     |   ✅\*   |     ❌     |
| Costo           |   Gratis   | Gratis\* |    $$$     |
| JSON nativo     |     ✅     |    ✅    |     ✅     |
| Extensiones     |   ✅✅✅   |    ✅    |     ✅     |
| Estándar SQL    |   ✅✅✅   |   ✅✅   |    ✅✅    |
| Tipos custom    |     ✅     |    ❌    |     ❌     |
| Herencia tablas |     ✅     |    ❌    |     ❌     |

\*MySQL tiene versión community y enterprise (paga)

---

## 🏢 ¿Quién usa PostgreSQL?

### Empresas de Clase Mundial

| Empresa       | Uso                              |
| ------------- | -------------------------------- |
| **Apple**     | Infraestructura interna          |
| **Spotify**   | Millones de usuarios y playlists |
| **Instagram** | Datos de usuarios                |
| **Netflix**   | Catálogo y metadatos             |
| **Uber**      | Gestión de viajes y usuarios     |
| **Reddit**    | Contenido y comentarios          |

---

## 🧩 Extensiones Populares

PostgreSQL puede extenderse con módulos adicionales:

| Extensión              | Función                     |
| ---------------------- | --------------------------- |
| **PostGIS**            | Datos geoespaciales y mapas |
| **pg_trgm**            | Búsqueda por similitud      |
| **uuid-ossp**          | Generación de UUIDs         |
| **pg_stat_statements** | Análisis de consultas       |
| **pgcrypto**           | Funciones criptográficas    |
| **TimescaleDB**        | Series temporales           |

---

## 🔢 Tipos de Datos Nativos

PostgreSQL soporta una amplia variedad de tipos:

### Numéricos

```sql
INTEGER, BIGINT, DECIMAL, NUMERIC, REAL, DOUBLE PRECISION
```

### Texto

```sql
CHAR, VARCHAR, TEXT
```

### Fecha/Hora

```sql
DATE, TIME, TIMESTAMP, INTERVAL
```

### Especiales

```sql
BOOLEAN, UUID, JSON, JSONB, ARRAY, BYTEA
```

### Geométricos

```sql
POINT, LINE, POLYGON, CIRCLE
```

---

## 🌐 Ecosistema PostgreSQL

```
                    ┌─────────────────┐
                    │   PostgreSQL    │
                    │     Server      │
                    └────────┬────────┘
                             │
        ┌────────────────────┼────────────────────┐
        │                    │                    │
        ▼                    ▼                    ▼
┌───────────────┐   ┌───────────────┐   ┌───────────────┐
│    Clientes   │   │  Extensiones  │   │  Herramientas │
├───────────────┤   ├───────────────┤   ├───────────────┤
│ psql          │   │ PostGIS       │   │ pgAdmin       │
│ pgAdmin       │   │ pg_trgm       │   │ pg_dump       │
│ DBeaver       │   │ pgcrypto      │   │ pg_restore    │
│ Aplicaciones  │   │ TimescaleDB   │   │ pgbench       │
└───────────────┘   └───────────────┘   └───────────────┘
```

---

## 💡 PostgreSQL en la Nube

Servicios gestionados disponibles:

| Proveedor    | Servicio                      |
| ------------ | ----------------------------- |
| AWS          | Amazon RDS for PostgreSQL     |
| Google Cloud | Cloud SQL for PostgreSQL      |
| Azure        | Azure Database for PostgreSQL |
| Heroku       | Heroku Postgres               |
| DigitalOcean | Managed Databases             |

---

## ✅ Resumen

1. **PostgreSQL** es un RDBMS open source potente y maduro
2. Sigue el **estándar SQL** más estrictamente que otros
3. Es **extensible** con tipos y funciones personalizadas
4. Usado por **empresas de clase mundial**
5. Excelente para proyectos de **cualquier tamaño**

---

## 📖 Navegación

|                      ⬅️ Anterior                      |            Siguiente ➡️            |
| :---------------------------------------------------: | :--------------------------------: |
| [¿Qué es una Base de Datos?](01-que-es-base-datos.md) | [Arquitectura](03-arquitectura.md) |
