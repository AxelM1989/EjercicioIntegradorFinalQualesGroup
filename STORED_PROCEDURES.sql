/* EJERCICIO INTEGRADOR FINAL - Script con Stored Procedures de las cargas de Tablas Intermedias y Dimensiones */

USE [DW_COMERCIAL]

-- Carga tablas INT (desde STG a INT) con SP.

-- Procedure de Tabla Producto.

ALTER PROCEDURE dbo.sp_carga_int_producto
AS
BEGIN
TRUNCATE TABLE [dbo].[INT_DIM_PRODUCTO]  
INSERT INTO [dbo].[INT_DIM_PRODUCTO] (
	COD_PRODUCTO,
	DESC_PRODUCTO
	)
SELECT 
	COD_PRODUCTO,
	DESC_PRODUCTO
FROM 
	STG_DIM_PRODUCTO
END;

EXECUTE dbo.sp_carga_int_producto


-- Procedure de Tabla Categoria.

CREATE PROCEDURE dbo.sp_carga_int_categoria
AS
BEGIN
TRUNCATE TABLE [dbo].[INT_DIM_CATEGORIA]  
INSERT INTO [dbo].[INT_DIM_CATEGORIA] (
	COD_CATEGORIA,
	DESC_CATEGORIA
	)
SELECT 
	COD_CATEGORIA,
	DESC_CATEGORIA
FROM 
	STG_DIM_CATEGORIA
END;

EXECUTE dbo.sp_carga_int_categoria
SELECT * FROM INT_DIM_CATEGORIA

-- Procedure de Tabla Cliente.

CREATE PROCEDURE dbo.sp_carga_int_cliente
AS
BEGIN
TRUNCATE TABLE [dbo].[INT_DIM_CLIENTE]  
INSERT INTO [dbo].[INT_DIM_CLIENTE] (
		[COD_CLIENTE],
		[NOMBRE],
		[APELLIDO] 
		)
SELECT 
	COD_CLIENTE,
	LEFT(DESC_CLIENTE, CHARINDEX(' ', DESC_CLIENTE) ), 
	SUBSTRING(DESC_CLIENTE, CHARINDEX(' ', DESC_CLIENTE) , 30)
FROM
	STG_DIM_CLIENTE
END;

EXECUTE dbo.sp_carga_int_cliente
SELECT * FROM INT_DIM_CLIENTE


-- Procedure de Tabla Pais.

CREATE PROCEDURE dbo.sp_carga_int_pais
AS
BEGIN
TRUNCATE TABLE [dbo].[INT_DIM_PAIS]  
INSERT INTO [dbo].[INT_DIM_PAIS] (
	COD_PAIS,
	DESC_PAIS
	)
SELECT 
	COD_PAIS,
	DESC_PAIS
FROM 
	STG_DIM_PAIS
END;

EXECUTE dbo.sp_carga_int_pais
SELECT * FROM INT_DIM_PAIS


-- Procedure de Tabla Vendedor.

CREATE PROCEDURE dbo.sp_carga_int_vendedor
AS
BEGIN
TRUNCATE TABLE [dbo].[INT_DIM_VENDEDOR]  
INSERT INTO [dbo].[INT_DIM_VENDEDOR] (
		[COD_VENDEDOR],
		[NOMBRE],
		[APELLIDO] 
		)
SELECT 
	COD_VENDEDOR,
	CONCAT(SUBSTRING(DESC_VENDEDOR, 0, CHARINDEX(' ', DESC_VENDEDOR)),
	SUBSTRING(DESC_VENDEDOR, CHARINDEX(' ', DESC_VENDEDOR), 
	CHARINDEX(' ', SUBSTRING(DESC_VENDEDOR,CHARINDEX(' ', DESC_VENDEDOR) +1, 30)))) , 
	LTRIM(SUBSTRING(DESC_VENDEDOR,CHARINDEX(' ', DESC_VENDEDOR)+CHARINDEX(' ', SUBSTRING(DESC_VENDEDOR,CHARINDEX(' ', DESC_VENDEDOR) +1, 30))
	,20))
FROM
	STG_DIM_VENDEDOR
END;

EXECUTE dbo.sp_carga_int_vendedor
SELECT * FROM INT_DIM_VENDEDOR 


-- Procedure de Tabla Sucursal.

CREATE PROCEDURE dbo.sp_carga_int_sucursal
AS
BEGIN
TRUNCATE TABLE [dbo].[INT_DIM_SUCURSAL]  
INSERT INTO [dbo].[INT_DIM_SUCURSAL] (
	COD_SUCURSAL,
	DESC_SUCURSAL
	)
SELECT 
	COD_SUCURSAL,
	DESC_SUCURSAL
FROM 
	STG_DIM_SUCURSAL
END;

EXECUTE dbo.sp_carga_int_sucursal
SELECT * FROM INT_DIM_SUCURSAL


-- Procedure de Tabla de Ventas.

CREATE PROCEDURE dbo.sp_carga_int_ventas
AS
BEGIN
TRUNCATE TABLE [dbo].[INT_FACT_VENTAS]  
INSERT INTO [dbo].[INT_FACT_VENTAS] (
	[COD_PRODUCTO] ,
	[COD_CATEGORIA],
	[COD_CLIENTE] ,
	[COD_PAIS],
	[COD_VENDEDOR] ,
	[COD_SUCURSAL],
	[FECHA] ,
	[CANTIDAD_VENDIDA],
	[MONTO_VENDIDO],
	[PRECIO],
	[COMISION_COMERCIAL])
SELECT 
	CAST([COD_PRODUCTO] AS [varchar](100)) AS [COD_PRODUCTO],
	CAST([COD_CATEGORIA] AS [varchar](100)) AS [COD_CATEGORIA],
	CAST([COD_CLIENTE] AS [varchar](100)) AS [COD_CLIENTE],
	CAST([COD_PAIS] AS [varchar](100)) AS [COD_PAIS] ,
	CAST([COD_VENDEDOR] AS [varchar](100)) AS [COD_VENDEDOR],
	CAST([COD_SUCURSAL] AS [varchar](100)) AS [COD_SUCURSAL],
	CONVERT(SMALLDATETIME,[FECHA],103) AS [FECHA],
	CAST([CANTIDAD_VENDIDA] AS DECIMAL(18,2)) AS [CANTIDAD_VENDIDA],
	TRY_PARSE([MONTO_VENDIDO] AS DECIMAL(18,2) USING 'es-ES') [MONTO_VENDIDO], 
	CONVERT(DECIMAL(18,2),REPLACE([PRECIO],',','.')) AS [PRECIO],
	CAST(REPLACE(REPLACE([COMISION_COMERCIAL] ,'.',''),',','.') as decimal(18,2)) as [COMISION_COMERCIAL]
FROM 
	STG_FACT_VENTAS
END;

EXECUTE dbo.sp_carga_int_ventas
SELECT * FROM INT_FACT_VENTAS
select * from STG_FACT_VENTAS
/*
SELECT 
	CAST([COD_PRODUCTO] AS [varchar](100)) AS [COD_PRODUCTO],
	CAST([COD_CATEGORIA] AS [varchar](100)) AS [COD_CATEGORIA],
	CAST([COD_CLIENTE] AS [varchar](100)) AS [COD_CLIENTE],
	CAST([COD_PAIS] AS [varchar](100)) AS [COD_PAIS] ,
	CAST([COD_VENDEDOR] AS [varchar](100)) AS [COD_VENDEDOR],
	CAST([COD_SUCURSAL] AS [varchar](100)) AS [COD_SUCURSAL],
	CONVERT(SMALLDATETIME,[FECHA],103) AS [FECHA],
	CAST([CANTIDAD_VENDIDA] AS DECIMAL(18,2)) AS [CANTIDAD_VENDIDA],
	TRY_PARSE([MONTO_VENDIDO] AS DECIMAL(18,2) USING 'es-ES') [MONTO_VENDIDO], 
	CONVERT(DECIMAL(18,2),REPLACE([PRECIO],',','.')) AS [PRECIO],
	TRY_PARSE([COMISION_COMERCIAL] AS DECIMAL(18,2) USING 'es-ES') [COMISION_COMERCIAL] 
	
from STG_FACT_VENTAS
select *
from STG_FACT_VENTAS */



/*Tablas dimensión y Fact.*/

-- Procedure de tabla Final Dimensión Producto.


CREATE PROCEDURE sp_carga_dim_producto
@usuario VARCHAR(50)
AS 
SET NOCOUNT ON;
DECLARE @fecha DATETIME
set @fecha = GETDATE()

INSERT INTO [dbo].DIM_PRODUCTO (
    COD_PRODUCTO ,
    DESC_PRODUCTO,
    USUARIO_ALTA,
    FECHA_ALTA
)
SELECT IPR.COD_PRODUCTO ,
    IPR.DESC_PRODUCTO, 
	@usuario,
	@fecha 

    FROM [dbo].INT_DIM_PRODUCTO AS IPR
    LEFT JOIN DIM_PRODUCTO AS DP
    ON DP.COD_PRODUCTO = IPR.COD_PRODUCTO
    WHERE DP.COD_PRODUCTO IS NULL ;
UPDATE DP
		SET DP.[COD_PRODUCTO] = IPR.[COD_PRODUCTO],
			DP.[DESC_PRODUCTO] = IPR.[DESC_PRODUCTO],
			FECHA_UPDATE = @FECHA, 
			USUARIO_UPDATE = @USUARIO
		FROM [dbo].DIM_PRODUCTO DP
		INNER JOIN [dbo].INT_DIM_PRODUCTO IPR
			ON DP.[COD_PRODUCTO] = IPR.[COD_PRODUCTO]
		WHERE DP.[COD_PRODUCTO] = IPR.[COD_PRODUCTO];

EXECUTE sp_carga_dim_producto  'Moriena' -- Debe ingresar su Usuario.
SELECT * FROM DIM_PRODUCTO


-- Procedure de tabla Final Dimensión Categoria.


CREATE PROCEDURE sp_carga_dim_categoria
@usuario VARCHAR (50)
AS 
SET NOCOUNT ON;
DECLARE @fecha DATETIME
set @fecha = GETDATE()

INSERT INTO [dbo].DIM_CATEGORIA (
    COD_CATEGORIA ,
    DESC_CATEGORIA,
    USUARIO_ALTA,
    FECHA_ALTA
)
SELECT IC.COD_CATEGORIA ,
    IC.DESC_CATEGORIA, 
	@usuario,
	@fecha 

    FROM [dbo].INT_DIM_CATEGORIA AS IC
    LEFT JOIN DIM_CATEGORIA AS DC
    ON DC.COD_CATEGORIA = IC.COD_CATEGORIA
    WHERE DC.COD_CATEGORIA IS NULL ;
UPDATE DC
		SET DC.[COD_CATEGORIA] = IC.[COD_CATEGORIA],
			DC.[DESC_CATEGORIA] = IC.[DESC_CATEGORIA],
			FECHA_UPDATE = @FECHA, 
			USUARIO_UPDATE = @USUARIO
		FROM [dbo].DIM_CATEGORIA DC
		INNER JOIN [dbo].INT_DIM_CATEGORIA IC
			ON DC.[COD_CATEGORIA] = IC.[COD_CATEGORIA]
		WHERE DC.[COD_CATEGORIA] = IC.[COD_CATEGORIA];

EXECUTE sp_carga_dim_categoria 'Moriena' -- Debe ingresar su Usuario.
SELECT * FROM DIM_CATEGORIA


-- Procedure de tabla Final Dimensión Cliente


CREATE PROCEDURE sp_carga_dim_cliente
@usuario VARCHAR (50)
AS 
SET NOCOUNT ON;
DECLARE @fecha DATETIME
set @fecha = GETDATE()

INSERT INTO [dbo].DIM_CLIENTE (
    COD_CLIENTE ,
    NOMBRE,
	APELLIDO,
    USUARIO_ALTA,
    FECHA_ALTA
)
SELECT IC.COD_CLIENTE ,
    IC.NOMBRE, 
	IC.APELLIDO,
	@usuario,
	@fecha 

    FROM [dbo].INT_DIM_CLIENTE AS IC
    LEFT JOIN DIM_CLIENTE AS DC
    ON DC.COD_CLIENTE = IC.COD_CLIENTE
    WHERE DC.COD_CLIENTE IS NULL ;
UPDATE DC
		SET DC.[COD_CLIENTE] = IC.[COD_CLIENTE],
			DC.[NOMBRE] = IC.[NOMBRE],
			DC.[APELLIDO]= IC.[APELLIDO],
			FECHA_UPDATE = @FECHA, 
			USUARIO_UPDATE = @USUARIO
		FROM [dbo].DIM_CLIENTE DC
		INNER JOIN [dbo].INT_DIM_CLIENTE IC
			ON DC.[COD_CLIENTE] = IC.[COD_CLIENTE]
		WHERE DC.[COD_CLIENTE] = IC.[COD_CLIENTE];

EXECUTE sp_carga_dim_cliente 'Moriena' -- Debe ingresar su Usuario.
SELECT * FROM DIM_CLIENTE



-- Procedure de tabla Final Dimensión Pais.


CREATE PROCEDURE sp_carga_dim_pais
@usuario VARCHAR(50)
AS 
SET NOCOUNT ON;
DECLARE @fecha DATETIME
set @fecha = GETDATE()

INSERT INTO [dbo].DIM_PAIS (
    COD_PAIS ,
    DESC_PAIS,
    USUARIO_ALTA,
    FECHA_ALTA
)
SELECT IPA.COD_PAIS ,
    IPA.DESC_PAIS,
	@usuario,
	@fecha 

    FROM [dbo].INT_DIM_PAIS AS IPA
    LEFT JOIN DIM_PAIS AS DP
    ON DP.COD_PAIS = IPA.COD_PAIS
    WHERE DP.COD_PAIS IS NULL ;
UPDATE DP
		SET DP.[COD_PAIS] = IPA.[COD_PAIS],
			DP.[DESC_PAIS] = IPA.[DESC_PAIS],
			FECHA_UPDATE = @FECHA, 
			USUARIO_UPDATE = @USUARIO
		FROM [dbo].DIM_PAIS DP
		INNER JOIN [dbo].INT_DIM_PAIS IPA
			ON DP.[COD_PAIS] = IPA.[COD_PAIS]
		WHERE DP.[COD_PAIS] = IPA.[COD_PAIS];

EXECUTE sp_carga_dim_pais 'Moriena' -- Debe ingresar su Usuario.
SELECT * FROM DIM_PAIS


-- Procedure de tabla Final Dimensión Vendedor.


CREATE PROCEDURE sp_carga_dim_vendedor
@usuario VARCHAR(50)
AS 
SET NOCOUNT ON;
DECLARE @fecha DATETIME
set @fecha = GETDATE()

INSERT INTO [dbo].DIM_VENDEDOR (
    COD_VENDEDOR ,
    NOMBRE,
	APELLIDO,
    USUARIO_ALTA,
    FECHA_ALTA
)
SELECT IV.COD_VENDEDOR,
    IV.NOMBRE,
	IV.APELLIDO,
	@usuario,
	@fecha 

    FROM [dbo].INT_DIM_VENDEDOR AS IV
    LEFT JOIN DIM_VENDEDOR AS DV
    ON DV.COD_VENDEDOR = IV.COD_VENDEDOR
    WHERE DV.COD_VENDEDOR IS NULL ;
UPDATE DV
		SET DV.[COD_VENDEDOR] = IV.[COD_VENDEDOR],
			DV.[NOMBRE] = IV. [NOMBRE],
			DV.[APELLIDO] = IV. [APELLIDO],
			FECHA_UPDATE = @FECHA, 
			USUARIO_UPDATE = @USUARIO
		FROM [dbo].DIM_VENDEDOR DV
		INNER JOIN [dbo].INT_DIM_VENDEDOR IV
			ON DV.[COD_VENDEDOR] = IV.[COD_VENDEDOR]
		WHERE DV.[COD_VENDEDOR] = IV.[COD_VENDEDOR];

EXECUTE sp_carga_dim_vendedor 'Moriena' -- Debe ingresar su Usuario.
SELECT * FROM DIM_VENDEDOR


-- Procedure de tabla Final Dimensión Sucursal.


CREATE PROCEDURE sp_carga_dim_sucursal
@usuario VARCHAR(50)
AS 
SET NOCOUNT ON;
DECLARE @fecha DATETIME
set @fecha = GETDATE()

INSERT INTO [dbo].DIM_SUCURSAL (
    COD_SUCURSAL ,
    DESC_SUCURSAL,
    USUARIO_ALTA,
    FECHA_ALTA
)
SELECT ISU.COD_SUCURSAL,
    ISU.DESC_SUCURSAL,
	@usuario,
	@fecha 

    FROM [dbo].INT_DIM_SUCURSAL AS ISU
    LEFT JOIN DIM_SUCURSAL AS DS
    ON DS.COD_SUCURSAL = ISU.COD_SUCURSAL
    WHERE DS.COD_SUCURSAL IS NULL ;
UPDATE DS
		SET DS.[COD_SUCURSAL] = ISU.[COD_SUCURSAL],
			DS.[DESC_SUCURSAL] = ISU.[DESC_SUCURSAL],
			FECHA_UPDATE = @FECHA, 
			USUARIO_UPDATE = @USUARIO
		FROM [dbo].DIM_SUCURSAL DS
		INNER JOIN [dbo].INT_DIM_SUCURSAL ISU
			ON DS.[COD_SUCURSAL] = ISU.[COD_SUCURSAL]
		WHERE DS.[COD_SUCURSAL] = ISU.[COD_SUCURSAL];

EXECUTE sp_carga_dim_sucursal 'Moriena' -- Debe ingresar su Usuario.
SELECT * FROM DIM_SUCURSAL

-- Procedure de tabla Final Dimensión Tiempo.

CREATE PROCEDURE dbo.sp_dim_tiempo
	(@anio INTEGER)
AS
	SET NOCOUNT ON
	SET arithabort off
	SET arithignore on

	/**************/
	/* Variables */
	/**************/
	SET DATEFIRST 1;
	SET DATEFORMAT mdy
	DECLARE @dia smallint
	DECLARE @mes smallint
	DECLARE @f_txt varchar(10)
	DECLARE @fecha smalldatetime
	DECLARE @key int
	DECLARE @vacio smallint
	DECLARE @fin smallint
	DECLARE @fin_mes int
	DECLARE @anioperiodicidad int
	SELECT @dia = 1
	SELECT @mes = 1
	SELECT @f_txt = Convert(char(2), @mes) + '/' + Convert(char(2), @dia) + '/' + Convert(char(4), @anio)
	SELECT @fecha = Convert(smalldatetime, @f_txt)
	select @anioperiodicidad = @anio

	/************************************/
	/* Se chequea que el año a procesar */
	/* no exista en la tabla TIME       */
	/************************************/

	IF (SELECT Count(*) FROM [DW_COMERCIAL].DBO.DIM_TIEMPO WHERE anio = @anio) > 0
	BEGIN
		Print 'El año que ingreso ya existe en la tabla'
		Print 'Procedimiento CANCELADO.................'
		Return 0
	END


	/*************************/
	/* Se inserta d¡a a d¡a  */
	/* hasta terminar el año */
	/*************************/

	SELECT @fin = @anio + 1

	WHILE (@anio < @fin)
		BEGIN
		--Armo la fecha
			IF Len(Rtrim(Convert(Char(2),Datepart(mm, @fecha))))=1
			BEGIN
				IF Len(Rtrim(Convert(Char(2),Datepart(dd, @fecha))))=1
				SET @f_txt = Convert(char(4),Datepart(yyyy, @fecha)) + '0' +
				Rtrim(Convert(Char(2),Datepart(mm, @fecha))) + '0' + Rtrim(Convert(Char(2),Datepart(dd, @fecha)))
				ELSE
				SET @f_txt = Convert(char(4),Datepart(yyyy, @fecha)) + '0' +
				Rtrim(Convert(Char(2),Datepart(mm, @fecha))) + Convert(Char(2),Datepart(dd, @fecha))
			END
			ELSE
				BEGIN
				IF Len(Rtrim(Convert(Char(2),Datepart(dd, @fecha))))=1
				SET @f_txt = Convert(char(4),Datepart(yyyy, @fecha)) + Convert(Char(2),Datepart(mm,
				@fecha)) + '0' + Rtrim(Convert(Char(2),Datepart(dd, @fecha)))
				ELSE
				SET @f_txt = Convert(char(4),Datepart(yyyy, @fecha)) + Convert(Char(2),Datepart(mm,
				@fecha)) + Convert(Char(2),Datepart(dd, @fecha))
			END

	--Calculo el último día del mes
		SET @fin_mes = day(dateadd(d, -1, dateadd(m, 1, dateadd(d, - day(@fecha) + 1, @fecha))))

	INSERT [DW_COMERCIAL].DBO.DIM_TIEMPO
			(Tiempo_Key, 
			Anio, 
			MES_NRO, 
			Mes_Nombre, 
			Semestre, 
			Trimestre, 
			Semana_Anio,
			Semana_Nro_Mes,
			Dia, 
			Dia_Nombre, 
			Dia_Semana_Nro,
			FECHA_ALTA,
			USUARIO_ALTA)
	SELECT
		tiempo_key = @fecha
		, anio = Datepart(yyyy, @fecha)
		, mes = Datepart(mm, @fecha)
		, mes_nombre = 
			CASE Datename(mm, @fecha)
				when 'January' then 'Enero'
				when 'February' then 'Febrero'
				when 'March' then 'Marzo'
				when 'April' then 'Abril'
				when 'May' then 'Mayo'
				when 'June' then 'Junio'
				when 'July' then 'Julio'
				when 'August' then 'Agosto'
				when 'September' then 'Septiembre'
				when 'October' then 'Octubre'
				when 'November' then 'Noviembre'
				when 'December' then 'Diciembre'
			else Datename(mm, @fecha)
			END
		, semestre = 
			CASE Datepart(mm, @fecha)
				when (SELECT Datepart(mm, @fecha)
				WHERE Datepart(mm, @fecha) between 1 and 6) then 1
			else 2
			END
		, trimestre = Datepart(qq, @fecha)
		, semana_anio = Datepart(wk, @fecha)
		, semana_nro_mes = Datepart(wk, @fecha) - datepart(week,
							dateadd(dd,-day(@fecha)+1,@fecha)) +1
		, dia = Datepart(dd, @fecha)
		, dia_nombre =
				CASE Datename(dw, @fecha)
					when 'Monday' then 'Lunes'
					when 'Tuesday' then 'Martes'
					when 'Wednesday' then 'Miercoles'
					when 'Thursday' then 'Jueves'
					when 'Friday' then 'Viernes'
					when 'Saturday' then 'Sabado'
					when 'Sunday' then 'Domingo'
				else Datename(dw, @fecha)
				END
		, dia_semana_nro = Datepart(dw, @fecha)
				, GETDATE() , 
					'Axel'
				SELECT @fecha = Dateadd(dd, 1, @fecha)
					SELECT @dia = Datepart(dd, @fecha)
					SELECT @mes = Datepart(mm, @fecha)
					SELECT @anio = Datepart(yy, @fecha) 			 
					CONTINUE
					
END
;
SELECT * FROM DIM_TIEMPO

-- Procedure de tabla Final Fact Ventas.

CREATE PROCEDURE sp_carga_fact_ventas
AS
BEGIN
SET NOCOUNT ON;
	DECLARE @FECHA DATETIME;
	DECLARE @USUARIO VARCHAR(500);
	SET @FECHA = GETDATE();
	SET @USUARIO = 'Axel';

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
SELECT FV. * FROM 
	(SELECT 
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
		@FECHA FECHA_ALTA , 
		@USUARIO 'Axel'
	FROM [dbo].[INT_FACT_VENTAS] IFV
		INNER JOIN dbo.DIM_PRODUCTO DP
			ON DP.COD_PRODUCTO = IFV.COD_PRODUCTO
		INNER JOIN dbo.DIM_CATEGORIA DC
			ON DC.COD_CATEGORIA = IFV.COD_CATEGORIA
		INNER JOIN dbo.DIM_CLIENTE DCL
			ON DCL.COD_CLIENTE = IFV.COD_CLIENTE
		INNER JOIN dbo.DIM_PAIS DPA
			ON DPA.COD_PAIS = IFV.COD_PAIS
		INNER JOIN dbo.DIM_VENDEDOR DV
			ON DV.COD_VENDEDOR = IFV.COD_VENDEDOR
		INNER JOIN dbo.DIM_SUCURSAL DS
			ON DS.COD_SUCURSAL = IFV.COD_SUCURSAL
		INNER JOIN dbo.DIM_TIEMPO DT
			ON DT.TIEMPO_KEY = IFV.FECHA) AS FV
	WHERE NOT EXISTS (SELECT * FROM [dbo].[FACT_VENTAS] 
	   WHERE PRODUCTO_KEY = FV.PRODUCTO_KEY AND 
			CATEGORIA_KEY = FV.CATEGORIA_KEY AND 
			CLIENTE_KEY = FV.CLIENTE_KEY AND
			PAIS_KEY = FV.PAIS_KEY AND
			 VENDEDOR_KEY = FV. VENDEDOR_KEY AND
			 SUCURSAL_KEY = FV.SUCURSAL_KEY AND
			TIEMPO_KEY = FV.TIEMPO_KEY)
END


EXECUTE sp_carga_fact_ventas

SELECT * FROM FACT_VENTAS

