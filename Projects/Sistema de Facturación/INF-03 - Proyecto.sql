/*
	Curso: Fundamentos de Base de Datos 1 (INF-03)
	Autores: Pablo Bonilla y Angelica Saenz
	Última modificación: 8/17/2018
*/

--Creación de base de datos:
	CREATE DATABASE SistemaFacturacion;
	GO

--Selección:
	USE SistemaFacturacion;
	GO



--Creación de tablas:
	CREATE TABLE Proveedor (
		cedProveedor char(15) PRIMARY KEY,
		nombre varchar(100) NOT NULL,
		telefono char(15) NOT NULL,
		direccion varchar(200) NOT NULL
	);

	CREATE TABLE Articulo (
		codArticulo char(10) PRIMARY KEY,
		descripcion varchar(200) NOT NULL,
		costoUnitario money NOT NULL,
		precioUnitario money NOT NULL,
		estado char(1) NOT NULL,
		codBarras int UNIQUE NOT NULL,
	
		cedProveedor char(15) NOT NULL,
		numCategoria int NOT NULL
	);

	CREATE TABLE Categoria (
		numCategoria int PRIMARY KEY,
		descripcion varchar(150)
	);

	CREATE TABLE ArticuloXFactura (
		codArticulo char(10) NOT NULL,
		numFactura int NOT NULL,
		precioUnitario money NOT NULL,
		cantLineas int NOT NULL,
		PRIMARY KEY (codArticulo, numFactura)
	);

	CREATE TABLE Factura (
		numFactura int IDENTITY(1,1) PRIMARY KEY,
		descripcion varchar(200),
		estado char(1) NOT NULL,
		montoTotal money NOT NULL,
		fechaConfeccion date NOT NULL,
		cantLineas int NOT NULL,
	
		idDescuento int,
		codEmpleado char(10) NOT NULL,
		cedCliente char(15) NOT NULL,
		idTipoFactura int NOT NULL
	);

	CREATE TABLE TipoFactura (
		idTipoFactura int IDENTITY(1,1) PRIMARY KEY,
		descripcion varchar(100) NOT NULL
	);

	CREATE TABLE Empleado (
		codEmpleado char(10) PRIMARY KEY,
		nombre varchar(100) NOT NULL,
		apellido varchar(100) NOT NULL,
		genero char(1) NOT NULL,
		fechaContratacion date NOT NULL,
		calificacion int NOT NULL
		
	);

	CREATE TABLE Descuento (
		idDescuento int IDENTITY(1,1) PRIMARY KEY,
		descripcion varchar(100) NOT NULL,
		porcentaje decimal(5,2) NOT NULL
	);	

	CREATE TABLE Cliente (
		cedCliente char(15) PRIMARY KEY,
		nombre varchar(100) NOT NULL,
		apellido varchar(100) NOT NULL,
		genero char(1) NOT NULL,
		direccion varchar(200) NOT NULL,
		telefono char(15) NOT NULL,

		idRegion int NOT NULL
	);

	CREATE TABLE Region (
		idRegion int IDENTITY(1,1) PRIMARY KEY,
		descripcion varchar(200) NOT NULL
	);



--Constraints:
	--Foreign keys:
		ALTER TABLE Cliente
		ADD CONSTRAINT FK_Cliente_idRegion
		FOREIGN KEY (idRegion) REFERENCES Region(idRegion);

		
		ALTER TABLE ArticuloXFactura
		ADD CONSTRAINT FK_ArticuloXFactura_codArticulo
		FOREIGN KEY (codArticulo) REFERENCES Articulo(codArticulo);

		ALTER TABLE ArticuloXFactura
		ADD CONSTRAINT FK_ArticuloXFactura_numFactura
		FOREIGN KEY (numFactura) REFERENCES Factura(numFactura);
		
		ALTER TABLE Articulo
		ADD CONSTRAINT FK_Articulo_cedProveedor
		FOREIGN KEY (cedProveedor) REFERENCES Proveedor(cedProveedor);

		ALTER TABLE Articulo
		ADD CONSTRAINT FK_Articulo_numCategoria
		FOREIGN KEY (numCategoria) REFERENCES Categoria(numCategoria);
		 
		ALTER TABLE Factura
		ADD CONSTRAINT FK_Factura_codEmpleado
		FOREIGN KEY (codEmpleado) REFERENCES Empleado(codEmpleado);

		ALTER TABLE Factura
		ADD CONSTRAINT FK_Factura_idDescuento
		FOREIGN KEY (idDescuento) REFERENCES Descuento(idDescuento);

		ALTER TABLE Factura
		ADD CONSTRAINT FK_Factura_cedCliente
		FOREIGN KEY (cedCliente) REFERENCES Cliente(cedCliente);

		ALTER TABLE Factura
		ADD CONSTRAINT FK_Factura_idFactura
		FOREIGN KEY (idTipoFactura) REFERENCES TipoFactura(idTipoFactura);
	
	--Checks:	
		ALTER TABLE Empleado
		ADD CONSTRAINT CHK_Empleado_genero CHECK (genero = 'M' OR genero = 'F');

		ALTER TABLE Cliente
		ADD CONSTRAINT CHK_Cliente_genero CHECK (genero = 'M' OR genero = 'F');
	
		ALTER TABLE Articulo
		ADD CONSTRAINT CHK_Articulo_estado CHECK (estado = 'A' OR estado = 'I');

		ALTER TABLE Factura
		ADD CONSTRAINT CHK_Factura_estado CHECK (estado = 'A' OR estado = 'C');

		ALTER TABLE Region
		ADD CONSTRAINT CHK_Region_descripcion CHECK (descripcion = 'Central' OR descripcion = 'Norte' OR deScripcion = 'Sur');

		ALTER TABLE Descuento
		ADD CONSTRAINT CHK_Descuento_porcentaje CHECK (porcentaje = 5 OR porcentaje = 10);

 --Inserts:
	INSERT INTO Proveedor(cedProveedor, nombre, telefono, direccion) VALUES
		(1, 'Carniceria Reyes', '2525-7744', 'Curridabat, San Jose'),
		(2, 'Verduras CR', '2399-9427', 'La Union, Cartago'),
		(3, 'Super Frutas', '7730-9842', 'Puerto Viejo, Limon'),
		(4, 'Dulces Sanos', '5542-4805', 'Cañas, Alajuela')

	INSERT INTO Categoria(numCategoria, descripcion) VALUES
		(1, 'Carnes'),
		(2, 'Verduras'),
		(3, 'Frutas'),
		(4, 'Postres'),
		(5, 'Prueba')

	INSERT INTO Articulo(codArticulo, descripcion, costoUnitario, precioUnitario, codBarras, estado, cedProveedor, numCategoria) VALUES
		(21, 'Articulo de prueba', 100, 175, 2, 'A', 1, 5),
		(1, 'Chorizo de cerdo', 100, 175, 1001, 'A', 1, 1),
		(2, 'Muslo de pollo', 500, 725, 1002, 'A', 1, 1),
		(3, 'Chuleta de cerdo', 600, 1000, 1003, 'A', 1, 1),
		(4, 'Filete tilapia', 600, 1000, 1004, 'A', 1, 1),
		(5, 'Lomito de res', 1500, 2500, 1005, 'A', 1, 1),
		(6, 'Papa', 300, 450, 2001, 'A', 2, 2),
		(7, 'Yuca', 600, 800, 2002, 'A', 2, 2),
		(8, 'Zanahoria', 200, 300, 2003, 'A', 2, 2),
		(9, 'Chayote', 400, 600, 2004, 'A', 2, 2),
		(10, 'Elote', 550, 800, 2005, 'A', 2, 2),
		(11, 'Pera', 200, 400, 3001, 'A', 3, 3),
		(12, 'Manzana Roja', 150, 250, 3002, 'A', 3, 3),
		(13, 'Banano', 75, 150, 3003, 'A', 3, 3),
		(14, 'Sandia', 400, 900, 3004, 'A', 3, 3),
		(15, 'Limon dulce', 50, 100, 3005, 'A', 3, 3),
		(16, 'Alfajor', 250, 500, 4001, 'A', 4, 4),
		(17, 'Tres leches', 1000, 1500, 4002, 'A', 4, 4),
		(18, 'Flan de vainilla', 700, 1000, 4003, 'A', 4, 4),
		(19, 'Torta chilena', 1500, 2500, 4004, 'A', 4, 4),
		(20, 'Helado de chocolate', 700, 1100, 4005, 'A', 4, 4)

	INSERT INTO TipoFactura(descripcion) VALUES
		('Credito'),
		('Contado')

	INSERT INTO Descuento(descripcion, porcentaje) VALUES
		('Regular', 5),
		('Preferencial', 10)

	INSERT INTO Empleado(codEmpleado, nombre, apellido, genero, fechaContratacion, calificacion) VALUES
		(11111, 'Juan', 'Brenes', 'M', '2010-01-01', 0),
		(22222, 'Andrea', 'Vargas', 'F', '2010-11-21', 0),
		(33333, 'Kevin', 'Jones', 'M', '2015-06-15', 0),
		(44444, 'Veronica', 'Alvarado', 'F', '2008-04-02', 0),
		(55555, 'Marian', 'Torres', 'F', '2012-07-05', 0),
		(66666, 'Pablo', 'Bonilla', 'M', '2012-06-04', 0)

	INSERT INTO Region(descripcion) VALUES
		('Central'),
		('Norte'),
		('Sur')

	INSERT INTO Cliente(cedCliente, nombre, apellido, genero, direccion, telefono, idRegion) VALUES
		(1, 'Daniel', 'Benavides', 'M', 'San Jose', '8821-3248', 2),
		(2, 'Pablo', 'Bonilla', 'M', 'Alajuela', '8363-4212', 1),
		(3, 'Sebastian', 'Chacon', 'M', 'Cartago', '7034-7372', 3),
		(4, 'Daniel', 'Herrera', 'M', 'Heredia', '3623-4328', 2),
		(5, 'Maria', 'Mansilla', 'F', 'Heredia', '3673-4234', 1),
		(6, 'Maria', 'Monge', 'F', 'Guanacaste', '8767-9878', 3),
		(7, 'Andres', 'Osante', 'M', 'Limon', '8090-2313', 2),
		(8, 'Alexander', 'Ramirez', 'M', 'San Jose', '3834-4921', 2),
		(9, 'Silvia', 'Rodriguez', 'F', 'Alajuela', '8043-8363', 3),
		(10, 'Angelica', 'Saenz', 'F', 'Cartago', '7333-9472', 2),
		(11, 'Jeison', 'Sandoval', 'M', 'Heredia', '8002-9329', 1),
		(12, 'Isaac','Soto', 'M', 'Puntarenas', '8353-7361', 3),
		(13, 'Ricardo', 'Treminio', 'M', 'Guanacaste', '3898-9937', 2),
		(14, 'Israel', 'Umaña', 'M', 'Limon', '3331-1193', 1),
		(15, 'Denilson', 'Vargas', 'M', 'San Jose', '3891-0098', 3),
		(16, 'Karol', 'Vargas', 'F', 'Alajuela', '8991-9380', 2),
		(17, 'Eduardo', 'Zeledon', 'M', 'Cartago', '8081-0391', 1)

	INSERT INTO Factura(descripcion, estado, montoTotal, fechaConfeccion, cantLineas, idDescuento, codEmpleado, cedCliente, idTipoFactura) VALUES
			('', 'A', 0, '2018-07-26', 0, NULL, 11111, 1, 1), --Lomito de res, Filete tilapia, Chuleta de cerdo, Muslo de pollo, Chorizo de cerdo
			('', 'A', 0, '2018-02-12', 0, 1, 44444, 2, 1), --Chorizo de cerdo, Chuleta de cerdo, Yuca, Pera, Manzana Roja
			('', 'A', 0, '2018-05-20', 0, 2, 22222, 12, 2), --Banano, Limon dulce, Sandia, Papa, Alfajor
			('', 'A', 0, '2018-01-27', 0, NULL, 44444, 17, 1), --Manzana roja, Elote, Tortachilena, Tres leches, Helado de chocolate
			('', 'A', 0, '2018-12-12', 0, 2, 11111, 11, 2),  --Flan de vainilla, Papa, Filete de tilapia, Pera, Manzana roja
			('', 'A', 0, '2018-10-09', 0, 1, 55555, 16, 1), --Muslo de pollo, Helado de chocolate, Chorizo de cerdo, Lomito de res, Yuca
			('', 'A', 0, '2018-03-10', 0, NULL, 33333, 7, 2), --Zanahoria, Chuleta de cerdo, Tres leches, Banano, Sandia
			('', 'A', 0, '2018-04-17', 0, 1, 33333, 9, 1), --Pera, Yuca, Limon dulce, Banano, Papa
			('', 'A', 0, '2018-10-15', 0, 2, 44444, 14, 2), --Alfajor, Torta chilena, Limon dulce, Pera, Elote
			('', 'A', 0, '2018-08-08', 0, NULL, 44444, 5, 1), --Lomito de res, Chorizo de cerdo, Flan de vainilla, Muslo de pollo, Torta chilena
			('', 'A', 0, '2018-01-29', 0, 2, 55555, 4, 1), --Chayote, Flan de vanilla, Helado de Chocolate, Elote, Pera
			('', 'A', 0, '2018-06-13', 0, NULL, 11111, 6, 2), --Zanahoria, Pera, Banano, Manzana Roja, Sandia
			('', 'A', 0, '2018-11-11', 0, 1, 22222, 15, 1),  --Yuca, Filete de tilapia, Zanahoria, Chuleta de cerdo, Chayote
			('', 'A', 0, '2018-04-12', 0, 2, 22222, 8, 2), --Banano, Limon dulce, Tres leches, Alfajor, Flan de vainilla 
			('', 'A', 0, '2018-02-01', 0, NULL, 33333, 9, 1), --Manzana roja, Pera, Sandia, Tres leches, Yuca
			('', 'A', 0, '2018-09-21', 0, NULL, 44444, 3, 1), --Papa, Zanahoria, Filete de Tilapia, Tres leches, Chayote
			('', 'A', 0, '2018-11-12', 0, 2, 11111, 13, 2), --Torta chilena, Helado de chocolate, Alfajor, Flan de vainilla, Tres leches
			('', 'A', 0, '2018-08-26', 0, 1, 11111, 10, 2), --Banano, Sandida, Zanahoria, Pera, Elote
			('', 'A', 0, '2018-05-19', 0, NULL, 55555, 14, 1), --Limon dulce, Chorizo de cerdo, Alfajor, Lomito de res, Yuca
			('', 'A', 0, '2018-12-11', 0, 1, 55555, 15, 1) --Yuca, Elote, Papa, Pera, Manzana roja
	
		INSERT INTO ArticuloXFactura(codArticulo, numFactura, precioUnitario, cantLineas) VALUES
			(5, 1, 2500, 1), (4, 1, 1000, 1), (3, 1, 1000, 1), (2, 1, 725, 1), (1, 1, 175, 1),
			(1, 2, 175, 1), (3, 2, 1000, 1), (7, 2, 800, 1), (11, 2, 400, 1), (12, 2, 250, 1),
			(13, 3, 150, 1), (15, 3, 150, 1), (14, 3, 900, 1), (6, 3, 450, 1), (16, 3, 500, 1),
			(12, 4, 250, 1), (10, 4, 800, 1), (19, 4, 2500, 1), (17, 4, 1500, 1), (20, 4, 1100, 1),
			(18, 5, 1000, 1), (6, 5, 450, 1), (4, 5, 1000, 1), (11, 5, 400, 1), (12, 5, 250, 1),
            (2, 6, 725, 1), (20, 6, 1100, 1), (1, 6, 175, 1), (5, 6, 2500, 1), (7, 6, 800, 1),
            (8, 7, 300, 1), (3, 7, 1000, 1), (17, 7, 1500, 1), (13, 7, 150, 1), (14, 7, 900, 1),
            (11, 8, 400, 1), (7, 8, 800, 1), (15, 8, 100, 1), (13, 8, 150, 1), (6, 8, 450, 1),
            (16, 9, 500, 1), (19, 9, 2500,1), (15, 9, 100, 1), (11, 9, 400, 1), (10, 9, 800, 1),
            (5,10, 2500, 1), (1, 10, 175, 1), (18, 10, 1000,1), (2, 10, 725, 1), (19, 10, 2500, 1),
            (9, 11, 600, 1), (18, 11, 1000, 1), (20, 11, 1100, 1), (10, 11, 800, 1), (11, 11, 400, 1),
            (8, 12, 300, 1), (11, 12, 400, 1), (13, 12, 150, 1), (12, 12, 250, 1), (14, 12, 900, 1),
            (7, 13, 800, 1), (4, 13, 1000, 1), (8, 13, 300, 1), (3, 13,  1000, 1), (9, 13, 600, 1),
            (13, 14, 150, 1), (15, 14, 100, 1), (17, 14, 1500, 1), (16, 14, 500, 1), (18, 14, 1000, 1),
            (12, 15, 250, 1), (11, 15, 400, 1), (14, 15, 900, 1), (17, 15, 1500, 1), (7, 15, 800, 1),
            (6, 16, 450, 1), (8, 16, 300, 1), (4, 16,  1000, 1), (17, 16, 1500, 1), (9, 16, 600, 1),
            (19, 17, 2500, 1), (20, 17, 1100, 1), (16, 17, 500, 1), (18, 17, 1000, 1), (17, 17, 1500, 1),
            (13, 18, 150, 1), (14, 18, 900, 1), (8, 18, 300, 1),  (11, 18, 400, 1), (10, 18, 800, 1),
            (15, 19, 100, 1), (1, 19, 175, 1), (16, 19, 500, 1), (5, 19, 2500, 1), (7, 19, 800, 1),
            (7, 20, 800, 1), (10, 20, 800, 1), (6, 20, 450, 1), (11, 20, 400, 1), (12, 20, 250, 1)
GO





--Consideraciones

	--Triggers

		/*
		Si la factura está en estado A (Abierta) se puede eliminar y sus líneas de detalle se
		deben eliminar automáticamente. Si una factura está en estado C (Cerrada), el sistema
		debe frena el borrado especificando un mensaje de validación acorde.
		*/

		--Nota: Debido a la llave foránea, la factura no se puede eliminar.

		CREATE TRIGGER tr_factura_estado_del
		ON Factura
		INSTEAD OF DELETE
		AS BEGIN
			DELETE f FROM Factura f
				INNER JOIN deleted d ON(f.numFactura = f.numFactura)
				WHERE d.estado = 'A';

			DELETE axf FROM ArticuloXFactura axf
				INNER JOIN deleted d ON(axf.numFactura = d.numFactura)
				WHERE d.estado = 'A' AND (axf.numFactura = d.numFactura);

			COMMIT TRAN;
			
			IF EXISTS (SELECT estado FROM deleted d WHERE d.estado = 'C') BEGIN;
				THROW 58000, '[ERROR] No se puede eliminar factura en estado ''C''', 1;
			END
		END
		GO
		
		-- Datos de prueba
			/*
				DELETE FROM Factura WHERE numFactura = 4;
				SELECT * FROM Factura;
				SELECT * FROM ArticuloXFactura;
				GO
			*/


		/*
		No se debe permitir eliminar un artículo si se 
		encuentra relacionado al menos a una factura (línea de detalle de la factura).
		*/ 

		CREATE TRIGGER tr_articulo_codarticulo_del
		ON Articulo
		INSTEAD OF DELETE
		AS BEGIN
			DECLARE @codArticulo char(10);
			SELECT @codArticulo = codArticulo FROM deleted;

			DELETE a FROM Articulo a INNER JOIN deleted d on a.codArticulo = d.codArticulo WHERE NOT EXISTS 
			(SELECT axf.codArticulo FROM ArticuloXFactura axf WHERE codArticulo = d.codArticulo);

			COMMIT TRAN;
			
			IF EXISTS(SELECT d.codArticulo, axf.numFactura FROM deleted d INNER JOIN ArticuloXFactura axf ON(axf.codArticulo = d.codArticulo) WHERE d.codArticulo = @codArticulo) BEGIN;			
				THROW 58001, '[ERROR] No se puede eliminar articulo porque está en uso', 1;
			END
		END;
		GO

		--Datos de prueba
			/*
				INSERT INTO Articulo(codArticulo, descripcion, costoUnitario, precioUnitario, codBarras, estado, cedProveedor, numCategoria) VALUES
					(200, 'Articulo de prueba #200', 100, 175, 20005, 'A', 1, 1);

				DELETE FROM Articulo WHERE codArticulo = 21;
				SELECT * FROM Articulo;
			*/
	

		/*
		No se debe permitir eliminar un cliente si se encuentra relacionado al menos a una factura. 
		*/


		CREATE TRIGGER tr_cliente_cedcliente_del
		ON Cliente
		INSTEAD OF DELETE
		AS BEGIN
			DELETE c FROM cliente c
			JOIN deleted d ON c.cedCliente = d.cedCliente
			WHERE NOT EXISTS (SELECT 1 FROM  Factura f WHERE cedCliente = d.cedCliente);

			COMMIT TRAN;

			IF (EXISTS (SELECT f.cedCliente FROM Factura f JOIN deleted d ON(f.cedCliente = d.cedCliente) WHERE f.cedCliente = d.cedCliente)) BEGIN;
				THROW 58002, '[ERROR] No se puede eliminar cliente porque está en factura', 1; 
			END
		END;
		GO

		--Datos de prueba
			/*
				INSERT INTO Cliente(cedCliente, nombre, apellido, genero, direccion, telefono, idRegion) VALUES
					(100, 'Nombre', 'Apellido', 'M', 'San Jose', '1234-5678', 2);
				
				DELETE FROM Cliente WHERE cedCliente = 1;

				DELETE FROM Cliente WHERE cedCliente = 100;

				SELECT * FROM Cliente;
			*/


		/*
		Por medio de triggers se deben actualizar las columnas de cantidad de líneas y 
		monto total de la factura. Por cada inserción o borrado de una línea, se deben 
		actualizar las columnas de la factura indicada en la acción realizada.
		*/

		CREATE TRIGGER tr_articuloxfactura_actulizar
		ON ArticuloXFactura
		AFTER INSERT, DELETE
		AS BEGIN	
			UPDATE Factura SET montoTotal = x.montoTotal, cantLineas = x.cantLineas
			FROM (SELECT l.numFactura, SUM(l.precioUnitario * l.cantLineas) as 'montoTotal', SUM(l.cantLineas) as 'cantLineas' FROM 
			(SELECT f.numFactura, f.montoTotal, f.fechaConfeccion, axf.codArticulo, axf.precioUnitario, axf.cantLineas FROM Factura f
			INNER JOIN ArticuloXFactura axf ON(axf.numFactura = f.numFactura)) l GROUP BY l.numFactura) x
			WHERE x.numFactura = Factura.numFactura;
		END;
		GO

		
		--Datos de prueba
			/*
				INSERT INTO ArticuloXFactura(codArticulo, numFactura, precioUnitario, cantLineas) VALUES
					(15, 5, 2500, 1)
				
				INSERT INTO ArticuloXFactura(codArticulo, numFactura, precioUnitario, cantLineas) VALUES
					(7, 5, 800, 1)
					
				DELETE FROM ArticuloXFactura WHERE codArticulo = 7 AND numFactura = 5;

				SELECT * FROM Factura;
			*/




	--Funciones

		/*
		Se debe crear una función de usuario llamada calculaDescuento que recibe 
		como parámetro un monto, un porcentaje y debe devolver el monto de descuento
		correspondiente al porcentaje brindado. 
		*/

		CREATE FUNCTION calculaDescuento(@monto money, @porcentaje decimal(5,2))
		RETURNS money
		AS BEGIN
			DECLARE @descuento money;
			SET @descuento = @monto - ((@porcentaje/100)*@monto);
			RETURN @descuento;
		END;
		GO
		    
		--Datos de prueba
			/*
				SELECT dbo.calculaDescuento(1250, 20) as 'Resultado';
			*/


	--Procedimientos almacenados

		/*
		Listado de todos los empleados junto a la cantidad de facturas realizadas en un período 
		de tiempo (se debe mostrar cero si el empleado no ha realizado ventas). Los parámetros 
		solicitados son la fecha de inicio y la fecha final.
		*/

		CREATE PROCEDURE stp_empleado_facturas @fechaInicio DATE, @fechaFinal DATE
		AS BEGIN
			SELECT e.codEmpleado as 'Código del empleado', e.nombre AS 'Nombre', COALESCE(COUNT(f.codEmpleado), 0) AS 'Cantidad de ventas'
			FROM Empleado e LEFT JOIN Factura f 	
			ON (f.codEmpleado = e.codEmpleado)
			GROUP BY e.codEmpleado, e.nombre, f.codEmpleado;
		END;
		GO

		--Datos de prueba
			/*
				EXEC stp_empleado_facturas @fechaInicio = '2018-05-20', @fechaFinal = '2018-05-27';
			*/
		


		  

		/*
		Listado de los clientes pertenecientes a una región específica. 
		*/

		CREATE PROCEDURE stp_region_cliente @region varchar(100)
		AS BEGIN
			SELECT c.idRegion AS 'ID de región', c.nombre AS 'Región', c.direccion  as 'Dirección' FROM Cliente c 
			INNER JOIN Region r ON (r.idRegion = c.idRegion) WHERE descripcion = @region;

		END;
		GO

		--Datos de prueba
		  
			/*
				EXEC stp_region_cliente @region = 'Sur'; 
			*/




		/*
		Listado de los 3 artículos más vendidos en un rango de fechas. 
		Los parámetros solicitados son la fecha de inicio y la fecha final.
		*/
		
		CREATE PROCEDURE stp_articulo_masvendidos @fechaInicio DATE, @fechaFinal DATE
		AS BEGIN
			SELECT TOP 3 a.codArticulo AS 'Código del artículo', a.descripcion AS 'Descripción', COUNT(af.codArticulo) AS 'Cantidad de ventas' FROM ArticuloXFactura af
			INNER JOIN Articulo a ON(af.codArticulo = a.codArticulo)
			INNER JOIN Factura f ON(f.numFactura = af.numFactura)
			WHERE (f.fechaConfeccion BETWEEN @fechaInicio AND @fechaFinal)
			GROUP BY a.codArticulo, a.descripcion, af.codArticulo ORDER BY 'Cantidad de ventas' DESC
		END;
		GO

		--Datos de prueba
			/*
				EXEC stp_articulo_masvendidos @fechaInicio = '2018-01-27', @fechaFinal = '2018-05-27';
			*/
		



		/*
		Mostrar todas las categorías y el monto total que se ha vendido para cada categoría 
		(se debe mostrar cero si la categoría no tiene ventas asociadas). 
		Los parámetros solicitados son la fecha de inicio y la fecha final. 
		*/
		
		CREATE PROCEDURE stp_categorias_montototal @fechaInicio DATE, @fechaFinal DATE
		AS BEGIN
			SELECT c.numCategoria as 'Número de categoría', c.descripcion as 'Categoría', COALESCE(SUM(af.cantLineas * af.precioUnitario), 0) as 'Cantidad de ventas'
			FROM Categoria c
			INNER JOIN Articulo a ON(c.numCategoria=a.numCategoria)
			LEFT JOIN ArticuloXFactura af ON(a.codArticulo=af.codArticulo)
			LEFT JOIN Factura f ON(f.numFactura=af.numFactura)
			WHERE f.fechaConfeccion BETWEEN @fechaInicio AND @fechaFinal
			GROUP BY c.numCategoria, c.descripcion
			ORDER BY 'Cantidad de ventas' DESC
		END;
		GO


		--Datos de prueba
			/*
				EXEC stp_categorias_montoTotal @fechaInicio = '2018-01-27', @fechaFinal = '2018-05-27';
			*/



			
		/*
		Listado de los proveedores junto el monto que se ha facturado de los artículos que este provee. 
		El ordenamiento se debe dar ascendentemente por el monto. 
		*/
		
		CREATE PROCEDURE stp_proveedor_montototal
		AS BEGIN
			SELECT p.cedProveedor as 'Cédula', p.nombre as 'Nombre', p.telefono as 'Teléfono', p.direccion as 'Dirección', SUM(axf.precioUnitario * axf.cantLineas) as 'Monto total' FROM Proveedor p
			INNER JOIN Articulo a ON(a.cedProveedor = p.cedProveedor)
			INNER JOIN ArticuloXFactura axf ON(axf.codArticulo = a.codArticulo) GROUP BY p.cedProveedor, p.nombre, p.telefono, p.direccion
			ORDER BY 'Monto total' ASC;
		END;
		GO
		   
		--Datos de prueba
			/*
				EXEC stp_proveedor_montototal;
			*/
		
		

		/*
			Mostrar el artículo con menor venta para cada una de las categorías. 
		*/	

		CREATE PROCEDURE stp_categoria_menorventa
		AS BEGIN
			SELECT c.descripcion AS 'Categoría', a.descripcion AS 'Artículo', SUM(axf.precioUnitario * axf.cantLineas) as 'Monto total' FROM Categoria c
			INNER JOIN Articulo a ON(a.numCategoria = c.numCategoria)
			INNER JOIN ArticuloXFactura axf ON(a.codArticulo = axf.codArticulo) GROUP BY c.descripcion, a.descripcion ORDER BY [Monto total] ASC
		END;
		GO

		--Datos de prueba
			/*
				EXEC stp_categoria_menorventa;
			*/


		/*
			Monto total de ventas y el monto de descuento agrupadas por mes, 
			para un año proporcionado por el usuario. 
		*/

		CREATE PROCEDURE stp_ventas_monto @anno int
		AS BEGIN
			SELECT DATENAME(month, f.fechaConfeccion) AS 'Mes', COALESCE(SUM(f.montoTotal), 0.00) AS 'Monto total de ventas',
			COALESCE(SUM(dbo.calculaDescuento(af.precioUnitario * af.cantLineas, d.porcentaje)), 0) AS 'Monto total de descuento'
			FROM Factura f
			INNER JOIN Descuento d ON(f.idDescuento = d.idDescuento)
			LEFT JOIN ArticuloXFactura af ON(f.numFactura = af.numFactura)
			WHERE YEAR(f.fechaConfeccion) = @anno
			GROUP BY DATENAME(MONTH, f.fechaConfeccion);
		END;
		GO
		
		--Datos de prueba
			/*
				EXEC stp_ventas_monto @anno = 2018;
			*/


--Eliminación de base de datos
	--DROP DATABASE SistemaFacturacion;