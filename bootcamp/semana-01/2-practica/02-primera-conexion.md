# 🔌 Primera Conexión a PostgreSQL

## 🎯 Objetivo

Aprender a conectarse a PostgreSQL y familiarizarse con el cliente de línea de comandos `psql`.

---

## 🖥️ ¿Qué es psql?

**psql** es el cliente interactivo de línea de comandos oficial de PostgreSQL. Permite:

- Ejecutar consultas SQL
- Ver estructura de bases de datos
- Importar/exportar datos
- Administrar el servidor

---

## 🚀 Conectarse a PostgreSQL

### Conexión desde Docker

```bash
docker exec -it postgres-bootcamp psql -U bootcamp -d tienda_online
```

**Desglose del comando:**

| Parte               | Significado                    |
| ------------------- | ------------------------------ |
| `docker exec`       | Ejecutar comando en contenedor |
| `-it`               | Modo interactivo con terminal  |
| `postgres-bootcamp` | Nombre del contenedor          |
| `psql`              | Cliente PostgreSQL             |
| `-U bootcamp`       | Usuario                        |
| `-d tienda_online`  | Base de datos                  |

### Prompt de psql

Una vez conectado, verás:

```
tienda_online=#
```

| Símbolo         | Significado          |
| --------------- | -------------------- |
| `tienda_online` | Base de datos actual |
| `=`             | Listo para comando   |
| `#`             | Usuario superuser    |
| `>`             | Usuario regular      |

---

## 📝 Tu Primera Consulta

### Consulta simple

```sql
SELECT 'Hola, PostgreSQL!' AS saludo;
```

**Resultado:**

```
      saludo
------------------
 Hola, PostgreSQL!
(1 row)
```

### Ver versión del servidor

```sql
SELECT version();
```

### Ver fecha y hora actual

```sql
SELECT NOW();
```

### Operaciones matemáticas

```sql
SELECT 2 + 2 AS suma, 10 * 5 AS producto, 100 / 4 AS division;
```

---

## 🔧 Comandos Meta de psql

Los comandos que empiezan con `\` son **comandos meta** de psql (no son SQL):

### Información General

| Comando     | Descripción                |
| ----------- | -------------------------- |
| `\?`        | Ayuda de comandos psql     |
| `\h`        | Ayuda de comandos SQL      |
| `\h SELECT` | Ayuda específica de SELECT |

### Navegación

| Comando           | Descripción              |
| ----------------- | ------------------------ |
| `\l`              | Listar bases de datos    |
| `\c nombre_bd`    | Cambiar de base de datos |
| `\dt`             | Listar tablas            |
| `\d nombre_tabla` | Describir tabla          |
| `\dn`             | Listar schemas           |
| `\du`             | Listar usuarios/roles    |

### Ejemplo Práctico

```sql
-- Listar todas las bases de datos
\l

-- Cambiar a otra base de datos
\c postgres

-- Volver a tienda_online
\c tienda_online

-- Ver todas las tablas
\dt

-- Ver estructura de la tabla productos
\d productos
```

---

## 📊 Explorando los Datos

### Ver categorías

```sql
SELECT * FROM categorias;
```

**Resultado:**

```
 id |    nombre    |              descripcion
----+--------------+----------------------------------------
  1 | Electrónica  | Dispositivos electrónicos y gadgets
  2 | Ropa         | Vestimenta y accesorios
  3 | Hogar        | Artículos para el hogar
  4 | Deportes     | Equipamiento deportivo
  5 | Libros       | Libros y material de lectura
(5 rows)
```

### Ver productos

```sql
SELECT id, nombre, precio FROM productos;
```

### Ver clientes

```sql
SELECT nombre, apellido, ciudad FROM clientes;
```

---

## 🎨 Formato de Salida

### Cambiar formato de visualización

```sql
-- Formato expandido (vertical)
\x on
SELECT * FROM productos LIMIT 1;

-- Volver a formato normal
\x off
```

### Alinear salida

```sql
-- Activar alineación
\a

-- Desactivar bordes
\t
```

---

## 📤 Salir de psql

```sql
-- Cualquiera de estos comandos:
\q
-- o
exit
-- o
quit
-- o presiona Ctrl+D
```

---

## 💡 Tips Útiles

### Historial de comandos

- ⬆️ **Flecha arriba**: Comando anterior
- ⬇️ **Flecha abajo**: Comando siguiente
- **Ctrl+R**: Buscar en historial

### Autocompletado

- **Tab**: Autocompletar nombres de tablas, columnas, etc.

### Consultas multilínea

```sql
SELECT
    id,
    nombre,
    precio
FROM
    productos
WHERE
    precio > 50;
```

El `;` al final indica el fin de la consulta.

### Cancelar comando

- **Ctrl+C**: Cancela el comando actual

---

## 🔍 Información del Sistema

### Variables de conexión

```sql
-- Base de datos actual
SELECT current_database();

-- Usuario actual
SELECT current_user;

-- Directorio de datos
SHOW data_directory;

-- Configuración de encoding
SHOW server_encoding;

-- Zona horaria
SHOW timezone;
```

---

## ✅ Ejercicio de Verificación

Ejecuta estos comandos y verifica que funcionan:

```sql
-- 1. Ver versión
SELECT version();

-- 2. Listar tablas
\dt

-- 3. Contar productos
SELECT COUNT(*) FROM productos;

-- 4. Ver un producto
SELECT * FROM productos WHERE id = 1;

-- 5. Operación matemática
SELECT 100 * 1.21 AS precio_con_iva;
```

---

## 📖 Navegación

|            ⬅️ Anterior             |                Siguiente ➡️                |
| :--------------------------------: | :----------------------------------------: |
| [Docker Setup](01-docker-setup.md) | [Comandos Básicos](03-comandos-basicos.md) |
