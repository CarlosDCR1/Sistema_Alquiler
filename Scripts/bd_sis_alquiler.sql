
CREATE TABLE jornada (
    id_jornada INT auto_increment PRIMARY KEY,
    nombre_jornada VARCHAR(100) NOT NULL,
    horario_jornada VARCHAR(100)
);

CREATE TABLE facultad (
    id_facultad INT auto_increment PRIMARY KEY,
    id_jornada INT,
    nombre_facultad VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_jornada) REFERENCES jornada(id_jornada)
);

CREATE TABLE carrera (
    id_carrera INT auto_increment PRIMARY KEY,
    id_facultad INT,
    nombre_carrera VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_facultad) REFERENCES facultad(id_facultad)
);

CREATE TABLE tipo_cliente (
    id_tipo_cliente INT auto_increment PRIMARY KEY,
    nombre_tipo_cliente VARCHAR(50) NOT NULL
);

CREATE TABLE cliente (
    id_cliente INT auto_increment PRIMARY KEY,
    id_tipo_cliente INT NOT NULL,
    id_carrera INT NOT NULL,
    nombre_cliente VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_tipo_cliente) REFERENCES tipo_cliente(id_tipo_cliente),
	FOREIGN KEY (id_carrera) REFERENCES carrera(id_carrera)
    );


CREATE TABLE correo_cliente (
    id_correo_cliente INT auto_increment PRIMARY KEY,
    id_cliente INT NOT NULL,
    correo VARCHAR(100) NOT NULL,
    CONSTRAINT fk_correo_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE telefono_cliente (
    id_telefono INT auto_increment PRIMARY KEY,
    id_cliente INT NOT NULL,
    numero VARCHAR(8) NOT NULL,
    CONSTRAINT fk_telefono_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE cargo (
    id_cargo INT auto_increment PRIMARY KEY,
    nombre_cargo VARCHAR(50) NOT NULL
);

CREATE TABLE empleado (
    id_empleado INT auto_increment PRIMARY KEY,
    id_cargo int NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE,
    apellidos VARCHAR(50),
    dpi VARCHAR(15),
    estado_civil VARCHAR(20),
    FOREIGN KEY (id_cargo) REFERENCES cargo(id_cargo)

);

CREATE TABLE empleado_cargo (
    id_empleado INT NOT NULL,
    id_cargo INT NOT NULL,
    PRIMARY KEY (id_empleado, id_cargo),
    CONSTRAINT fk_empcargo_empleado 
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    CONSTRAINT fk_empcargo_cargo 
    FOREIGN KEY (id_cargo) REFERENCES cargo(id_cargo)
);

CREATE TABLE telefono_emp (
    id_telefono INT auto_increment PRIMARY KEY,
    id_empleado INT NOT NULL,
    tipo_contacto VARCHAR(50) NOT NULL,
    numero VARCHAR(8) NOT NULL,
    CONSTRAINT fk_telefono_emp FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

CREATE TABLE correo_emp (
    id_correo INT auto_increment PRIMARY KEY,
    id_empleado INT NOT NULL,
    correo VARCHAR(100) NOT NULL,
    CONSTRAINT fk_correo_emp FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

CREATE TABLE categoria_producto (
    id_categoria_producto INT auto_increment PRIMARY KEY,
    nombre_categoria_producto VARCHAR(80) NOT NULL,
    descripcion_categoria_producto VARCHAR(500)
);

CREATE TABLE marca (
    id_marca INT auto_increment PRIMARY KEY,
    nombre_marca VARCHAR(50)
);

CREATE TABLE estado_producto (
    id_estado_producto INT auto_increment PRIMARY KEY,
    nombre_estado_producto VARCHAR(50) NOT NULL
);

CREATE TABLE modelo_producto (
    id_modelo_producto INT auto_increment PRIMARY KEY,
    id_marca INT NOT NULL,
    id_categoria_producto INT NOT NULL,
    nombre_modelo_producto VARCHAR(50) NOT NULL,
    descripcion_modelo_producto VARCHAR(200),
    FOREIGN KEY (id_marca) REFERENCES marca(id_marca),
    FOREIGN KEY (id_categoria_producto) REFERENCES categoria_producto(id_categoria_producto)
);

CREATE TABLE equipo (
    id_equipo INT auto_increment PRIMARY KEY,
    id_modelo_producto INT NOT NULL,
    id_estado_producto INT NOT NULL,
    descripcion_equipo VARCHAR(200) NOT NULL,
    FOREIGN KEY (id_modelo_producto) REFERENCES modelo_producto(id_modelo_producto),
    FOREIGN KEY (id_estado_producto) REFERENCES estado_producto(id_estado_producto)
);


CREATE TABLE inventario_equipo (
    id_inventario INT auto_increment PRIMARY KEY,
    id_equipo INT NOT NULL,
    ubicacion_actual VARCHAR(150),
    fecha_ingreso DATE NOT NULL,
    fecha_ultimo_mov DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    tipo_ultimo_mov VARCHAR(20),  
    observaciones VARCHAR(300),
    CONSTRAINT fk_inveq_equipo FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo)
);

CREATE TABLE movimiento_inventario (
    id_movimiento INT auto_increment PRIMARY KEY,
    id_inventario INT NOT NULL,
    tipo_movimiento VARCHAR(20) NOT NULL, 
    fecha_movimiento DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    id_empleado INT,  
    descripcion VARCHAR(300),
    FOREIGN KEY (id_inventario) REFERENCES inventario_equipo(id_inventario),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    CONSTRAINT chk_movinv_tipo CHECK (tipo_movimiento IN ('PRESTAMO','DEVOLUCION','BAJA','INGRESO'))
);

CREATE TABLE alquiler (
    id_alquiler INT auto_increment PRIMARY KEY,
    id_cliente INT,
    id_equipo INT,
    fecha_prestamo_alquiler DATE,
    fecha_devolucion_alquiler DATE,
    estado_alquiler VARCHAR(100),
    descripcion_alquiler VARCHAR(200),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo)
);

CREATE TABLE multa (
    id_multa INT auto_increment PRIMARY KEY,
    nombre_tipo_accidente VARCHAR(100),
    descripcion_tipo_accidente VARCHAR(200),
    precio_multa INT
);

CREATE TABLE devolucion_alquiler (
    id_devolucion_alquiler INT auto_increment PRIMARY KEY,
    id_alquiler INT NOT NULL,
    id_tipo_accidente INT,
    fecha_devolucion DATE,
    observacion_devolucion VARCHAR(80),
    FOREIGN KEY (id_alquiler) REFERENCES alquiler(id_alquiler),
    FOREIGN KEY (id_tipo_accidente) REFERENCES multa(id_multa)
);


CREATE TABLE rol (
    id_rol INT auto_increment PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL,
    descripcion_rol VARCHAR(255) DEFAULT NULL,
    estado_rol VARCHAR(20) NOT NULL DEFAULT 'Activo'
);

CREATE TABLE usuario (
    id_usuario INT auto_increment PRIMARY KEY,
    id_empleado INT NOT NULL,
    id_rol INT NOT NULL,
    usuario_usuario VARCHAR(50) NOT NULL,
    correo_usuario VARCHAR(100) DEFAULT NULL,
    contrasena_usuario VARCHAR(255) NOT NULL,
    ultimo_acceso_usuario DATETIME DEFAULT NULL,
    fecha_creacion_usuario DATE DEFAULT NULL,
    estado_usuario VARCHAR(20) DEFAULT NULL,
    token_recuperacion_usuario VARCHAR(10) DEFAULT NULL,
    fecha_expiracion_token_usuario DATETIME DEFAULT NULL,
    UNIQUE KEY uq_usuarios_empleado (id_empleado),
    CONSTRAINT fk_usuarios_empleado FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
);




