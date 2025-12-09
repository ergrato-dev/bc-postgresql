# 📘 Semana 02: DDL - Definición de Datos

<p align="center">
  <img src="0-assets/01-diagrama-ddl-comandos.svg" alt="Comandos DDL" width="100%">
</p>

---

## 🎯 Objetivos de la Semana

Al finalizar esta semana serás capaz de:

- ✅ Crear bases de datos y esquemas
- ✅ Diseñar y crear tablas con tipos de datos apropiados
- ✅ Aplicar restricciones (constraints) para integridad de datos
- ✅ Modificar estructuras existentes con ALTER
- ✅ Eliminar objetos de forma segura con DROP

---

## 📚 Contenido

| Sección                        | Descripción                      | Tiempo |
| ------------------------------ | -------------------------------- | :----: |
| [1. Teoría](1-teoria/)         | DDL, tipos de datos, constraints |   1h   |
| [2. Práctica](2-practica/)     | Creación de tablas y esquemas    |   1h   |
| [3. Ejercicios](3-ejercicios/) | Práctica individual              |   1h   |
| [4. Proyecto](4-proyecto/)     | Diseño de base de datos completa |   1h   |

---

## 🗂️ Estructura de la Semana

```
semana-02/
├── 0-assets/
│   ├── 01-diagrama-ddl-comandos.svg
│   ├── 02-diagrama-tipos-datos.svg
│   └── 03-diagrama-constraints.svg
├── 1-teoria/
│   ├── 01-introduccion-ddl.md
│   ├── 02-tipos-de-datos.md
│   └── 03-constraints.md
├── 2-practica/
│   ├── 01-crear-bases-datos.md
│   ├── 02-crear-tablas.md
│   └── 03-modificar-estructuras.md
├── 3-ejercicios/
│   ├── ejercicios.md
│   └── soluciones.md
├── 4-proyecto/
│   └── proyecto-semana-02.md
├── 5-recursos/
│   └── recursos.md
├── 6-glosario/
│   └── glosario.md
├── README.md
└── rubrica-evaluacion.md
```

---

## 🔑 Conceptos Clave

| Término         | Definición                                                   |
| --------------- | ------------------------------------------------------------ |
| **DDL**         | Data Definition Language - comandos para definir estructuras |
| **CREATE**      | Crear nuevos objetos (tablas, índices, vistas)               |
| **ALTER**       | Modificar objetos existentes                                 |
| **DROP**        | Eliminar objetos                                             |
| **Constraint**  | Restricción que garantiza integridad de datos                |
| **Primary Key** | Identificador único de cada fila                             |
| **Foreign Key** | Referencia a otra tabla                                      |

---

## ⏱️ Distribución del Tiempo (4 horas)

```
📚 Teoría      ████████░░░░░░░░ 1h (25%)
💻 Práctica    ████████░░░░░░░░ 1h (25%)
🔧 Ejercicios  ████████░░░░░░░░ 1h (25%)
🚀 Proyecto    ████████░░░░░░░░ 1h (25%)
```

---

## 🚀 Inicio Rápido

### Conectarse a PostgreSQL

```bash
docker exec -it postgres-bootcamp psql -U bootcamp -d tienda_online
```

### Tu primer CREATE TABLE

```sql
CREATE TABLE ejemplo (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Verificar la tabla

```sql
\d ejemplo
```

---

## ✅ Checklist de Progreso

- [ ] Entiendo la diferencia entre DDL y DML
- [ ] Conozco los tipos de datos principales
- [ ] Puedo crear tablas con restricciones
- [ ] Sé modificar tablas con ALTER
- [ ] Comprendo cuándo usar CASCADE vs RESTRICT
- [ ] Completé el proyecto semanal

---

## 📖 Navegación

|        ⬅️ Anterior         |          🏠 Inicio          |        Siguiente ➡️        |
| :------------------------: | :-------------------------: | :------------------------: |
| [Semana 01](../semana-01/) | [Bootcamp](../../README.md) | [Semana 03](../semana-03/) |
