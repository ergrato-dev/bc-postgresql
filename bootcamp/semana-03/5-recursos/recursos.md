# 📖 Recursos: Semana 03 - DML

## 📚 Documentación Oficial

### PostgreSQL

- [INSERT](https://www.postgresql.org/docs/current/sql-insert.html) - Documentación completa del comando INSERT
- [UPDATE](https://www.postgresql.org/docs/current/sql-update.html) - Referencia del comando UPDATE
- [DELETE](https://www.postgresql.org/docs/current/sql-delete.html) - Referencia del comando DELETE
- [SELECT](https://www.postgresql.org/docs/current/sql-select.html) - Referencia completa de SELECT
- [RETURNING Clause](https://www.postgresql.org/docs/current/dml-returning.html) - Uso de RETURNING en DML

---

## 📖 Tutoriales Recomendados

### Nivel Básico

| Recurso             | Descripción                         | Link                                                          |
| ------------------- | ----------------------------------- | ------------------------------------------------------------- |
| PostgreSQL Tutorial | Tutorial completo de DML            | [postgresqltutorial.com](https://www.postgresqltutorial.com/) |
| W3Schools SQL       | Ejemplos interactivos básicos       | [w3schools.com/sql](https://www.w3schools.com/sql/)           |
| SQLBolt             | Ejercicios interactivos paso a paso | [sqlbolt.com](https://sqlbolt.com/)                           |

### Nivel Intermedio

| Recurso        | Descripción                     | Link                                                    |
| -------------- | ------------------------------- | ------------------------------------------------------- |
| Mode Analytics | Tutorial avanzado de SQL        | [mode.com/sql-tutorial](https://mode.com/sql-tutorial/) |
| PGEXERCISES    | Ejercicios prácticos PostgreSQL | [pgexercises.com](https://pgexercises.com/)             |
| SQL Zoo        | Tutoriales interactivos         | [sqlzoo.net](https://sqlzoo.net/)                       |

---

## 🎥 Videos Recomendados

### En Español

| Tema               | Canal                 | Duración |
| ------------------ | --------------------- | -------- |
| CRUD en PostgreSQL | Fazt Code             | ~30 min  |
| DML Completo       | Código Facilito       | ~45 min  |
| Transacciones SQL  | Píldoras Informáticas | ~20 min  |

### En Inglés

| Tema             | Canal            | Duración |
| ---------------- | ---------------- | -------- |
| PostgreSQL CRUD  | Traversy Media   | ~40 min  |
| Advanced INSERT  | Hussein Nasser   | ~25 min  |
| UPSERT Explained | Learn PostgreSQL | ~15 min  |

---

## 🔧 Herramientas

### Clientes SQL

| Herramienta      | Plataforma      | Características               |
| ---------------- | --------------- | ----------------------------- |
| pgAdmin 4        | Multiplataforma | Cliente oficial PostgreSQL    |
| DBeaver          | Multiplataforma | Multi-base de datos, gratuito |
| DataGrip         | Multiplataforma | IDE profesional de JetBrains  |
| Beekeeper Studio | Multiplataforma | Moderno, interfaz limpia      |

### Extensiones VS Code

| Extensión       | Descripción                       |
| --------------- | --------------------------------- |
| PostgreSQL      | Explorador y ejecución de queries |
| SQLTools        | Multi-base de datos               |
| Database Client | Cliente completo integrado        |

---

## 📘 Libros Recomendados

### Para esta semana

| Libro                   | Autor           | Capítulos Relevantes      |
| ----------------------- | --------------- | ------------------------- |
| PostgreSQL Up & Running | Regina Obe      | Cap. 5: Data Manipulation |
| Learning PostgreSQL     | Salahaldin Juba | Cap. 4: Manipulating Data |
| Practical PostgreSQL    | Joshua Drake    | Cap. 6: DML Statements    |

### Referencia General

| Libro                        | Descripción                     |
| ---------------------------- | ------------------------------- |
| The Art of PostgreSQL        | Técnicas avanzadas y patrones   |
| PostgreSQL 14 Administration | Guía completa de administración |

---

## 🔗 Cheat Sheets

### INSERT

```sql
-- Simple
INSERT INTO tabla (col1, col2) VALUES (val1, val2);

-- Múltiple
INSERT INTO tabla (col1, col2) VALUES
    (val1, val2),
    (val3, val4);

-- Desde SELECT
INSERT INTO tabla (col1, col2)
SELECT col1, col2 FROM otra_tabla;

-- Con RETURNING
INSERT INTO tabla (col1) VALUES (val1) RETURNING id;

-- UPSERT
INSERT INTO tabla (col1) VALUES (val1)
ON CONFLICT (col1) DO UPDATE SET col2 = EXCLUDED.col2;
```

### UPDATE

```sql
-- Simple
UPDATE tabla SET col1 = val1 WHERE condicion;

-- Múltiples columnas
UPDATE tabla SET col1 = val1, col2 = val2 WHERE condicion;

-- Con expresión
UPDATE tabla SET col1 = col1 * 1.10 WHERE condicion;

-- Con CASE
UPDATE tabla SET col1 = CASE
    WHEN condicion1 THEN valor1
    WHEN condicion2 THEN valor2
END;

-- Desde otra tabla
UPDATE tabla1 SET col1 = tabla2.col1
FROM tabla2 WHERE tabla1.id = tabla2.id;
```

### DELETE

```sql
-- Simple
DELETE FROM tabla WHERE condicion;

-- Con subconsulta
DELETE FROM tabla
WHERE id IN (SELECT id FROM otra_tabla);

-- Eliminar todo
DELETE FROM tabla;  -- o TRUNCATE TABLE tabla;

-- Con RETURNING
DELETE FROM tabla WHERE condicion RETURNING *;
```

### SELECT (Básico)

```sql
-- Columnas específicas
SELECT col1, col2 FROM tabla;

-- Con alias
SELECT col1 AS nombre_legible FROM tabla;

-- Filtrado
SELECT * FROM tabla WHERE col1 = 'valor';

-- Ordenamiento
SELECT * FROM tabla ORDER BY col1 DESC;

-- Límite
SELECT * FROM tabla LIMIT 10 OFFSET 20;

-- Distintos
SELECT DISTINCT col1 FROM tabla;
```

---

## 🔬 Laboratorios Online

| Plataforma  | Descripción               | Link                                            |
| ----------- | ------------------------- | ----------------------------------------------- |
| DB Fiddle   | Sandbox PostgreSQL online | [db-fiddle.com](https://www.db-fiddle.com/)     |
| SQL Fiddle  | Editor SQL en navegador   | [sqlfiddle.com](http://sqlfiddle.com/)          |
| Supabase    | PostgreSQL cloud gratuito | [supabase.com](https://supabase.com/)           |
| ElephantSQL | PostgreSQL as a Service   | [elephantsql.com](https://www.elephantsql.com/) |

---

## 📱 Apps Móviles

| App       | Plataforma  | Uso                      |
| --------- | ----------- | ------------------------ |
| SoloLearn | iOS/Android | Ejercicios SQL básicos   |
| DataCamp  | iOS/Android | Cursos interactivos      |
| Enki      | iOS/Android | Lecciones diarias breves |

---

## 🎮 Práctica Gamificada

| Plataforma        | Tipo              | Nivel               |
| ----------------- | ----------------- | ------------------- |
| HackerRank SQL    | Desafíos          | Básico-Avanzado     |
| LeetCode Database | Problemas         | Intermedio-Avanzado |
| Codewars SQL      | Katas             | Todos los niveles   |
| StrataScratch     | Ejercicios reales | Intermedio          |

---

## 📌 Tips de la Semana

### 1. Seguridad en DELETE/UPDATE

```sql
-- SIEMPRE usa WHERE
-- NUNCA ejecutes DELETE/UPDATE sin probar primero con SELECT

-- ❌ Malo
DELETE FROM productos;

-- ✅ Bueno
-- Primero: SELECT * FROM productos WHERE stock = 0;
-- Después: DELETE FROM productos WHERE stock = 0;
```

### 2. Usa RETURNING

```sql
-- Confirma lo que modificaste
UPDATE productos
SET precio = precio * 1.10
WHERE categoria_id = 1
RETURNING id, nombre, precio;
```

### 3. Transacciones

```sql
-- Para operaciones múltiples
BEGIN;
  -- operaciones
COMMIT;  -- o ROLLBACK si algo falla
```

---

## 📖 Navegación

|                   ⬅️ Proyecto                   |      🏠 Semana 03      |             Siguiente ➡️              |
| :---------------------------------------------: | :--------------------: | :-----------------------------------: |
| [Proyecto](../4-proyecto/proyecto-semana-03.md) | [README](../README.md) | [Glosario](../6-glosario/glosario.md) |
