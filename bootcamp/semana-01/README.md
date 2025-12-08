# 📘 Semana 01: Introducción a Bases de Datos y PostgreSQL

<p align="center">
  <img src="0-assets/diagrama-arquitectura-cliente-servidor.svg" alt="Arquitectura Cliente-Servidor" width="100%">
</p>

---

## 🎯 Objetivos de la Semana

Al finalizar esta semana serás capaz de:

- ✅ Comprender qué es una base de datos relacional
- ✅ Entender la arquitectura cliente-servidor de PostgreSQL
- ✅ Conectarte a PostgreSQL usando Docker
- ✅ Ejecutar tus primeras consultas SQL
- ✅ Navegar por la estructura de una base de datos

---

## 📚 Contenido

| Sección                        | Descripción                                | Tiempo |
| ------------------------------ | ------------------------------------------ | :----: |
| [1. Teoría](1-teoria/)         | Fundamentos de bases de datos              |   1h   |
| [2. Práctica](2-practica/)     | Configuración del entorno y primeros pasos |   1h   |
| [3. Ejercicios](3-ejercicios/) | Práctica individual                        |   1h   |
| [4. Proyecto](4-proyecto/)     | Mini-proyecto integrador                   |   1h   |

---

## 🗂️ Estructura de la Semana

```
semana-01/
├── 0-assets/                    # Diagramas e imágenes
├── 1-teoria/
│   ├── 01-que-es-base-datos.md  # Conceptos fundamentales
│   ├── 02-postgresql-intro.md   # Introducción a PostgreSQL
│   └── 03-arquitectura.md       # Arquitectura cliente-servidor
├── 2-practica/
│   ├── 01-docker-setup.md       # Configuración Docker
│   ├── 02-primera-conexion.md   # Conectarse a PostgreSQL
│   └── 03-comandos-basicos.md   # Comandos esenciales
├── 3-ejercicios/
│   ├── ejercicios.md            # Lista de ejercicios
│   └── soluciones.md            # Soluciones (spoiler!)
├── 4-proyecto/
│   └── proyecto-semana-01.md    # Proyecto integrador
├── 5-recursos/
│   └── recursos.md              # Enlaces y material extra
├── 6-glosario/
│   └── glosario.md              # Términos de la semana
└── README.md                    # Este archivo
```

---

## 🔑 Conceptos Clave

| Término           | Definición                                        |
| ----------------- | ------------------------------------------------- |
| **Base de datos** | Colección organizada de datos estructurados       |
| **RDBMS**         | Sistema de gestión de bases de datos relacionales |
| **SQL**           | Lenguaje estándar para consultar bases de datos   |
| **PostgreSQL**    | Sistema de BD relacional open source              |
| **Tabla**         | Estructura que almacena datos en filas y columnas |
| **Consulta**      | Instrucción SQL para interactuar con datos        |

---

## ⏱️ Distribución del Tiempo (4 horas)

```
📚 Teoría ████████░░░░░░░░ 1h (25%)
💻 Práctica ████████░░░░░░░░ 1h (25%)
🔧 Ejercicios ████████░░░░░░░░ 1h (25%)
🚀 Proyecto ████████░░░░░░░░ 1h (25%)
```

---

## 🚀 Inicio Rápido

### 1. Levanta el entorno

```bash
cd /ruta/a/bc-postgresql
docker compose up -d
```

### 2. Conéctate a PostgreSQL

```bash
docker exec -it postgres-bootcamp psql -U bootcamp -d tienda_online
```

### 3. Tu primera consulta

```sql
SELECT version();
```

---

## ✅ Checklist de Progreso

- [ ] Leí el material teórico
- [ ] Configuré Docker correctamente
- [ ] Me conecté a PostgreSQL
- [ ] Ejecuté mis primeras consultas
- [ ] Completé los ejercicios
- [ ] Terminé el proyecto semanal

---

## 📖 Navegación

| ⬅️ Anterior |          🏠 Inicio          |        Siguiente ➡️        |
| :---------: | :-------------------------: | :------------------------: |
|      -      | [Bootcamp](../../README.md) | [Semana 02](../semana-02/) |
