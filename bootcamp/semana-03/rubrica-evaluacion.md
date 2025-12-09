# 📋 Rúbrica de Evaluación: Semana 03

## 🎯 Competencias a Evaluar

| Competencia   | Descripción                         |
| ------------- | ----------------------------------- |
| INSERT        | Insertar datos en tablas            |
| UPDATE        | Modificar datos existentes          |
| DELETE        | Eliminar datos correctamente        |
| SELECT básico | Consultar y filtrar datos           |
| Transacciones | Uso básico de BEGIN/COMMIT/ROLLBACK |

---

## 📊 Criterios de Evaluación

### 1. INSERT (20 puntos)

| Criterio            | Excelente (20)              | Bueno (15)         | Suficiente (10)    | Insuficiente (5)        |
| ------------------- | --------------------------- | ------------------ | ------------------ | ----------------------- |
| Sintaxis            | Correcta en todos los casos | Errores menores    | Errores frecuentes | Sintaxis incorrecta     |
| Especifica columnas | Siempre lista columnas      | Mayoría de veces   | A veces            | Usa INSERT sin columnas |
| INSERT múltiple     | Usa eficientemente          | Usa ocasionalmente | Inserta uno a uno  | No conoce               |
| RETURNING           | Usa cuando es apropiado     | Usa ocasionalmente | Conoce pero no usa | No conoce               |
| ON CONFLICT         | Implementa correctamente    | Implementa básico  | Conoce concepto    | No conoce               |

---

### 2. UPDATE (20 puntos)

| Criterio            | Excelente (20)                | Bueno (15)          | Suficiente (10)    | Insuficiente (5)   |
| ------------------- | ----------------------------- | ------------------- | ------------------ | ------------------ |
| Sintaxis            | Correcta siempre              | Errores menores     | Errores frecuentes | Incorrecta         |
| Uso de WHERE        | Siempre específico            | Mayoría de veces    | A veces olvida     | No usa WHERE       |
| Verificación previa | Siempre prueba con SELECT     | Frecuentemente      | A veces            | No verifica        |
| Expresiones         | Usa expresiones correctamente | Usa básicas         | Solo valores fijos | No usa expresiones |
| CASE en UPDATE      | Usa apropiadamente            | Conoce y usa básico | Conoce concepto    | No conoce          |

---

### 3. DELETE (15 puntos)

| Criterio            | Excelente (15)              | Bueno (11)       | Suficiente (8)     | Insuficiente (4) |
| ------------------- | --------------------------- | ---------------- | ------------------ | ---------------- |
| Sintaxis            | Correcta siempre            | Errores menores  | Errores frecuentes | Incorrecta       |
| Uso de WHERE        | Siempre específico          | Mayoría de veces | A veces olvida     | DELETE sin WHERE |
| Verificación previa | Siempre prueba con SELECT   | Frecuentemente   | A veces            | No verifica      |
| Soft Delete         | Implementa cuando apropiado | Conoce patrón    | Concepto básico    | No conoce        |
| Dependencias        | Considera FK                | Parcialmente     | No considera       | Errores por FK   |

---

### 4. SELECT Básico (25 puntos)

| Criterio           | Excelente (25)                  | Bueno (19)           | Suficiente (13) | Insuficiente (6) |
| ------------------ | ------------------------------- | -------------------- | --------------- | ---------------- |
| Selección columnas | Específica y con alias          | Específica sin alias | Usa SELECT \*   | Solo SELECT \*   |
| WHERE              | Condiciones complejas correctas | Condiciones simples  | Básico          | Errores en WHERE |
| Operadores         | Usa todos apropiadamente        | Usa comunes          | Solo = y AND    | Confusión        |
| ORDER BY           | Multi-columna correcto          | Una columna          | Conoce          | No ordena        |
| LIMIT/OFFSET       | Paginación correcta             | Usa LIMIT            | Básico          | No conoce        |
| DISTINCT           | Usa correctamente               | Usa básico           | Conoce          | No conoce        |

---

### 5. Transacciones (10 puntos)

| Criterio              | Excelente (10)              | Bueno (8)           | Suficiente (6)  | Insuficiente (3)     |
| --------------------- | --------------------------- | ------------------- | --------------- | -------------------- |
| BEGIN/COMMIT          | Usa correctamente           | Usa básico          | Conoce          | No usa               |
| ROLLBACK              | Sabe cuándo usar            | Conoce uso          | Concepto        | No conoce            |
| Operaciones múltiples | Agrupa apropiadamente       | A veces agrupa      | No agrupa       | No entiende          |
| Consistencia          | Mantiene datos consistentes | Mayoría consistente | Algunos errores | Datos inconsistentes |

---

### 6. Buenas Prácticas (10 puntos)

| Criterio                     | Excelente (10)               | Bueno (8)             | Suficiente (6)      | Insuficiente (3) |
| ---------------------------- | ---------------------------- | --------------------- | ------------------- | ---------------- |
| Comentarios                  | Documenta propósito y lógica | Comentarios básicos   | Pocos comentarios   | Sin comentarios  |
| Formato SQL                  | Mayúsculas, indentación      | Mayormente formateado | Inconsistente       | Sin formato      |
| No usar SELECT \*            | Nunca en producción          | Raramente             | A veces             | Siempre usa \*   |
| Verificar antes de modificar | Siempre                      | Frecuentemente        | A veces             | Nunca            |
| Manejo NULL                  | Usa IS NULL correctamente    | Conoce diferencia     | Errores ocasionales | Usa = NULL       |

---

## 📈 Escala de Calificación

| Rango  |  Calificación   | Descripción                            |
| :----: | :-------------: | -------------------------------------- |
| 90-100 |  ⭐ Excelente   | Dominio completo de DML                |
| 80-89  |  ✅ Muy Bueno   | Competente con detalles menores        |
| 70-79  |    👍 Bueno     | Cumple objetivos con áreas de mejora   |
| 60-69  |  📝 Suficiente  | Conocimiento básico, necesita práctica |
|  < 60  | ⚠️ Insuficiente | Requiere refuerzo significativo        |

---

## ✅ Checklist de Autoevaluación

### INSERT

- [ ] Puedo insertar una fila especificando columnas
- [ ] Puedo insertar múltiples filas en una sentencia
- [ ] Sé usar RETURNING para obtener valores generados
- [ ] Puedo usar INSERT...SELECT para copiar datos
- [ ] Entiendo y uso ON CONFLICT para UPSERT

### UPDATE

- [ ] Siempre uso WHERE en mis UPDATE
- [ ] Verifico con SELECT antes de ejecutar UPDATE
- [ ] Puedo actualizar múltiples columnas
- [ ] Sé usar expresiones en SET
- [ ] Puedo usar CASE en UPDATE

### DELETE

- [ ] Siempre uso WHERE en mis DELETE
- [ ] Verifico con SELECT antes de ejecutar DELETE
- [ ] Entiendo el concepto de Soft Delete
- [ ] Sé usar DELETE con subconsultas
- [ ] Considero dependencias de FK

### SELECT

- [ ] Especifico columnas en lugar de usar \*
- [ ] Uso alias para mejorar legibilidad
- [ ] Domino los operadores de WHERE
- [ ] Sé ordenar por múltiples columnas
- [ ] Puedo implementar paginación con LIMIT/OFFSET

### Transacciones

- [ ] Entiendo cuándo usar BEGIN/COMMIT
- [ ] Sé cuándo usar ROLLBACK
- [ ] Agrupo operaciones relacionadas en transacciones

---

## 📝 Retroalimentación

### Fortalezas identificadas:

_[Espacio para feedback positivo]_

### Áreas de mejora:

_[Espacio para áreas a desarrollar]_

### Recomendaciones:

_[Espacio para sugerencias específicas]_

---

## 📖 Navegación

|            ⬅️ Glosario             |    🏠 Semana 03     |            Siguiente ➡️             |
| :--------------------------------: | :-----------------: | :---------------------------------: |
| [Glosario](6-glosario/glosario.md) | [README](README.md) | [Semana 04](../semana-04/README.md) |
