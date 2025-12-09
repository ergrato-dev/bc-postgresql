# 📋 Rúbrica de Evaluación - Semana 02: DDL

## 🎯 Objetivos Evaluados

| Objetivo                            | Peso |
| ----------------------------------- | :--: |
| Crear bases de datos y esquemas     | 15%  |
| Diseñar tablas con tipos apropiados | 25%  |
| Implementar constraints             | 30%  |
| Modificar estructuras con ALTER     | 15%  |
| Proyecto integrador                 | 15%  |

---

## 📊 Criterios de Evaluación

### 1. Creación de Bases de Datos y Esquemas (15%)

| Nivel               | Puntos | Descripción                                                                                |
| ------------------- | :----: | ------------------------------------------------------------------------------------------ |
| **Excelente**       |   15   | Crea BD con encoding y locale correctos. Organiza esquemas lógicamente. Usa IF NOT EXISTS. |
| **Bueno**           |   12   | Crea BD y esquemas correctamente. Usa search_path adecuadamente.                           |
| **Satisfactorio**   |   9    | Crea BD básica. Conoce el concepto de esquemas.                                            |
| **Necesita mejora** |   5    | Puede crear BD simple. Confunde esquemas con tablas.                                       |
| **Insuficiente**    |   0    | No logra crear bases de datos o esquemas.                                                  |

---

### 2. Diseño de Tablas con Tipos de Datos (25%)

| Nivel               | Puntos | Descripción                                                                                                    |
| ------------------- | :----: | -------------------------------------------------------------------------------------------------------------- |
| **Excelente**       |   25   | Elige tipos óptimos para cada caso. Usa SERIAL/UUID correctamente. Implementa JSONB, ARRAY cuando corresponde. |
| **Bueno**           |   20   | Tipos apropiados en la mayoría de casos. Entiende diferencias entre tipos similares.                           |
| **Satisfactorio**   |   15   | Usa tipos básicos correctamente (VARCHAR, INTEGER, DATE). Puede tener errores en casos específicos.            |
| **Necesita mejora** |   10   | Usa tipos básicos pero con errores (REAL para dinero, VARCHAR para fechas).                                    |
| **Insuficiente**    |   0    | No comprende la diferencia entre tipos de datos.                                                               |

**Checklist específico:**

- [ ] Usa DECIMAL para valores monetarios
- [ ] Usa TIMESTAMPTZ para fechas con hora
- [ ] Usa SERIAL o UUID para claves primarias
- [ ] Usa VARCHAR con límites razonables
- [ ] Usa BOOLEAN para valores sí/no

---

### 3. Implementación de Constraints (30%)

| Nivel               | Puntos | Descripción                                                                                                       |
| ------------------- | :----: | ----------------------------------------------------------------------------------------------------------------- |
| **Excelente**       |   30   | Todas las PK/FK correctas. CHECK para validaciones de negocio. Nombres descriptivos. ON DELETE/UPDATE apropiados. |
| **Bueno**           |   24   | PK/FK correctas. Usa CHECK y UNIQUE. Algunos nombres genéricos.                                                   |
| **Satisfactorio**   |   18   | PK correctas. FK básicas. Algunos CHECK.                                                                          |
| **Necesita mejora** |   12   | Solo PK. FK con errores. No usa CHECK.                                                                            |
| **Insuficiente**    |   0    | No implementa constraints o tiene errores graves.                                                                 |

**Checklist específico:**

- [ ] PRIMARY KEY en todas las tablas
- [ ] FOREIGN KEY con referencias correctas
- [ ] ON DELETE con acción apropiada
- [ ] NOT NULL donde corresponde
- [ ] CHECK para validaciones de rango/formato
- [ ] UNIQUE para campos que lo requieren
- [ ] DEFAULT para valores por defecto
- [ ] Nombres de constraints descriptivos (pk*, fk*, chk*, uq*)

---

### 4. Modificación de Estructuras (15%)

| Nivel               | Puntos | Descripción                                                                             |
| ------------------- | :----: | --------------------------------------------------------------------------------------- |
| **Excelente**       |   15   | Modifica tablas con datos sin pérdida. Maneja migraciones complejas. Usa transacciones. |
| **Bueno**           |   12   | Agrega/modifica columnas correctamente. Cambia tipos con USING.                         |
| **Satisfactorio**   |   9    | Agrega columnas simples. Conoce ALTER básico.                                           |
| **Necesita mejora** |   6    | Puede agregar columnas pero con errores.                                                |
| **Insuficiente**    |   0    | No sabe usar ALTER TABLE.                                                               |

**Checklist específico:**

- [ ] ADD COLUMN con/sin DEFAULT
- [ ] ALTER COLUMN TYPE
- [ ] SET/DROP NOT NULL
- [ ] ADD/DROP CONSTRAINT
- [ ] RENAME columnas y tablas
- [ ] DROP COLUMN con IF EXISTS

---

### 5. Proyecto Integrador (15%)

| Nivel               | Puntos | Descripción                                                                                                     |
| ------------------- | :----: | --------------------------------------------------------------------------------------------------------------- |
| **Excelente**       |   15   | Esquema completo y normalizado. Todas las relaciones correctas. Datos de prueba coherentes. Código documentado. |
| **Bueno**           |   12   | Esquema funcional. Mayoría de relaciones correctas. Datos de prueba.                                            |
| **Satisfactorio**   |   9    | Esquema básico funcional. Algunas relaciones. Pocos datos de prueba.                                            |
| **Necesita mejora** |   6    | Esquema incompleto. Relaciones con errores.                                                                     |
| **Insuficiente**    |   0    | No completó el proyecto o tiene errores graves.                                                                 |

---

## 📈 Escala de Calificación

| Porcentaje | Calificación |       Estado       |
| :--------: | :----------: | :----------------: |
|  90-100%   |      A       |    ✅ Excelente    |
|   80-89%   |      B       |      ✅ Bueno      |
|   70-79%   |      C       |  ✅ Satisfactorio  |
|   60-69%   |      D       | ⚠️ Necesita mejora |
|   < 60%    |      F       |  ❌ Insuficiente   |

---

## 🔍 Evaluación Práctica

### Ejercicio de Evaluación

El estudiante debe demostrar capacidad para:

1. **Crear una base de datos** con encoding UTF8
2. **Crear un esquema** organizado
3. **Diseñar 3 tablas relacionadas** con:
   - Tipos de datos apropiados
   - PRIMARY KEY
   - FOREIGN KEY con ON DELETE
   - Al menos 2 CHECK
   - Al menos 2 DEFAULT
   - Al menos 1 UNIQUE
4. **Modificar una tabla** agregando columna con constraint
5. **Insertar datos de prueba** que pasen todas las validaciones

---

## ✅ Autoevaluación

Antes de entregar, el estudiante debe verificar:

- [ ] ¿Todas las tablas tienen PRIMARY KEY?
- [ ] ¿Las FK referencian columnas existentes?
- [ ] ¿Los CHECK validan correctamente?
- [ ] ¿Los nombres de constraints son descriptivos?
- [ ] ¿Los tipos de datos son apropiados?
- [ ] ¿El código está comentado?
- [ ] ¿Los datos de prueba funcionan?

---

## 📖 Navegación

|            ⬅️ Glosario             |    🏠 Semana 02     |        Siguiente ➡️        |
| :--------------------------------: | :-----------------: | :------------------------: |
| [Glosario](6-glosario/glosario.md) | [README](README.md) | [Semana 03](../semana-03/) |
