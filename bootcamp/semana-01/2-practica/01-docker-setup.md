# 🐳 Configuración del Entorno Docker

## 🎯 Objetivo

Configurar el entorno de desarrollo usando Docker para trabajar con PostgreSQL 18 de forma aislada y reproducible.

---

## 📋 Requisitos Previos

Antes de comenzar, asegúrate de tener:

- ✅ Docker instalado ([Guía de instalación](https://docs.docker.com/get-docker/))
- ✅ Docker Compose instalado
- ✅ Terminal (bash, zsh, PowerShell)
- ✅ 2GB de espacio en disco

### Verificar Docker

```bash
# Verificar Docker
docker --version
# Docker version 24.x o superior

# Verificar Docker Compose
docker compose version
# Docker Compose version v2.x
```

---

## 🚀 Levantar el Entorno

### Paso 1: Navegar al proyecto

```bash
cd /ruta/a/bc-postgresql
```

### Paso 2: Revisar docker-compose.yml

El archivo `docker-compose.yml` en la raíz del proyecto contiene:

```yaml
services:
  postgres:
    image: postgres:18-alpine # Imagen liviana (~80MB)
    container_name: postgres-bootcamp
    ports:
      - '5432:5432' # Puerto expuesto
    environment:
      POSTGRES_USER: bootcamp # Usuario
      POSTGRES_PASSWORD: bootcamp123 # Contraseña
      POSTGRES_DB: tienda_online # Base de datos
    volumes:
      - postgres_data:/var/lib/postgresql/data
```

### Paso 3: Iniciar el contenedor

```bash
# Levantar en segundo plano
docker compose up -d

# Salida esperada:
# ✔ Container postgres-bootcamp  Started
```

### Paso 4: Verificar que está corriendo

```bash
docker ps

# Salida esperada:
# CONTAINER ID   IMAGE              STATUS         PORTS                    NAMES
# abc123...      postgres:18-alpine Up 10 seconds  0.0.0.0:5432->5432/tcp   postgres-bootcamp
```

---

## 🔍 Comandos Docker Esenciales

### Ver logs del contenedor

```bash
# Logs en tiempo real
docker logs -f postgres-bootcamp

# Últimas 50 líneas
docker logs --tail 50 postgres-bootcamp
```

### Detener el contenedor

```bash
docker compose down
```

### Reiniciar el contenedor

```bash
docker compose restart
```

### Eliminar datos (reset completo)

```bash
# ⚠️ CUIDADO: Esto elimina todos los datos
docker compose down -v
docker compose up -d
```

---

## 🔌 Conectarse a PostgreSQL

### Opción 1: Desde el contenedor (recomendado para empezar)

```bash
docker exec -it postgres-bootcamp psql -U bootcamp -d tienda_online
```

### Opción 2: Desde tu máquina (requiere psql instalado)

```bash
psql -h localhost -p 5432 -U bootcamp -d tienda_online
# Contraseña: bootcamp123
```

### Opción 3: Usando pgAdmin (interfaz gráfica)

```bash
# Levantar PostgreSQL + pgAdmin
docker compose --profile tools up -d

# Acceder en el navegador:
# http://localhost:8080
# Email: admin@bootcamp.local
# Password: admin123
```

---

## 📊 Verificar la Instalación

Una vez conectado a psql, ejecuta:

```sql
-- Ver versión de PostgreSQL
SELECT version();

-- Salida esperada:
-- PostgreSQL 18.x on x86_64-pc-linux-musl, compiled by gcc...

-- Ver base de datos actual
SELECT current_database();

-- Salida esperada:
-- tienda_online

-- Ver usuario actual
SELECT current_user;

-- Salida esperada:
-- bootcamp
```

---

## 🗄️ Datos Iniciales

El script `_scripts/init/01_init_database.sql` se ejecuta automáticamente al crear el contenedor y crea:

| Tabla             | Descripción             | Registros |
| ----------------- | ----------------------- | :-------: |
| `categorias`      | Categorías de productos |     5     |
| `productos`       | Catálogo de productos   |    10     |
| `clientes`        | Información de clientes |     5     |
| `pedidos`         | Pedidos realizados      |     0     |
| `detalle_pedidos` | Líneas de pedidos       |     0     |

### Verificar tablas creadas

```sql
-- Listar tablas
\dt

-- Salida esperada:
--              List of relations
--  Schema |      Name        | Type  |  Owner
-- --------+------------------+-------+----------
--  public | categorias       | table | bootcamp
--  public | clientes         | table | bootcamp
--  public | detalle_pedidos  | table | bootcamp
--  public | pedidos          | table | bootcamp
--  public | productos        | table | bootcamp
```

---

## ⚠️ Solución de Problemas

### El puerto 5432 está ocupado

```bash
# Ver qué usa el puerto
sudo lsof -i :5432

# Cambiar puerto en docker-compose.yml:
ports:
  - "5433:5432"  # Usar 5433 en tu máquina
```

### El contenedor no inicia

```bash
# Ver logs de error
docker logs postgres-bootcamp

# Reiniciar desde cero
docker compose down -v
docker compose up -d
```

### No puedo conectarme

Verifica:

1. ¿El contenedor está corriendo? (`docker ps`)
2. ¿Usas las credenciales correctas?
3. ¿El puerto está correcto?

---

## ✅ Checklist

- [ ] Docker y Docker Compose instalados
- [ ] Contenedor `postgres-bootcamp` corriendo
- [ ] Conexión exitosa con psql
- [ ] Tablas iniciales creadas
- [ ] Consulta `SELECT version()` funciona

---

## 📖 Navegación

|                  ⬅️ Anterior                   |                Siguiente ➡️                |
| :--------------------------------------------: | :----------------------------------------: |
| [Arquitectura](../1-teoria/03-arquitectura.md) | [Primera Conexión](02-primera-conexion.md) |
