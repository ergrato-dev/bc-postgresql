# 📚 Glosario - Semana 01

## 🎯 Términos y Definiciones

Glosario de términos técnicos introducidos en la Semana 01.

---

## A

### ACID

Acrónimo de las propiedades que garantizan transacciones confiables:

- **A**tomicity (Atomicidad)
- **C**onsistency (Consistencia)
- **I**solation (Aislamiento)
- **D**urability (Durabilidad)

### Alias

Nombre alternativo temporal asignado a una columna o tabla en una consulta SQL.

```sql
SELECT nombre AS producto FROM productos;
```

---

## B

### Backend (PostgreSQL)

Proceso del servidor que maneja una conexión individual de cliente.

### Base de datos

Colección organizada de datos estructurados almacenados electrónicamente.

---

## C

### Celda

Intersección de una fila y una columna en una tabla. Contiene un valor único.

### Cliente

Aplicación que se conecta al servidor de base de datos (psql, pgAdmin, aplicación).

### Cluster

En PostgreSQL, instancia del servidor que contiene una o más bases de datos.

### Columna

Atributo vertical en una tabla que define un tipo específico de dato.

### Consulta (Query)

Instrucción SQL enviada al servidor para obtener o modificar datos.

---

## D

### DDL (Data Definition Language)

Comandos SQL para definir estructuras: `CREATE`, `ALTER`, `DROP`.

### DML (Data Manipulation Language)

Comandos SQL para manipular datos: `INSERT`, `UPDATE`, `DELETE`, `SELECT`.

### Docker

Plataforma de contenedores que permite ejecutar aplicaciones en entornos aislados.

### Docker Compose

Herramienta para definir y ejecutar aplicaciones Docker multi-contenedor.

---

## E

### Esquema (Schema)

Namespace que agrupa objetos de base de datos (tablas, vistas, funciones).

### Executor

Componente de PostgreSQL que ejecuta el plan de consulta y accede a los datos.

---

## F

### Fila (Row)

Registro horizontal en una tabla que representa una instancia de datos.

### Foreign Key (Clave Foránea)

Columna que referencia la clave primaria de otra tabla, creando una relación.

---

## I

### ILIKE

Operador de PostgreSQL similar a LIKE pero insensible a mayúsculas/minúsculas.

### Índice

Estructura de datos que mejora la velocidad de recuperación de registros.

---

## L

### LIKE

Operador SQL para buscar patrones en texto usando comodines (% y \_).

### LIMIT

Cláusula SQL que restringe el número de filas devueltas.

---

## M

### MVCC (Multi-Version Concurrency Control)

Sistema que permite múltiples transacciones simultáneas sin bloqueos.

---

## N

### NULL

Valor especial que representa la ausencia de dato. No es igual a cero ni a cadena vacía.

---

## O

### OFFSET

Cláusula SQL que salta un número de filas antes de devolver resultados.

### ORDER BY

Cláusula SQL que ordena los resultados por una o más columnas.

### ORDBMS

Object-Relational Database Management System. PostgreSQL es un ORDBMS.

---

## P

### Parser

Componente que analiza la sintaxis de una consulta SQL.

### Planner

Componente que genera el plan de ejecución óptimo para una consulta.

### Postmaster

Proceso principal de PostgreSQL que gestiona conexiones entrantes.

### Primary Key (Clave Primaria)

Columna o conjunto de columnas que identifica únicamente cada fila.

### psql

Cliente de línea de comandos oficial de PostgreSQL.

---

## Q

### Query (Consulta)

Ver "Consulta".

---

## R

### RDBMS

Relational Database Management System. Sistema de gestión de bases de datos relacionales.

### Registro

Ver "Fila".

---

## S

### Schema

Ver "Esquema".

### SELECT

Comando SQL fundamental para consultar datos de una o más tablas.

### Servidor

Proceso que gestiona el almacenamiento, procesamiento y acceso a datos.

### SQL

Structured Query Language. Lenguaje estándar para interactuar con bases de datos relacionales.

---

## T

### Tabla

Estructura que organiza datos en filas y columnas dentro de una base de datos.

### Transacción

Unidad de trabajo que agrupa operaciones SQL, garantizando propiedades ACID.

---

## W

### WAL (Write-Ahead Logging)

Sistema de logging que registra cambios antes de escribirlos en disco, asegurando durabilidad.

### WHERE

Cláusula SQL que filtra filas según condiciones especificadas.

---

## Símbolos y Operadores

|   Símbolo   | Nombre        | Uso                                            |
| :---------: | ------------- | ---------------------------------------------- |
|     `*`     | Asterisco     | Seleccionar todas las columnas                 |
|     `%`     | Porcentaje    | Comodín LIKE: cualquier cantidad de caracteres |
|     `_`     | Guion bajo    | Comodín LIKE: un solo carácter                 |
|     `=`     | Igual         | Comparación de igualdad                        |
| `<>` / `!=` | Diferente     | Comparación de desigualdad                     |
|     `>`     | Mayor que     | Comparación numérica                           |
|     `<`     | Menor que     | Comparación numérica                           |
|    `>=`     | Mayor o igual | Comparación numérica                           |
|    `<=`     | Menor o igual | Comparación numérica                           |
|   `\|\|`    | Doble pipe    | Concatenación de texto                         |
|     `;`     | Punto y coma  | Fin de sentencia SQL                           |

---

## 📖 Navegación

|              ⬅️ Anterior              |      🏠 Semana 01      |         Siguiente ➡️          |
| :-----------------------------------: | :--------------------: | :---------------------------: |
| [Recursos](../5-recursos/recursos.md) | [README](../README.md) | [Semana 02](../../semana-02/) |
