# 🔄 Introducción a DML

## 🎯 Objetivo

Comprender qué es DML (Data Manipulation Language) y su diferencia con DDL.

---

## 📖 ¿Qué es DML?

**DML (Data Manipulation Language)** es el subconjunto de SQL utilizado para **manipular los datos** dentro de las tablas.

> 💡 **Recordatorio**: DDL define la estructura (CREATE, ALTER, DROP), mientras que DML trabaja con los datos (INSERT, UPDATE, DELETE, SELECT).

---

## 🔄 DDL vs DML

| Aspecto           | DDL                        | DML                            |
| ----------------- | -------------------------- | ------------------------------ |
| **Propósito**     | Definir estructuras        | Manipular datos                |
| **Comandos**      | CREATE, ALTER, DROP        | INSERT, UPDATE, DELETE, SELECT |
| **Afecta a**      | Esquema/Metadatos          | Filas de datos                 |
| **Frecuencia**    | Ocasional                  | Muy frecuente                  |
| **Transacciones** | Auto-commit (generalmente) | Controlable con BEGIN/COMMIT   |

---

## 📋 Comandos DML

![Comandos DML](../0-assets/01-diagrama-dml-comandos.svg)

| Comando  | Descripción                | Ejemplo                            |
| -------- | -------------------------- | ---------------------------------- |
| `INSERT` | Agregar nuevas filas       | `INSERT INTO t VALUES (...)`       |
| `UPDATE` | Modificar filas existentes | `UPDATE t SET col = val WHERE ...` |
| `DELETE` | Eliminar filas             | `DELETE FROM t WHERE ...`          |
| `SELECT` | Consultar filas            | `SELECT * FROM t WHERE ...`        |

---

## 🔄 El Ciclo CRUD

**CRUD** es el acrónimo para las 4 operaciones fundamentales de datos:

![Ciclo CRUD](../0-assets/03-diagrama-crud-ciclo.svg)

| Letra | Operación | SQL      | Descripción            |
| :---: | --------- | -------- | ---------------------- |
| **C** | Create    | `INSERT` | Crear nuevos registros |
| **R** | Read      | `SELECT` | Leer/consultar datos   |
| **U** | Update    | `UPDATE` | Modificar registros    |
| **D** | Delete    | `DELETE` | Eliminar registros     |

---

## 🔐 Transacciones en DML

A diferencia de DDL, las operaciones DML son **transaccionales**:

```sql
-- Iniciar transacción
BEGIN;

-- Operaciones DML
INSERT INTO cuentas (titular, saldo) VALUES ('Juan', 1000);
UPDATE cuentas SET saldo = saldo - 100 WHERE titular = 'Juan';
UPDATE cuentas SET saldo = saldo + 100 WHERE titular = 'María';

-- Si todo está bien
COMMIT;

-- Si hay error
ROLLBACK;
```

### Propiedades ACID

| Propiedad        | Descripción                                         |
| ---------------- | --------------------------------------------------- |
| **Atomicidad**   | Todo o nada - la transacción completa o se revierte |
| **Consistencia** | Los datos pasan de un estado válido a otro válido   |
| **Aislamiento**  | Transacciones concurrentes no se interfieren        |
| **Durabilidad**  | Una vez confirmado, los cambios persisten           |

---

## ⚠️ Seguridad en DML

### La regla de oro: WHERE

```sql
-- ⚠️ PELIGROSO: Afecta TODAS las filas
UPDATE productos SET precio = 0;
DELETE FROM clientes;

-- ✅ SEGURO: Afecta solo filas específicas
UPDATE productos SET precio = 0 WHERE id = 5;
DELETE FROM clientes WHERE id = 10;
```

### Buenas prácticas

1. **Siempre usa WHERE** en UPDATE y DELETE
2. **Primero SELECT** para verificar qué filas afectarás
3. **Usa transacciones** para poder revertir
4. **Haz backup** antes de operaciones masivas

```sql
-- Patrón seguro
BEGIN;

-- 1. Ver qué vas a modificar
SELECT * FROM productos WHERE categoria = 'obsoleto';

-- 2. Si es correcto, modificar
DELETE FROM productos WHERE categoria = 'obsoleto';

-- 3. Verificar resultado
SELECT COUNT(*) FROM productos WHERE categoria = 'obsoleto';

-- 4. Confirmar o revertir
COMMIT;  -- o ROLLBACK si algo salió mal
```

---

## 📊 Cantidad de Filas Afectadas

PostgreSQL informa cuántas filas afectó cada operación:

```sql
INSERT INTO productos (nombre) VALUES ('Test');
-- INSERT 0 1  (1 fila insertada)

UPDATE productos SET activo = TRUE WHERE categoria_id = 5;
-- UPDATE 15  (15 filas actualizadas)

DELETE FROM productos WHERE precio < 10;
-- DELETE 3  (3 filas eliminadas)
```

---

## 🎯 RETURNING

PostgreSQL permite obtener los datos afectados con `RETURNING`:

```sql
-- Obtener el ID generado
INSERT INTO productos (nombre, precio)
VALUES ('Nuevo Producto', 99.99)
RETURNING id;

-- Obtener los valores actualizados
UPDATE productos SET precio = precio * 1.1
WHERE categoria_id = 3
RETURNING id, nombre, precio;

-- Ver qué se eliminó
DELETE FROM productos WHERE stock = 0
RETURNING id, nombre;
```

---

## ✅ Resumen

1. **DML** manipula los datos (INSERT, UPDATE, DELETE, SELECT)
2. **CRUD** = Create, Read, Update, Delete
3. Las operaciones DML son **transaccionales**
4. **Siempre usa WHERE** en UPDATE y DELETE
5. Usa **RETURNING** para obtener valores afectados
6. **Verifica antes de modificar** con SELECT

---

## 📖 Navegación

|                      ⬅️ Semana 02                      |      Siguiente ➡️      |
| :----------------------------------------------------: | :--------------------: |
| [DDL](../../semana-02/1-teoria/01-introduccion-ddl.md) | [INSERT](02-insert.md) |
