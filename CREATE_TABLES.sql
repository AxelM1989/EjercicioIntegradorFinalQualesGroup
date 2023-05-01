/* EJERCICIO INTEGRADOR FINAL - Script de Creación de Tablas */

-- Creación de Base de datos DW_COMERCIAL.

CREATE DATABASE DW_COMERCIAL 
USE DW_COMERCIAL

-- Tabla Staging de Producto.

CREATE TABLE [dbo].[STG_DIM_PRODUCTO](
	[COD_PRODUCTO] [varchar](500) NOT NULL,
	[DESC_PRODUCTO] [varchar](500) NOT NULL
)


-- Tabla Staging de Categoría.

CREATE TABLE [dbo].[STG_DIM_CATEGORIA](
	[COD_CATEGORIA] [varchar](500) NOT NULL,
	[DESC_CATEGORIA] [varchar](500) NOT NULL
)


-- Tabla Staging de Cliente.

CREATE TABLE [dbo].[STG_DIM_CLIENTE](
	[COD_CLIENTE] [varchar](500) NOT NULL,
	[DESC_CLIENTE] [varchar](500) NOT NULL
)


-- Tabla Staging de Pais.

CREATE TABLE [dbo].[STG_DIM_PAIS](
	[COD_PAIS] [varchar](500) NOT NULL,
	[DESC_PAIS] [varchar](500) NOT NULL
)


-- Tabla Staging de Vendedor.

CREATE TABLE [dbo].[STG_DIM_VENDEDOR](
	[COD_VENDEDOR] [varchar](500) NOT NULL,
	[DESC_VENDEDOR] [varchar](500) NOT NULL
)


-- Tabla Staging de Sucursal.

CREATE TABLE [dbo].[STG_DIM_SUCURSAL](
	[COD_SUCURSAL] [varchar](500) NOT NULL,
	[DESC_SUCURSAL] [varchar](500) NOT NULL
)


-- Tabla Staging de Ventas.

CREATE TABLE [dbo].[STG_FACT_VENTAS](
	[COD_PRODUCTO] [varchar](500) NULL,
	[COD_CATEGORIA] [varchar](500) NULL,
	[COD_CLIENTE] [varchar](500) NULL,
	[COD_PAIS] [varchar](500) NULL,
	[COD_VENDEDOR] [varchar](500) NULL,
	[COD_SUCURSAL] [varchar](500) NULL,
	[FECHA] [varchar](500) NULL,
	[CANTIDAD_VENDIDA] [varchar](500) NULL,
	[MONTO_VENDIDO] [varchar](500) NULL,
	[PRECIO] [varchar](500) NULL,
	[COMISION_COMERCIAL] [varchar](500) NULL
) 


-- Tabla Int de Producto.

CREATE TABLE [dbo].[INT_DIM_PRODUCTO](
	[COD_PRODUCTO] [varchar](500) NOT NULL,
	[DESC_PRODUCTO] [varchar](500) NOT NULL
)


-- Tabla Int de Categoría.

CREATE TABLE [dbo].[INT_DIM_CATEGORIA](
	[COD_CATEGORIA] [varchar](500) NOT NULL,
	[DESC_CATEGORIA] [varchar](500) NOT NULL
)


-- Tabla Int de Cliente.

CREATE TABLE [dbo].[INT_DIM_CLIENTE](
	[COD_CLIENTE] [varchar](500) NOT NULL,
	[NOMBRE] [varchar](500) NOT NULL,
	[APELLIDO] [varchar](500) NOT NULL
)


-- Tabla Int de Pais.

CREATE TABLE [dbo].[INT_DIM_PAIS](
	[COD_PAIS] [varchar](3) NOT NULL,
	[DESC_PAIS] [varchar](500) NOT NULL
)


-- Tabla Int de Vendedor.

CREATE TABLE [dbo].[INT_DIM_VENDEDOR](
	[COD_VENDEDOR] [varchar](500) NOT NULL,
	[NOMBRE] [varchar](500) NOT NULL,
	[APELLIDO] [varchar](500) NOT NULL
)


-- Tabla Int de Sucursal.

CREATE TABLE [dbo].[INT_DIM_SUCURSAL](
	[COD_SUCURSAL] [varchar](500) NOT NULL,
	[DESC_SUCURSAL] [varchar](500) NOT NULL
)


-- Tabla Int de Ventas.

CREATE TABLE [dbo].[INT_FACT_VENTAS](
	[COD_PRODUCTO] [varchar](100) NULL,
	[COD_CATEGORIA] [varchar](100) NULL,
	[COD_CLIENTE] [varchar](100) NULL,
	[COD_PAIS] [varchar](100) NULL,
	[COD_VENDEDOR] [varchar](100) NULL,
	[COD_SUCURSAL] [varchar](100) NULL,
	[FECHA] SMALLDATETIME,
	[CANTIDAD_VENDIDA] DECIMAL(18,2) NULL,
	[MONTO_VENDIDO] DECIMAL(18,2) NULL,
	[PRECIO] DECIMAL(18,2) NULL,
	[COMISION_COMERCIAL] DECIMAL(18,2) NULL
) 


-- Tabla Dimensión Producto.

CREATE TABLE [dbo].[DIM_PRODUCTO](
	[PRODUCTO_KEY] Integer PRIMARY KEY IDENTITY (1,1),
	[COD_PRODUCTO] [varchar](500) NOT NULL,
	[DESC_PRODUCTO] [varchar](500) NOT NULL,
	[FECHA_ALTA] Datetime,
	[USUARIO_ALTA] Varchar(500),
	[FECHA_UPDATE] Datetime,
	[USUARIO_UPDATE] Varchar(500)
)


-- Tabla Dimensión Categoría.

CREATE TABLE [dbo].[DIM_CATEGORIA](
	[CATEGORIA_KEY] Integer PRIMARY KEY IDENTITY (1,1),
	[COD_CATEGORIA] [varchar](500) NOT NULL,
	[DESC_CATEGORIA] [varchar](500) NOT NULL,
	[FECHA_ALTA] Datetime,
	[USUARIO_ALTA] Varchar(500),
	[FECHA_UPDATE] Datetime,
	[USUARIO_UPDATE] Varchar(500)
)


-- Tabla Dimensión Cliente.

CREATE TABLE [dbo].[DIM_CLIENTE](
	[CLIENTE_KEY] Integer PRIMARY KEY IDENTITY (1,1),
	[COD_CLIENTE] [varchar](500) NOT NULL,
	[NOMBRE] [varchar](500) NOT NULL,
	[APELLIDO] [varchar](500) NOT NULL,
	[FECHA_ALTA] Datetime,
	[USUARIO_ALTA] Varchar(500),
	[FECHA_UPDATE] Datetime,
	[USUARIO_UPDATE] Varchar(500)
)


-- Tabla Dimensión Pais.

CREATE TABLE [dbo].[DIM_PAIS](
	[PAIS_KEY] Integer PRIMARY KEY IDENTITY (1,1),
	[COD_PAIS] [varchar](3) NOT NULL,
	[DESC_PAIS] [varchar](500) NOT NULL,
	[FECHA_ALTA] Datetime,
	[USUARIO_ALTA] Varchar(500),
	[FECHA_UPDATE] Datetime,
	[USUARIO_UPDATE] Varchar(500)
)


-- Tabla Dimensión Vendedor.

CREATE TABLE [dbo].[DIM_VENDEDOR](
	[VENDEDOR_KEY] Integer PRIMARY KEY IDENTITY (1,1),
	[COD_VENDEDOR] [varchar](500) NOT NULL, -- Chequear que figura como integer, por lo que habría que sacarle la V, o será un error?
	[NOMBRE] [varchar](500) NOT NULL,
	[APELLIDO] [varchar](500) NOT NULL,
	[FECHA_ALTA] Datetime,
	[USUARIO_ALTA] Varchar(500),
	[FECHA_UPDATE] Datetime,
	[USUARIO_UPDATE] Varchar(500)
)


-- Tabla Dimensión Sucursal.

CREATE TABLE [dbo].[DIM_SUCURSAL](
	[SUCURSAL_KEY] Integer PRIMARY KEY IDENTITY (1,1),
	[COD_SUCURSAL] [varchar](500) NOT NULL,
	[DESC_SUCURSAL] [varchar](500) NOT NULL,
	[FECHA_ALTA] Datetime,
	[USUARIO_ALTA] Varchar(500),
	[FECHA_UPDATE] Datetime,
	[USUARIO_UPDATE] Varchar(500)
)


-- Tabla Dimensión Tiempo.


CREATE TABLE DIM_TIEMPO (

[TIEMPO_KEY] smalldatetime PRIMARY KEY,
[ANIO] integer,
[MES_NRO] integer,
[MES_NOMBRE] varchar(15),
[SEMESTRE] integer,
[TRIMESTRE] integer,
[SEMANA_ANIO] integer,
[SEMANA_NRO_MES] integer,
[DIA] integer,
[DIA_NOMBRE] varchar(20),
[DIA_SEMANA_NRO] integer,
[FECHA_ALTA] Datetime,
[USUARIO_ALTA] Varchar(500),
[FECHA_UPDATE] Datetime,
[USUARIO_UPDATE] Varchar(500))


-- Tabla Fact (de Hecho) Ventas. Las claves foráneas luego con un Alter Table.

CREATE TABLE [dbo].[FACT_VENTAS](
	[PRODUCTO_KEY] Integer NOT NULL,
	[CATEGORIA_KEY] Integer NOT NULL,
	[CLIENTE_KEY] Integer NOT NULL,
	[PAIS_KEY] Integer NOT NULL,
	[VENDEDOR_KEY] Integer NOT NULL,
	[SUCURSAL_KEY] Integer NOT NULL,
	[TIEMPO_KEY] SMALLDATETIME,
	[CANTIDAD_VENDIDA] DECIMAL(18,2) NULL,
	[MONTO_VENDIDO] DECIMAL(18,2) NULL,
	[PRECIO] DECIMAL(18,2) NULL,
	[COMISION_COMERCIAL] DECIMAL(18,2) NULL,
	[FECHA_ALTA] Datetime,
	[USUARIO_ALTA] Varchar(500),
) 
