# 📚 Glosario: Semana 02 - DDL

## A

### ALTER TABLE

Comando DDL que modifica la estructura de una tabla existente. Permite agregar, modificar o eliminar columnas y constraints.

```sql
ALTER TABLE usuarios ADD COLUMN edad INTEGER;
```

### ARRAY

Tipo de dato que almacena un arreglo de valores del mismo tipo.

```sql
tags TEXT[] DEFAULT ARRAY['nuevo']
```

### Auto-incremento

Característica que genera valores secuenciales automáticamente. En PostgreSQL se implementa con SERIAL o IDENTITY.

---

## B

### BIGINT

Tipo de dato entero de 8 bytes que almacena valores de -9,223,372,036,854,775,808 a 9,223,372,036,854,775,807.

### BIGSERIAL

Tipo de dato autoincremental basado en BIGINT. Crea automáticamente una secuencia.

### BOOLEAN

Tipo de dato que almacena valores TRUE, FALSE o NULL.

---

## C

### CASCADE

Opción que propaga automáticamente una acción (DELETE/UPDATE) a las filas dependientes.

```sql
ON DELETE CASCADE  -- Elimina filas hijas
```

### CHAR(n)

Tipo de dato de texto con longitud fija. Rellena con espacios hasta alcanzar n caracteres.

### CHECK

Restricción que valida que los datos cumplan una condición específica.

```sql
CHECK (precio > 0 AND precio < 99999)
```

### Constraint

Restricción aplicada a una columna o tabla para garantizar la integridad de los datos.

### CREATE TABLE

Comando DDL que crea una nueva tabla en la base de datos.

---

## D

### DATA DEFINITION LANGUAGE (DDL)

Subconjunto de SQL usado para definir y modificar estructuras de base de datos: CREATE, ALTER, DROP, TRUNCATE.

### DATE

Tipo de dato que almacena solo la fecha (sin hora). Formato: YYYY-MM-DD.

### DECIMAL(p,s)

Tipo numérico de precisión exacta. p = dígitos totales, s = dígitos decimales.

```sql
precio DECIMAL(10,2)  -- Hasta 99999999.99
```

### DEFAULT

Valor que se asigna automáticamente a una columna cuando no se especifica uno.

```sql
activo BOOLEAN DEFAULT TRUE
```

### DOUBLE PRECISION

Tipo de dato de punto flotante de 8 bytes con aproximadamente 15 dígitos de precisión.

### DROP TABLE

Comando DDL que elimina permanentemente una tabla y sus datos.

---

## E

### ENUM

Tipo de dato que define un conjunto de valores permitidos.

```sql
CREATE TYPE estado AS ENUM ('activo', 'inactivo');
```

---

## F

### FOREIGN KEY (FK)

Restricción que establece una relación entre dos tablas, garantizando integridad referencial.

```sql
FOREIGN KEY (cliente_id) REFERENCES clientes(id)
```

---

## G

### GENERATED ALWAYS AS

Columna calculada automáticamente a partir de otras columnas.

```sql
subtotal DECIMAL GENERATED ALWAYS AS (cantidad * precio) STORED
```

---

## I

### IDENTITY

Forma moderna (PostgreSQL 10+) de crear columnas autoincrementales.

```sql
id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY
```

### IF EXISTS / IF NOT EXISTS

Cláusulas que evitan errores cuando un objeto existe o no existe.

```sql
DROP TABLE IF EXISTS temporal;
CREATE TABLE IF NOT EXISTS usuarios (...);
```

### INET

Tipo de dato para almacenar direcciones IPv4 o IPv6.

### INTEGER

Tipo de dato entero de 4 bytes. Rango: -2,147,483,648 a 2,147,483,647.

---

## J

### JSON

Tipo de dato para almacenar documentos JSON como texto.

### JSONB

Tipo de dato para almacenar JSON en formato binario. Más eficiente para consultas e indexable.

---

## N

### NOT NULL

Restricción que impide valores NULL en una columna.

### NUMERIC

Sinónimo de DECIMAL. Tipo numérico de precisión exacta.

---

## O

### ON DELETE

Acción a realizar en filas hijas cuando se elimina la fila padre.

### ON UPDATE

Acción a realizar en filas hijas cuando se actualiza la clave padre.

---

## P

### POINT

Tipo de dato geométrico que almacena coordenadas (x, y).

### PRIMARY KEY (PK)

Restricción que identifica de forma única cada fila. Implica UNIQUE y NOT NULL.

---

## R

### REAL

Tipo de dato de punto flotante de 4 bytes con aproximadamente 6 dígitos de precisión.

### REFERENCES

Palabra clave que define la tabla y columna referenciada por una FOREIGN KEY.

### RESTRICT

Opción que bloquea DELETE/UPDATE si existen filas dependientes.

---

## S

### Schema

Namespace dentro de una base de datos para organizar objetos (tablas, vistas, funciones).

```sql
CREATE SCHEMA ventas;
CREATE TABLE ventas.pedidos (...);
```

### SEQUENCE

Generador de números secuenciales. SERIAL crea una secuencia automáticamente.

### SERIAL

Tipo de dato que crea una columna INTEGER autoincremental con secuencia asociada.

### SET DEFAULT

Acción que establece el valor DEFAULT cuando se elimina/actualiza la fila padre.

### SET NULL

Acción que establece NULL cuando se elimina/actualiza la fila padre.

### SMALLINT

Tipo de dato entero de 2 bytes. Rango: -32,768 a 32,767.

### SMALLSERIAL

Tipo autoincremental basado en SMALLINT.

---

## T

### TABLE CONSTRAINT

Restricción definida a nivel de tabla (no de columna individual).

```sql
CONSTRAINT pk_pedidos_detalle PRIMARY KEY (pedido_id, producto_id)
```

### TEXT

Tipo de dato para texto de longitud variable sin límite práctico.

### TIME

Tipo de dato que almacena solo la hora (sin fecha).

### TIMESTAMP

Tipo de dato que almacena fecha y hora.

### TIMESTAMPTZ

Tipo de dato que almacena fecha, hora y zona horaria. Recomendado para aplicaciones internacionales.

### TRUNCATE

Comando DDL que elimina todas las filas de una tabla de forma eficiente.

```sql
TRUNCATE TABLE logs RESTART IDENTITY;
```

---

## U

### UNIQUE

Restricción que garantiza que todos los valores de una columna sean únicos (permite un NULL).

### UUID

Identificador Universalmente Único de 128 bits.

```sql
id UUID DEFAULT uuid_generate_v4()
```

---

## V

### VARCHAR(n)

Tipo de dato para texto de longitud variable hasta n caracteres.

---

## Símbolos y Abreviaturas

| Símbolo | Significado                |
| ------- | -------------------------- |
| PK      | Primary Key                |
| FK      | Foreign Key                |
| DDL     | Data Definition Language   |
| DML     | Data Manipulation Language |
| NN      | Not Null                   |
| UQ      | Unique                     |

---

## 📖 Navegación

|              ⬅️ Recursos              |      🏠 Semana 02      |         Siguiente ➡️          |
| :-----------------------------------: | :--------------------: | :---------------------------: |
| [Recursos](../5-recursos/recursos.md) | [README](../README.md) | [Semana 03](../../semana-03/) |
