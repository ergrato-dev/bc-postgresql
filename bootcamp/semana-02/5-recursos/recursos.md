# 📖 Recursos: Semana 02 - DDL

## 📚 Documentación Oficial

### PostgreSQL

| Recurso                                                                 | Descripción                        |
| ----------------------------------------------------------------------- | ---------------------------------- |
| [CREATE TABLE](https://www.postgresql.org/docs/18/sql-createtable.html) | Referencia oficial de CREATE TABLE |
| [Data Types](https://www.postgresql.org/docs/18/datatype.html)          | Todos los tipos de datos           |
| [Constraints](https://www.postgresql.org/docs/18/ddl-constraints.html)  | Restricciones de integridad        |
| [ALTER TABLE](https://www.postgresql.org/docs/18/sql-altertable.html)   | Modificar tablas                   |
| [DROP TABLE](https://www.postgresql.org/docs/18/sql-droptable.html)     | Eliminar tablas                    |

---

## 🎥 Videos Recomendados

| Video                                                                                                          | Duración | Tema                     |
| -------------------------------------------------------------------------------------------------------------- | :------: | ------------------------ |
| [PostgreSQL Data Types](https://www.youtube.com/results?search_query=postgresql+data+types+tutorial)           | ~15 min  | Tipos de datos           |
| [Primary & Foreign Keys](https://www.youtube.com/results?search_query=postgresql+primary+foreign+key+tutorial) | ~20 min  | Claves y relaciones      |
| [Database Design](https://www.youtube.com/results?search_query=database+design+tutorial+beginners)             | ~30 min  | Diseño de bases de datos |

---

## 📝 Artículos

### Diseño de Bases de Datos

- [Database Normalization Explained](https://www.guru99.com/database-normalization.html)
- [PostgreSQL Best Practices](https://wiki.postgresql.org/wiki/Don%27t_Do_This)
- [Choosing the Right Data Type](https://www.postgresql.org/docs/current/datatype.html)

### Constraints

- [Understanding Foreign Keys](https://www.postgresql.org/docs/current/tutorial-fk.html)
- [CHECK Constraints](https://www.postgresql.org/docs/current/ddl-constraints.html#DDL-CONSTRAINTS-CHECK-CONSTRAINTS)

---

## 🔧 Herramientas

### Diseño Visual

| Herramienta      | Descripción                  | Link                                     |
| ---------------- | ---------------------------- | ---------------------------------------- |
| **dbdiagram.io** | Diseño de ER online gratuito | [dbdiagram.io](https://dbdiagram.io)     |
| **DrawSQL**      | Diagramas SQL visuales       | [drawsql.app](https://drawsql.app)       |
| **Lucidchart**   | Diagramas profesionales      | [lucidchart.com](https://lucidchart.com) |
| **pgModeler**    | Modelador para PostgreSQL    | [pgmodeler.io](https://pgmodeler.io)     |

### Generadores

| Herramienta                                     | Descripción             |
| ----------------------------------------------- | ----------------------- |
| [Mockaroo](https://mockaroo.com)                | Generar datos de prueba |
| [GenerateData](https://generatedata.com)        | Datos aleatorios        |
| [UUID Generator](https://www.uuidgenerator.net) | Generar UUIDs           |

---

## 📊 Cheat Sheets

### Tipos de Datos

```
NUMÉRICOS
├── SMALLINT      → -32,768 a 32,767
├── INTEGER       → ±2.1 billones
├── BIGINT        → ±9.2 quintillones
├── DECIMAL(p,s)  → Precisión exacta
├── REAL          → 6 dígitos
└── DOUBLE        → 15 dígitos

TEXTO
├── CHAR(n)       → Longitud fija
├── VARCHAR(n)    → Hasta n caracteres
└── TEXT          → Sin límite

FECHA/HORA
├── DATE          → Solo fecha
├── TIME          → Solo hora
├── TIMESTAMP     → Fecha + hora
├── TIMESTAMPTZ   → Con zona horaria
└── INTERVAL      → Duración

OTROS
├── BOOLEAN       → true/false
├── UUID          → Identificador único
├── JSONB         → JSON binario
├── ARRAY         → Arreglos
└── ENUM          → Valores fijos
```

### Constraints

```
PRIMARY KEY    → Identificador único, NOT NULL
FOREIGN KEY    → Referencia a otra tabla
UNIQUE         → Valores únicos (permite NULL)
NOT NULL       → Valor obligatorio
CHECK          → Validación personalizada
DEFAULT        → Valor por defecto
```

### Acciones Referenciales

```
ON DELETE/UPDATE:
├── CASCADE      → Propagar cambio
├── SET NULL     → Establecer NULL
├── SET DEFAULT  → Establecer default
├── RESTRICT     → Bloquear acción
└── NO ACTION    → Similar a RESTRICT
```

---

## 🧪 Ejercicios Adicionales

### Práctica Extra

1. **Diseña un esquema para una tienda de música** con: artistas, álbumes, canciones, géneros, playlists.

2. **Diseña un esquema para un hospital** con: pacientes, doctores, especialidades, citas, historiales médicos.

3. **Diseña un esquema para una red social** con: usuarios, posts, comentarios, likes, seguidores.

---

## 📌 Tips Importantes

### Elección de Tipos de Datos

| Dato        | ✅ Usar       | ❌ Evitar        |
| ----------- | ------------- | ---------------- |
| Dinero      | DECIMAL(10,2) | REAL, FLOAT      |
| ID primario | SERIAL, UUID  | VARCHAR          |
| Fechas      | TIMESTAMPTZ   | VARCHAR, TEXT    |
| Booleanos   | BOOLEAN       | VARCHAR, INTEGER |
| JSON        | JSONB         | TEXT, VARCHAR    |

### Nombrado

```sql
-- ✅ Buenos nombres
pk_usuarios              -- Primary Key
fk_pedidos_cliente       -- Foreign Key
uq_usuarios_email        -- Unique
chk_precio_positivo      -- Check
idx_productos_nombre     -- Index

-- ❌ Malos nombres
constraint1
fk1
check_1
```

---

## 🔗 Links de Referencia Rápida

| Tarea                    | Comando            |
| ------------------------ | ------------------ |
| Ver tablas               | `\dt`              |
| Ver estructura           | `\d nombre_tabla`  |
| Ver estructura detallada | `\d+ nombre_tabla` |
| Ver esquemas             | `\dn`              |
| Ver índices              | `\di`              |
| Ver secuencias           | `\ds`              |
| Ver constraints          | `\d nombre_tabla`  |

---

## 📖 Navegación

|                   ⬅️ Proyecto                   |      🏠 Semana 02      |             Siguiente ➡️              |
| :---------------------------------------------: | :--------------------: | :-----------------------------------: |
| [Proyecto](../4-proyecto/proyecto-semana-02.md) | [README](../README.md) | [Glosario](../6-glosario/glosario.md) |
