# 🏗️ Arquitectura de PostgreSQL

## 🎯 Objetivo

Entender cómo funciona PostgreSQL internamente: su modelo cliente-servidor, procesos y estructura de almacenamiento.

---

## 🔄 Modelo Cliente-Servidor

PostgreSQL utiliza una arquitectura **cliente-servidor**:

![Arquitectura Cliente-Servidor](../0-assets/diagrama-arquitectura-cliente-servidor.svg)

### Cliente

El **cliente** es cualquier aplicación que se conecta a PostgreSQL:

| Cliente    | Descripción                       |
| ---------- | --------------------------------- |
| `psql`     | Terminal interactiva oficial      |
| pgAdmin    | Interfaz gráfica web              |
| DBeaver    | Cliente universal de BD           |
| Aplicación | Tu código (Python, Node, Java...) |

### Servidor

El **servidor** (también llamado "backend") gestiona:

- Conexiones de clientes
- Procesamiento de consultas
- Almacenamiento de datos
- Transacciones y concurrencia

---

## 🔧 Procesos de PostgreSQL

Cuando PostgreSQL está corriendo, varios procesos trabajan en conjunto:

```
┌─────────────────────────────────────────────────────────┐
│                    POSTMASTER                           │
│              (Proceso principal)                        │
│                       │                                 │
│     ┌─────────────────┼─────────────────┐               │
│     │                 │                 │               │
│     ▼                 ▼                 ▼               │
│ ┌────────┐      ┌────────┐       ┌────────┐            │
│ │Backend │      │Backend │       │Backend │   ...      │
│ │   1    │      │   2    │       │   N    │            │
│ └────────┘      └────────┘       └────────┘            │
│     │                                                   │
│     │  Procesos auxiliares:                            │
│     │  - Background Writer                              │
│     │  - WAL Writer                                     │
│     │  - Checkpointer                                   │
│     │  - Autovacuum                                     │
│     │  - Stats Collector                                │
└─────────────────────────────────────────────────────────┘
```

### Descripción de Procesos

| Proceso               | Función                                |
| --------------------- | -------------------------------------- |
| **Postmaster**        | Proceso padre, acepta conexiones       |
| **Backend**           | Un proceso por cada conexión cliente   |
| **Background Writer** | Escribe páginas sucias a disco         |
| **WAL Writer**        | Escribe logs de transacciones          |
| **Checkpointer**      | Crea puntos de recuperación            |
| **Autovacuum**        | Limpieza automática de datos obsoletos |

---

## 📂 Estructura de Directorios

Cuando PostgreSQL se instala, crea una estructura de archivos:

```
$PGDATA/
├── base/                 # Datos de las bases de datos
│   ├── 1/                # template1
│   ├── 13067/            # template0
│   └── 16384/            # tu_base_de_datos
├── global/               # Datos compartidos del cluster
├── pg_wal/               # Write-Ahead Logs (WAL)
├── pg_stat/              # Estadísticas permanentes
├── pg_stat_tmp/          # Estadísticas temporales
├── postgresql.conf       # Configuración principal
├── pg_hba.conf           # Autenticación de clientes
└── pg_ident.conf         # Mapeo de usuarios
```

---

## 🗄️ Jerarquía de Objetos

PostgreSQL organiza los datos en una jerarquía clara:

![Jerarquía de Objetos](../0-assets/diagrama-jerarquia-objetos.svg)

### Niveles

| Nivel | Objeto         | Descripción                           |
| ----- | -------------- | ------------------------------------- |
| 1     | **Cluster**    | Instancia de PostgreSQL (un servidor) |
| 2     | **Database**   | Base de datos individual              |
| 3     | **Schema**     | Namespace dentro de una BD            |
| 4     | **Table/View** | Objetos que contienen datos           |
| 5     | **Column**     | Atributos de una tabla                |

### Ejemplo Práctico

```sql
-- Cluster: localhost:5432
-- Database: tienda_online
-- Schema: public
-- Table: productos

SELECT id, nombre, precio
FROM public.productos;

-- Equivalente (public es el schema por defecto):
SELECT id, nombre, precio
FROM productos;
```

---

## 🔀 Flujo de una Consulta

Cuando envías una consulta SQL, pasa por varias etapas:

![Flujo de Consulta](../0-assets/diagrama-flujo-consulta.svg)

### Etapas Detalladas

| Etapa | Proceso      | Descripción                                  |
| ----- | ------------ | -------------------------------------------- |
| 1     | **Parser**   | Analiza sintaxis SQL, crea árbol de consulta |
| 2     | **Analyzer** | Verifica objetos existen, resuelve nombres   |
| 3     | **Rewriter** | Aplica reglas y transforma vistas            |
| 4     | **Planner**  | Genera plan de ejecución óptimo              |
| 5     | **Executor** | Ejecuta el plan, accede a datos              |

---

## 💾 Almacenamiento

### Páginas

PostgreSQL almacena datos en **páginas** de 8KB:

```
┌────────────────────────────────────────┐
│              PÁGINA (8KB)              │
├────────────────────────────────────────┤
│  Header (24 bytes)                     │
├────────────────────────────────────────┤
│  ItemId Array (punteros a tuplas)      │
├────────────────────────────────────────┤
│                                        │
│         Espacio libre                  │
│                                        │
├────────────────────────────────────────┤
│  Tupla 3                               │
│  Tupla 2                               │
│  Tupla 1                               │
├────────────────────────────────────────┤
│  Special Space (para índices)          │
└────────────────────────────────────────┘
```

### MVCC (Multi-Version Concurrency Control)

PostgreSQL usa **MVCC** para manejar concurrencia:

- Cada transacción ve una "foto" consistente de los datos
- Las escrituras no bloquean las lecturas
- Se mantienen múltiples versiones de cada fila

---

## 📡 Conexión: Puerto y Socket

### Conexión por Red (TCP/IP)

```
Cliente ──────────────────────► Servidor
         Puerto 5432 (default)
         Protocolo PostgreSQL
```

### Conexión Local (Unix Socket)

```
Cliente ──────────────────────► Servidor
         /var/run/postgresql/.s.PGSQL.5432
         (Solo en Linux/macOS)
```

---

## 🔐 Archivos de Configuración

| Archivo           | Propósito                                              |
| ----------------- | ------------------------------------------------------ |
| `postgresql.conf` | Configuración del servidor (memoria, conexiones, logs) |
| `pg_hba.conf`     | Control de acceso (quién puede conectarse)             |
| `pg_ident.conf`   | Mapeo de usuarios del sistema a usuarios de BD         |

### Ejemplo pg_hba.conf

```
# TYPE  DATABASE    USER        ADDRESS         METHOD
local   all         all                         trust
host    all         all         127.0.0.1/32    md5
host    all         all         ::1/128         md5
```

---

## ✅ Resumen

1. PostgreSQL usa arquitectura **cliente-servidor**
2. El **Postmaster** es el proceso principal que gestiona conexiones
3. Cada conexión tiene su propio proceso **backend**
4. Los datos se organizan en: Cluster → Database → Schema → Table
5. Las consultas pasan por: Parser → Planner → Executor
6. **MVCC** permite alta concurrencia sin bloqueos

---

## 📖 Navegación

|                ⬅️ Anterior                 |      🏠 Semana 01      |                        Siguiente ➡️                        |
| :----------------------------------------: | :--------------------: | :--------------------------------------------------------: |
| [PostgreSQL Intro](02-postgresql-intro.md) | [README](../README.md) | [Práctica: Docker Setup](../2-practica/01-docker-setup.md) |
