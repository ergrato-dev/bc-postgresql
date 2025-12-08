# Copilot Instructions - Bootcamp PostgreSQL

## Descripción del Proyecto

Este es un bootcamp "Zero to Hero" de PostgreSQL 18 diseñado para 14 semanas con 4 horas de dedicación semanal (56 horas totales). Cubre tanto **desarrollo SQL** como **administración de bases de datos (DBA)**. Toda la práctica se realiza en contenedores Docker con imágenes Alpine (livianas).

## Estructura del Proyecto

```
bc-postgresql/
├── .github/                    # Configuración de GitHub y Copilot
├── _assets/                    # Assets generales del proyecto (banners, iconos, imágenes)
├── _docs/                      # Documentación general del bootcamp
├── _scripts/                   # Scripts SQL de utilidad general
├── bootcamp/
│   └── semana-XX/              # Contenido por semana (01-14)
│       ├── 0-assets/           # Assets específicos de la semana
│       ├── 1-teoria/           # Material teórico (markdown, diagramas)
│       ├── 2-practica/         # Ejercicios guiados paso a paso
│       ├── 3-ejercicios/       # Ejercicios para resolver
│       ├── 4-proyecto/         # Proyecto semanal integrador
│       ├── 5-recursos/         # Links, referencias, material adicional
│       ├── 6-glosario/         # Términos y definiciones de la semana
│       ├── README.md           # Índice y objetivos de la semana
│       └── rubrica-evaluacion.md # Criterios de evaluación
└── README.md                   # README principal del bootcamp
```

## Convenciones de Código

### Archivos SQL

- Usar extensión `.sql` para todos los scripts
- Nombres en `snake_case` y en español: `crear_tabla_usuarios.sql`
- Incluir comentarios descriptivos al inicio de cada archivo
- Usar mayúsculas para palabras reservadas SQL: `SELECT`, `FROM`, `WHERE`
- Indentar con 2 espacios

```sql
-- Descripción: Crea la tabla de usuarios
-- Autor: Bootcamp PostgreSQL
-- Fecha: YYYY-MM-DD

CREATE TABLE usuarios (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Archivos Markdown

- Usar español para todo el contenido
- Títulos descriptivos y concisos
- Incluir ejemplos de código con bloques ```sql
- Usar emojis para mejorar la legibilidad donde sea apropiado

### Nomenclatura de Archivos

- Markdown: `kebab-case.md` → `introduccion-sql.md`
- SQL: `snake_case.sql` → `crear_base_datos.sql`
- Assets: `kebab-case` → `diagrama-er.svg`

## Estilo Visual

- **Tema**: Dark mode
- **Colores principales**:
  - PostgreSQL Blue: `#336791`
  - Background: `#1a1a2e`
  - Text: `#eaeaea`
  - Accent: `#4a9fff`
- **Fuentes**: Sans-serif (system-ui, Arial, Helvetica)
- **Sin degradados**: Colores sólidos únicamente
- **Iconografía**: Minimalista y plana

## Assets (SVG)

Al crear assets SVG:

- Usar colores sólidos, sin gradientes
- Fondo oscuro (`#1a1a2e` o `#0d1117`)
- Texto en fuentes sans-serif
- Optimizar para visualización en GitHub (dark mode)
- Dimensiones recomendadas para banners: 1200x300

## Contenido por Semana

### Bloque 1: Fundamentos SQL (Semanas 01-06)

| Semana | Tema Principal                             |
| ------ | ------------------------------------------ |
| 01     | Introducción a bases de datos y PostgreSQL |
| 02     | DDL: CREATE, ALTER, DROP - Tipos de datos  |
| 03     | DML: INSERT, UPDATE, DELETE, SELECT básico |
| 04     | SELECT avanzado: WHERE, ORDER BY, LIMIT    |
| 05     | JOINs y relaciones entre tablas            |
| 06     | Funciones de agregación, GROUP BY, HAVING  |

### Bloque 2: SQL Avanzado (Semanas 07-09)

| Semana | Tema Principal                          |
| ------ | --------------------------------------- |
| 07     | Subconsultas, CTEs y vistas             |
| 08     | Índices, optimización y EXPLAIN ANALYZE |
| 09     | Funciones, procedimientos y triggers    |

### Bloque 3: Administración DBA (Semanas 10-13)

| Semana | Tema Principal                         |
| ------ | -------------------------------------- |
| 10     | Backup, restore y recuperación (PITR)  |
| 11     | Seguridad: roles, permisos y auditoría |
| 12     | Replicación y alta disponibilidad      |
| 13     | Monitoreo, tuning y mantenimiento      |

### Bloque 4: Proyecto Final (Semana 14)

| Semana | Tema Principal                        |
| ------ | ------------------------------------- |
| 14     | Proyecto final integrador (Dev + DBA) |

## Reglas para Copilot

1. **Idioma**: Generar todo el contenido en español
2. **Ejemplos**: Usar datos de ejemplo realistas y en español
3. **Comentarios**: Incluir comentarios explicativos en código SQL
4. **Progresión**: Respetar el nivel de dificultad según la semana
5. **Consistencia**: Mantener el mismo estilo en todo el bootcamp
6. **Práctica**: Priorizar ejercicios prácticos sobre teoría extensa
7. **PostgreSQL**: Usar sintaxis específica de PostgreSQL, no SQL genérico

## Base de Datos de Ejemplo

Para ejercicios, usar un esquema de ejemplo consistente:

```sql
-- Esquema: tienda_online
-- Tablas: productos, categorias, clientes, pedidos, detalle_pedidos
```

## Docker

Toda la práctica del bootcamp se realiza en contenedores Docker:

```yaml
# Imagen oficial Alpine (liviana ~80MB)
image: postgres:18-alpine

# Variables de entorno estándar
environment:
  POSTGRES_USER: bootcamp
  POSTGRES_PASSWORD: bootcamp123
  POSTGRES_DB: tienda_online
```

### Comandos Docker frecuentes

```bash
# Iniciar contenedor
docker compose up -d

# Conectar a PostgreSQL
docker exec -it postgres-bootcamp psql -U bootcamp -d tienda_online

# Detener contenedor
docker compose down
```

## Emojis Recomendados

- 🐘 PostgreSQL
- 🐳 Docker
- 📚 Teoría
- 💻 Práctica
- 🎯 Objetivos
- ⚠️ Advertencias
- 💡 Tips
- ✅ Completado
- 🔧 Ejercicios
- 🚀 Proyecto
- 📖 Recursos
