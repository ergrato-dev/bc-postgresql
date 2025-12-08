-- ============================================
-- Bootcamp PostgreSQL - Script de Inicialización
-- ============================================
-- Este script se ejecuta automáticamente al crear el contenedor
-- Crea el esquema base para los ejercicios del bootcamp
-- ============================================

-- Configuración de encoding
SET client_encoding = 'UTF8';

-- Mensaje de bienvenida
DO $$
BEGIN
  RAISE NOTICE '🐘 Inicializando base de datos del Bootcamp PostgreSQL...';
END $$;

-- ============================================
-- Esquema: tienda_online
-- ============================================

-- Tabla: categorias
CREATE TABLE IF NOT EXISTS categorias (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL UNIQUE,
  descripcion TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: productos
CREATE TABLE IF NOT EXISTS productos (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(200) NOT NULL,
  descripcion TEXT,
  precio DECIMAL(10, 2) NOT NULL CHECK (precio >= 0),
  stock INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),
  categoria_id INTEGER REFERENCES categorias(id),
  activo BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: clientes
CREATE TABLE IF NOT EXISTS clientes (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  telefono VARCHAR(20),
  direccion TEXT,
  ciudad VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: pedidos
CREATE TABLE IF NOT EXISTS pedidos (
  id SERIAL PRIMARY KEY,
  cliente_id INTEGER NOT NULL REFERENCES clientes(id),
  fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  estado VARCHAR(20) DEFAULT 'pendiente' CHECK (estado IN ('pendiente', 'procesando', 'enviado', 'entregado', 'cancelado')),
  total DECIMAL(12, 2) DEFAULT 0,
  notas TEXT
);

-- Tabla: detalle_pedidos
CREATE TABLE IF NOT EXISTS detalle_pedidos (
  id SERIAL PRIMARY KEY,
  pedido_id INTEGER NOT NULL REFERENCES pedidos(id) ON DELETE CASCADE,
  producto_id INTEGER NOT NULL REFERENCES productos(id),
  cantidad INTEGER NOT NULL CHECK (cantidad > 0),
  precio_unitario DECIMAL(10, 2) NOT NULL,
  subtotal DECIMAL(12, 2) GENERATED ALWAYS AS (cantidad * precio_unitario) STORED
);

-- ============================================
-- Datos de ejemplo
-- ============================================

-- Categorías
INSERT INTO categorias (nombre, descripcion) VALUES
  ('Electrónica', 'Dispositivos electrónicos y gadgets'),
  ('Ropa', 'Vestimenta y accesorios'),
  ('Hogar', 'Artículos para el hogar'),
  ('Deportes', 'Equipamiento deportivo'),
  ('Libros', 'Libros y material de lectura')
ON CONFLICT (nombre) DO NOTHING;

-- Productos
INSERT INTO productos (nombre, descripcion, precio, stock, categoria_id) VALUES
  ('Laptop ProMax 15"', 'Laptop de alto rendimiento con 16GB RAM', 1299.99, 25, 1),
  ('Auriculares Bluetooth', 'Auriculares inalámbricos con cancelación de ruido', 89.99, 100, 1),
  ('Camiseta Básica', 'Camiseta 100% algodón', 19.99, 200, 2),
  ('Pantalón Jeans', 'Jeans clásico azul', 49.99, 150, 2),
  ('Lámpara LED', 'Lámpara de escritorio LED regulable', 34.99, 75, 3),
  ('Balón de Fútbol', 'Balón oficial tamaño 5', 29.99, 50, 4),
  ('Raqueta de Tenis', 'Raqueta profesional de grafito', 159.99, 30, 4),
  ('El Quijote', 'Edición especial ilustrada', 24.99, 40, 5),
  ('PostgreSQL Avanzado', 'Guía completa de PostgreSQL', 45.99, 20, 5),
  ('Teclado Mecánico', 'Teclado gaming RGB', 79.99, 60, 1)
ON CONFLICT DO NOTHING;

-- Clientes
INSERT INTO clientes (nombre, apellido, email, telefono, ciudad) VALUES
  ('María', 'García', 'maria.garcia@email.com', '+34 612 345 678', 'Madrid'),
  ('Carlos', 'López', 'carlos.lopez@email.com', '+34 623 456 789', 'Barcelona'),
  ('Ana', 'Martínez', 'ana.martinez@email.com', '+34 634 567 890', 'Valencia'),
  ('Pedro', 'Sánchez', 'pedro.sanchez@email.com', '+34 645 678 901', 'Sevilla'),
  ('Laura', 'Fernández', 'laura.fernandez@email.com', '+34 656 789 012', 'Bilbao')
ON CONFLICT (email) DO NOTHING;

-- ============================================
-- Mensaje de confirmación
-- ============================================
DO $$
BEGIN
  RAISE NOTICE '✅ Base de datos inicializada correctamente';
  RAISE NOTICE '📊 Tablas creadas: categorias, productos, clientes, pedidos, detalle_pedidos';
  RAISE NOTICE '🚀 ¡Listo para comenzar el bootcamp!';
END $$;
