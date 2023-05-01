/* EJERCICIO INTEGRADOR FINAL - Script de Inserts iniciales de las tablas Dimensiones */

USE DW_COMERCIAL

-- Las tablas STG fueron generadas con la herramienta de importar datos de SQL SERVER.

-- Los Insert de las tablas int fueron ejecutados con Procedimientos, por lo que se transcribirán los execute de cada una de ellas.

EXECUTE dbo.sp_carga_int_producto

EXECUTE dbo.sp_carga_int_categoria

EXECUTE dbo.sp_carga_int_cliente

EXECUTE dbo.sp_carga_int_pais

EXECUTE dbo.sp_carga_int_vendedor

EXECUTE dbo.sp_carga_int_sucursal

EXECUTE dbo.sp_carga_int_ventas



-- Insert de tabla Dimensión Producto. Creados a través de Inserts para el Script que pedían. A su vez en los scripts de Procedure de actualización de las tablas
-- de Dimensión también están los Insert para que controle que no estén ya cargados o sino se carguen nuevos (como actualización).

-- Primero, chequeamos que no haya duplicados.

SELECT COD_PRODUCTO, DESC_PRODUCTO
FROM INT_DIM_PRODUCTO
GROUP BY COD_PRODUCTO, DESC_PRODUCTO
HAVING COUNT(*)>1

-- Al no haber duplicados, procedemos a insertar los datos en la tabla DIM_PRODUCTO.

INSERT INTO [dbo].[DIM_PRODUCTO](
COD_PRODUCTO,
DESC_PRODUCTO,
FECHA_ALTA,
USUARIO_ALTA)
SELECT  IPR.COD_PRODUCTO, IPR.DESC_PRODUCTO, GETDATE() , 'Axel'
FROM [dbo].[INT_DIM_PRODUCTO] IPR
LEFT JOIN [dbo].[DIM_PRODUCTO] AS DP ON IPR.COD_PRODUCTO = DP.COD_PRODUCTO
WHERE DP.COD_PRODUCTO IS NULL;
SELECT * FROM DIM_PRODUCTO

-- Insert de tabla Dimensión Categoría. Primero chequeamos que no haya duplicados.

SELECT COD_CATEGORIA, DESC_CATEGORIA
FROM INT_DIM_CATEGORIA
GROUP BY COD_CATEGORIA, DESC_CATEGORIA
HAVING COUNT(*)>1

-- Al no haber duplicados, procedemos a insertar los datos en la tabla DIM_CATEGORIA.

INSERT INTO [dbo].[DIM_CATEGORIA](
COD_CATEGORIA,
DESC_CATEGORIA,
FECHA_ALTA,
USUARIO_ALTA)
SELECT  IC.COD_CATEGORIA, IC.DESC_CATEGORIA, GETDATE() , 'Axel'
FROM [dbo].[INT_DIM_CATEGORIA] IC
LEFT JOIN [dbo].[DIM_CATEGORIA] AS DC ON IC.COD_CATEGORIA = DC.COD_CATEGORIA
WHERE DC.COD_CATEGORIA IS NULL;
SELECT * FROM DIM_CATEGORIA


-- Insert de tabla Dimensión Cliente. Primero chequeamos que no haya duplicados.

SELECT COD_CLIENTE, NOMBRE, APELLIDO
FROM INT_DIM_CLIENTE
GROUP BY COD_CLIENTE, NOMBRE, APELLIDO
HAVING COUNT(*)>1

-- Al no haber duplicados, procedemos a insertar los datos en la tabla DIM_CLIENTE.

INSERT INTO [dbo].[DIM_CLIENTE](
COD_CLIENTE,
NOMBRE,
APELLIDO,
FECHA_ALTA,
USUARIO_ALTA)
SELECT  IC.COD_CLIENTE, IC.NOMBRE, IC.APELLIDO, GETDATE() , 'Axel'
FROM [dbo].[INT_DIM_CLIENTE] IC
LEFT JOIN [dbo].[DIM_CLIENTE] AS DC ON IC.COD_CLIENTE = DC.COD_CLIENTE
WHERE DC.COD_CLIENTE IS NULL;
SELECT * FROM DIM_CLIENTE


-- Insert de tabla Dimensión Pais. Primero chequeamos que no haya duplicados.

SELECT COD_PAIS, DESC_PAIS
FROM INT_DIM_PAIS
GROUP BY COD_PAIS, DESC_PAIS
HAVING COUNT(*)>1

-- Al no haber duplicados, procedemos a insertar los datos en la tabla DIM_PAIS.

INSERT INTO [dbo].[DIM_PAIS](
COD_PAIS,
DESC_PAIS,
FECHA_ALTA,
USUARIO_ALTA)
SELECT  IPP.COD_PAIS, IPP.DESC_PAIS, GETDATE() , 'Axel'
FROM [dbo].[INT_DIM_PAIS] IPP
LEFT JOIN [dbo].[DIM_PAIS] AS DP ON IPP.COD_PAIS = DP.COD_PAIS
WHERE DP.COD_PAIS IS NULL;
SELECT * FROM DIM_PAIS


-- Insert de tabla Dimensión Vendedor. Primero chequeamos que no haya duplicados.

SELECT COD_VENDEDOR, NOMBRE, APELLIDO
FROM INT_DIM_VENDEDOR
GROUP BY COD_VENDEDOR, NOMBRE, APELLIDO
HAVING COUNT(*)>1

-- Al no haber duplicados, procedemos a insertar los datos en la tabla DIM_VENDEDOR.


INSERT INTO [dbo].[DIM_VENDEDOR](
COD_VENDEDOR,
NOMBRE,
APELLIDO,
FECHA_ALTA,
USUARIO_ALTA)
SELECT  IV.COD_VENDEDOR, IV.NOMBRE,IV.APELLIDO, GETDATE() , 'Axel'
FROM [dbo].[INT_DIM_VENDEDOR] IV
LEFT JOIN [dbo].[DIM_VENDEDOR] AS DV ON IV.COD_VENDEDOR = DV.COD_VENDEDOR
WHERE DV.COD_VENDEDOR IS NULL;
SELECT * FROM DIM_VENDEDOR


-- Insert de tabla Dimensión Sucursal. Primero chequeamos que no haya duplicados.

SELECT COD_SUCURSAL, DESC_SUCURSAL
FROM INT_DIM_SUCURSAL
GROUP BY COD_SUCURSAL, DESC_SUCURSAL
HAVING COUNT(*)>1

-- Al no haber duplicados, procedemos a insertar los datos en la tabla DIM_SUCURSAL.

INSERT INTO [dbo].[DIM_SUCURSAL](
COD_SUCURSAL,
DESC_SUCURSAL,
FECHA_ALTA,
USUARIO_ALTA)
SELECT  ISU.COD_SUCURSAL, ISU.DESC_SUCURSAL, GETDATE() , 'Axel'
FROM [dbo].[INT_DIM_SUCURSAL] ISU
LEFT JOIN [dbo].[DIM_SUCURSAL] AS DS ON ISU.COD_SUCURSAL = DS.COD_SUCURSAL
WHERE DS.COD_SUCURSAL IS NULL;
SELECT * FROM DIM_SUCURSAL

-- Consulta para saber años mínimos y máximos de la base de datos.
SELECT MIN (YEAR(FECHA)) FECHAMINIMA, MAX (YEAR(FECHA)) FECHAMAXIMA FROM [DW_COMERCIAL].[dbo].[INT_FACT_VENTAS];

-- Ejecución de procedimientos de carga de tabla Dimensión Tiempo. Desde 2016 hasta 2021 (que son las fechas mínimas y máximas que se van a encontrar
-- en la tabla). A medida que se sigan sumando datos y años, se ejecutará nuevamente este procedimiento con los años a agregar.

EXECUTE dbo.sp_dim_tiempo 2016
EXECUTE dbo.sp_dim_tiempo 2017
EXECUTE dbo.sp_dim_tiempo 2018
EXECUTE dbo.sp_dim_tiempo 2019
EXECUTE dbo.sp_dim_tiempo 2020
EXECUTE dbo.sp_dim_tiempo 2021
SELECT * FROM DIM_TIEMPO

-- Insert de tabla Fact Ventas. Primero chequeamos que no haya duplicados.

SELECT COD_PRODUCTO, COD_CATEGORIA, COD_CLIENTE, COD_PAIS, COD_VENDEDOR,COD_SUCURSAL, FECHA, CANTIDAD_VENDIDA, MONTO_VENDIDO, PRECIO, COMISION_COMERCIAL
FROM INT_FACT_VENTAS
GROUP BY COD_PRODUCTO, COD_CATEGORIA, COD_CLIENTE, COD_PAIS, COD_VENDEDOR,COD_SUCURSAL, FECHA, CANTIDAD_VENDIDA, MONTO_VENDIDO, PRECIO, COMISION_COMERCIAL
HAVING COUNT(*)>1

-- Al no haber duplicados, procedemos a insertar los datos en la tabla FACT_VENTAS.

-- Hay que considerar que los registros de las ventas no están ordenados y para ello, primero se va a generar una VISTA, como se menciona en el archivo 
-- AXEL_MORIENA_DW_COMERCIAL_SUPUESTOS.docx, ya que en un INSERT no se puede utilizar cláusula ORDEN BY.

CREATE VIEW VENTAS AS 
SELECT TOP(12000)
	COD_PRODUCTO,
	COD_CATEGORIA,
	COD_CLIENTE,
	COD_PAIS,
	COD_VENDEDOR,
	COD_SUCURSAL,
	FECHA,
	CANTIDAD_VENDIDA,
	MONTO_VENDIDO,
	PRECIO,
	COMISION_COMERCIAL
FROM [dbo].[INT_FACT_VENTAS] 
ORDER BY FECHA
SELECT * FROM VENTAS

-- Se creará otra vista con los valores negativos de las ventas (en Monto Vendido y Precio) ya que es un valor incorrecto y se debe cargar como positivo.

CREATE VIEW VENTASNEG AS 
SELECT TOP(12000)
	COD_PRODUCTO,
	COD_CATEGORIA,
	COD_CLIENTE,
	COD_PAIS,
	COD_VENDEDOR,
	COD_SUCURSAL,
	FECHA,
	CANTIDAD_VENDIDA,
	MONTO_VENDIDO *-1 MONTO_VENDIDO,
	PRECIO*-1 PRECIO,
	COMISION_COMERCIAL
FROM [dbo].[INT_FACT_VENTAS] 
WHERE MONTO_VENDIDO <0
ORDER BY FECHA

-- Se cargan los 18 registros en negativo de la tabla INT_FACT_VENTAS y se las multiplica por (-1) para que quede en positivo y ya nos quedan guardados
-- esos registros correctos.

SELECT * FROM VENTASNEG


-- Aplicamos ahora si el INSERT, en ésta primera instancia, en vez de realizarla con la tabla INT_FACT_VENTAS, se realizará a través de la VISTA VENTAS.

INSERT INTO [dbo].[FACT_VENTAS](
	PRODUCTO_KEY,
	CATEGORIA_KEY,
	CLIENTE_KEY,
	PAIS_KEY,
	VENDEDOR_KEY,
	SUCURSAL_KEY,
	TIEMPO_KEY,
	CANTIDAD_VENDIDA,
	MONTO_VENDIDO,
	PRECIO,
	COMISION_COMERCIAL,
	FECHA_ALTA,
	USUARIO_ALTA
	)
SELECT 
	PRODUCTO_KEY,
	CATEGORIA_KEY,
	CLIENTE_KEY,
	PAIS_KEY,
	VENDEDOR_KEY,
	SUCURSAL_KEY,
	TIEMPO_KEY,
	CANTIDAD_VENDIDA,
	MONTO_VENDIDO,
	PRECIO,
	COMISION_COMERCIAL,
	GETDATE() , 
	'Axel'
FROM [dbo].[VENTAS] VV
	INNER JOIN dbo.DIM_PRODUCTO DP
		ON DP.COD_PRODUCTO = VV.COD_PRODUCTO
	INNER JOIN dbo.DIM_CATEGORIA DC
		ON DC.COD_CATEGORIA = VV.COD_CATEGORIA
	INNER JOIN dbo.DIM_CLIENTE DCL
		ON DCL.COD_CLIENTE = VV.COD_CLIENTE
	INNER JOIN dbo.DIM_PAIS DPA
		ON DPA.COD_PAIS = VV.COD_PAIS
	INNER JOIN dbo.DIM_VENDEDOR DV
		ON DV.COD_VENDEDOR = VV.COD_VENDEDOR
	INNER JOIN dbo.DIM_SUCURSAL DS
		ON DS.COD_SUCURSAL = VV.COD_SUCURSAL
	INNER JOIN dbo.DIM_TIEMPO DT
		ON DT.TIEMPO_KEY = VV.FECHA

-- Luego eliminamos los valores en negativo, nos queda la tabla FACT_VENTAS con 18 valores menos.
DELETE  FACT_VENTAS
WHERE MONTO_VENDIDO < 0

-- Por último, volvemos a insertar a través de la nueva vista, VENTASNEG, que cambia el signo a estos valores negativos, los 18 registros restantes
-- que se habían eliminado por ser negativos.

INSERT INTO [dbo].[FACT_VENTAS](
	PRODUCTO_KEY,
	CATEGORIA_KEY,
	CLIENTE_KEY,
	PAIS_KEY,
	VENDEDOR_KEY,
	SUCURSAL_KEY,
	TIEMPO_KEY,
	CANTIDAD_VENDIDA,
	MONTO_VENDIDO,
	PRECIO,
	COMISION_COMERCIAL,
	FECHA_ALTA,
	USUARIO_ALTA
	)
SELECT 
	PRODUCTO_KEY,
	CATEGORIA_KEY,
	CLIENTE_KEY,
	PAIS_KEY,
	VENDEDOR_KEY,
	SUCURSAL_KEY,
	TIEMPO_KEY,
	CANTIDAD_VENDIDA,
	MONTO_VENDIDO,
	PRECIO,
	COMISION_COMERCIAL,
	GETDATE() , 
	'Axel'
FROM [dbo].[VENTASNEG] VV
	INNER JOIN dbo.DIM_PRODUCTO DP
		ON DP.COD_PRODUCTO = VV.COD_PRODUCTO
	INNER JOIN dbo.DIM_CATEGORIA DC
		ON DC.COD_CATEGORIA = VV.COD_CATEGORIA
	INNER JOIN dbo.DIM_CLIENTE DCL
		ON DCL.COD_CLIENTE = VV.COD_CLIENTE
	INNER JOIN dbo.DIM_PAIS DPA
		ON DPA.COD_PAIS = VV.COD_PAIS
	INNER JOIN dbo.DIM_VENDEDOR DV
		ON DV.COD_VENDEDOR = VV.COD_VENDEDOR
	INNER JOIN dbo.DIM_SUCURSAL DS
		ON DS.COD_SUCURSAL = VV.COD_SUCURSAL
	INNER JOIN dbo.DIM_TIEMPO DT
		ON DT.TIEMPO_KEY = VV.FECHA

-- Ahora se observa que no quedan valores negativos en los montos ni los precios.

SELECT * FROM FACT_VENTAS
WHERE MONTO_VENDIDO<0 OR PRECIO <0


-- Al ya tener la primera carga creada, luego se utilizarán Stored Procedures para la recarga de la tabla. Por lo tanto se realizará el siguiente EXECUTE,
-- que en el caso de tener duplicados, no nos dejará cargar. Y si es un dato nuevo, cargará en los siguientes registros y ya estarían ordenados por fecha.

EXECUTE sp_carga_fact_ventas

SELECT * FROM FACT_VENTAS
