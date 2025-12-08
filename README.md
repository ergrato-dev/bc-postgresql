<p align="center">
  <img src="_assets/banner-postgresql-bootcamp.svg" alt="Bootcamp PostgreSQL - Zero to Hero" width="100%">
</p>

# 🐘 Bootcamp PostgreSQL - Zero to Hero

Bootcamp completo de PostgreSQL diseñado para llevarte desde cero hasta un nivel avanzado en **14 semanas** con solo **4 horas de dedicación semanal** (56 horas totales). Cubre **desarrollo SQL** y **administración de bases de datos (DBA)**.

---

## 🎯 Objetivos del Bootcamp

Al finalizar este bootcamp serás capaz de:

### 💻 Desarrollo SQL

- ✅ Diseñar y crear bases de datos relacionales
- ✅ Escribir consultas SQL desde básicas hasta avanzadas
- ✅ Optimizar el rendimiento de consultas
- ✅ Implementar funciones, procedimientos y triggers

### 🔧 Administración DBA

- ✅ Configurar y gestionar instancias de PostgreSQL
- ✅ Implementar estrategias de backup y recuperación
- ✅ Gestionar seguridad, roles y permisos
- ✅ Configurar replicación y alta disponibilidad
- ✅ Monitorear y optimizar el rendimiento del servidor

---

## 📋 Requisitos Previos

- 🐳 Docker y Docker Compose instalados
- 💻 Terminal (bash, zsh, PowerShell)
- 🧠 Conocimientos básicos de programación (deseable, no obligatorio)
- ⏰ 4 horas semanales de dedicación
- 🔥 Ganas de aprender

---

## 🗓️ Plan de Estudios

### 📘 Bloque 1: Fundamentos SQL (Semanas 01-06)

| Semana | Tema                                      | Descripción                                       |
| :----: | ----------------------------------------- | ------------------------------------------------- |
| **01** | [Introducción a SQL](bootcamp/semana-01/) | Fundamentos de bases de datos y primeros comandos |
| **02** | DDL - Definición de Datos                 | CREATE, ALTER, DROP y tipos de datos              |
| **03** | DML - Manipulación Básica                 | INSERT, UPDATE, DELETE, SELECT básico             |
| **04** | Consultas Avanzadas                       | WHERE, ORDER BY, LIMIT, operadores                |
| **05** | JOINs                                     | Relaciones entre tablas y tipos de JOIN           |
| **06** | Agregaciones                              | GROUP BY, HAVING, funciones de agregación         |

### 📗 Bloque 2: SQL Avanzado (Semanas 07-09)

| Semana | Tema                | Descripción                           |
| :----: | ------------------- | ------------------------------------- |
| **07** | Consultas Complejas | Subconsultas, CTEs y vistas           |
| **08** | Optimización        | Índices, EXPLAIN ANALYZE, performance |
| **09** | Programación SQL    | Funciones, procedimientos y triggers  |

### 📙 Bloque 3: Administración DBA (Semanas 10-13)

| Semana | Tema                  | Descripción                                    |
| :----: | --------------------- | ---------------------------------------------- |
| **10** | Backup y Recuperación | pg_dump, pg_restore, PITR, WAL                 |
| **11** | Seguridad             | Roles, permisos, Row Level Security, auditoría |
| **12** | Replicación           | Streaming replication, alta disponibilidad     |
| **13** | Monitoreo y Tuning    | pg_stat, logs, postgresql.conf, mantenimiento  |

### 📕 Bloque 4: Proyecto Final (Semana 14)

| Semana | Tema                | Descripción                                      |
| :----: | ------------------- | ------------------------------------------------ |
| **14** | Proyecto Integrador | Aplicación completa: desarrollo + administración |

---

## 📁 Estructura del Repositorio

```
bc-postgresql/
├── 📂 _assets/          # Recursos gráficos generales
├── 📂 _docs/            # Documentación del bootcamp
├── 📂 _scripts/         # Scripts SQL de utilidad
└── 📂 bootcamp/
    └── 📂 semana-XX/
        ├── 📂 0-assets/       # Imágenes y diagramas
        ├── 📂 1-teoria/       # Material teórico
        ├── 📂 2-practica/     # Ejercicios guiados
        ├── 📂 3-ejercicios/   # Ejercicios para resolver
        ├── 📂 4-proyecto/     # Proyecto semanal
        ├── 📂 5-recursos/     # Material adicional
        ├── 📂 6-glosario/     # Términos y definiciones
        └── 📄 README.md       # Índice de la semana
```

---

## 🚀 Cómo Empezar

### 1. Clona el repositorio

```bash
git clone https://github.com/tu-usuario/bc-postgresql.git
cd bc-postgresql
```

### 2. Instala Docker

```bash
# Ubuntu/Debian
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER

# macOS: Descarga Docker Desktop desde https://www.docker.com/products/docker-desktop

# Windows: Descarga Docker Desktop desde https://www.docker.com/products/docker-desktop
```

### 3. Inicia el contenedor de PostgreSQL

```bash
# Levantar el entorno
docker compose up -d

# Verificar que está corriendo
docker ps

# Conectar a PostgreSQL
docker exec -it postgres-bootcamp psql -U bootcamp -d tienda_online
```

### 4. Verifica la instalación

```sql
-- Dentro de psql
SELECT version();
-- PostgreSQL 18.x
```

### 5. Comienza con la Semana 01

```bash
cd bootcamp/semana-01
```

---

## 📊 Metodología

Cada semana sigue una estructura consistente:

| Fase                   | Tiempo | Descripción             |
| ---------------------- | :----: | ----------------------- |
| 📚 **Teoría**          |   1h   | Conceptos y fundamentos |
| 💻 **Práctica Guiada** |   1h   | Ejercicios paso a paso  |
| 🔧 **Ejercicios**      |   1h   | Práctica individual     |
| 🚀 **Proyecto**        |   1h   | Aplicación integradora  |

---

## 🛠️ Herramientas Recomendadas

| Herramienta                               | Descripción               |
| ----------------------------------------- | ------------------------- |
| [pgAdmin 4](https://www.pgadmin.org/)     | Interfaz gráfica oficial  |
| [DBeaver](https://dbeaver.io/)            | Cliente universal de BD   |
| [VS Code](https://code.visualstudio.com/) | Editor con extensión SQL  |
| [TablePlus](https://tableplus.com/)       | Cliente moderno (Mac/Win) |

---

## 📖 Recursos Adicionales

- 📘 [Documentación Oficial PostgreSQL](https://www.postgresql.org/docs/)
- 🎥 [PostgreSQL Tutorial](https://www.postgresqltutorial.com/)
- 📝 [SQL Style Guide](https://www.sqlstyle.guide/)

---

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor, lee las [guías de contribución](_docs/CONTRIBUTING.md) antes de enviar un PR.

---

## 📄 Licencia

Este proyecto está bajo la licencia MIT. Ver el archivo [LICENSE](LICENSE) para más detalles.

---

<p align="center">
  <strong>Hecho con 🐘 para la comunidad</strong>
</p>
