NOMBRE DE LA BASE DE DATOS CREADA EN SQLSERVER

BDAnalisis_Sistemas


CREATE TABLE Usuarios (
    UsuarioID INT PRIMARY KEY,
    NombreUsuario VARCHAR(50) NOT NULL,
    Contraseña VARCHAR(50) NOT NULL,
	CorreoElectronico VARCHAR(50) NOT NULL

);


CREATE TABLE Ingresos (
    IngresoID INT PRIMARY KEY,
    UsuarioID INT,
    Descripcion VARCHAR(100) NOT NULL,
    Monto DECIMAL(10, 2) NOT NULL,
    Fecha DATE,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);

 
CREATE TABLE Egresos (
    EgresoID INT PRIMARY KEY,
    UsuarioID INT,
    Descripcion VARCHAR(100) NOT NULL,
    Monto DECIMAL(10, 2) NOT NULL,
    Fecha DATE,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);

CREATE TABLE InformeFinanciero (
    InformeID INT PRIMARY KEY,
    UsuarioID INT,
	Fecha_Informe DATE,
    TotalIngresos DECIMAL(10, 2),
    TotalEgresos DECIMAL(10, 2),
    Total DECIMAL(10, 2),
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);






-- Table CrearUsuario

CREATE TABLE [CrearUsuario]
(
 [IdUsuario] Int PRIMARY KEY IDENTITY,
 [Nombres] Char(76) NULL,
 [Correo] Char(50) NULL,
 [Contraseña] Char(20) NULL
)
go

-- Add keys for table CrearUsuario

ALTER TABLE [CrearUsuario] ADD CONSTRAINT [PK_CrearUsuario] PRIMARY KEY ([IdUsuario])
go

-- Table Ingreso

CREATE TABLE [Ingreso]
(
 [Id_Ingreso] Int PRIMARY KEY IDENTITY,
 [IdUsuario] Int NOT NULL,
 [cantidad] Money NULL,
 [Fecha] Date NULL,
 [Descripcion_Ingreso] Char(30) NULL,
 [Divisa] Char(2) NULL
)
go

-- Add keys for table Ingreso

ALTER TABLE [Ingreso] ADD CONSTRAINT [PK_Ingreso] PRIMARY KEY ([Id_Ingreso],[IdUsuario])
go

-- Table Retiros

CREATE TABLE [Retiros]
(
 [Id] Int PRIMARY KEY IDENTITY,
 [IdUsuario] Int NOT NULL,
 [Cantidad] Money NULL,
 [Fecha_Retiro] Date NULL,
 [Descripcion_Retiro] Char(100) NULL
)
go

-- Add keys for table Retiros

ALTER TABLE [Retiros] ADD CONSTRAINT [PK_Retiros] PRIMARY KEY ([Id],[IdUsuario])
go

-- Table Informe

CREATE TABLE [Informe]
(
 [Id_Informe] Int PRIMARY KEY IDENTITY,
 [IdUsuario] Int NOT NULL,
 [TipodeTransaccion] Char(75) NULL,
 [Cantidad] Money NULL,
 [Fecha_Informe] Date NULL
)
go

-- Add keys for table Informe

ALTER TABLE [Informe] ADD CONSTRAINT [PK_Informe] PRIMARY KEY ([Id_Informe],[IdUsuario])
go

-- Create foreign keys (relationships) section ------------------------------------------------- 


ALTER TABLE [Ingreso] ADD CONSTRAINT [Relationship2] FOREIGN KEY ([IdUsuario]) REFERENCES [CrearUsuario] ([IdUsuario]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [Retiros] ADD CONSTRAINT [Relationship11] FOREIGN KEY ([IdUsuario]) REFERENCES [CrearUsuario] ([IdUsuario]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



ALTER TABLE [Informe] ADD CONSTRAINT [Relationship12] FOREIGN KEY ([IdUsuario]) REFERENCES [CrearUsuario] ([IdUsuario]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



-- Table CrearUsuario
CREATE TABLE [CrearUsuario] (
 [IdUsuario] INT PRIMARY KEY IDENTITY,
 [Nombres] CHAR(76) NULL,
 [Correo] CHAR(50) NULL,
 [Contraseña] CHAR(20) NULL
);

-- Table Ingreso
CREATE TABLE [Ingreso] (
 [Id_Ingreso] INT PRIMARY KEY IDENTITY,
 [IdUsuario] INT NOT NULL,
 [Cantidad] MONEY NULL,
 [Fecha] DATE NULL,
 [Descripcion_Ingreso] CHAR(30) NULL,
 [Divisa] CHAR(2) NULL,
 FOREIGN KEY ([IdUsuario]) REFERENCES [CrearUsuario] ([IdUsuario]) ON UPDATE NO ACTION ON DELETE NO ACTION
);

-- Table Retiros
CREATE TABLE [Retiros] (
 [Id] INT PRIMARY KEY IDENTITY,
 [IdUsuario] INT NOT NULL,
 [Cantidad] MONEY NULL,
 [Fecha_Retiro] DATE NULL,
 [Descripcion_Retiro] CHAR(100) NULL,
 FOREIGN KEY ([IdUsuario]) REFERENCES [CrearUsuario] ([IdUsuario]) ON UPDATE NO ACTION ON DELETE NO ACTION
);

-- Table Informe
CREATE TABLE [Informe] (
    [Id_Informe] INT PRIMARY KEY IDENTITY,
    [IdUsuario] INT NOT NULL,
   
    [Fecha_Informe] DATE NULL,
 [Descripcion] CHAR(75) NULL,
    [SumaIngresos] MONEY NULL,
    [SumaRetiros] MONEY NULL,
[CantidadTotal] MONEY NULL,
    FOREIGN KEY ([IdUsuario]) REFERENCES [CrearUsuario] ([IdUsuario]) ON UPDATE NO ACTION ON DELETE NO ACTION
);



-- Table Informe
CREATE TABLE [Informe] (
 [Id_Informe] INT PRIMARY KEY IDENTITY,
 [IdUsuario] INT NOT NULL,
 [TipodeTransaccion] CHAR(75) NULL,
 [Cantidad] MONEY NULL,
 [Fecha_Informe] DATE NULL,
 FOREIGN KEY ([IdUsuario]) REFERENCES [CrearUsuario] ([IdUsuario]) ON UPDATE NO ACTION ON DELETE NO ACTION
);




CREATE PROCEDURE InsertarUsuario
  @Nombres CHAR(76),
  @Correo CHAR(50),
  @Contraseña CHAR(20)
AS
BEGIN
  INSERT INTO CrearUsuario (Nombres, Correo, Contraseña)
  VALUES (@Nombres, @Correo, @Contraseña);
END;








       // Valores ingresados en las cajas de texto
String name = txtUsuarioL.getText();
String pass = String.valueOf(txtcontraseña.getPassword());
System.out.println("Valor de name: " + name);
System.out.println("Valor de pass: " + pass);
// Realizar la consulta directa
try {
    // Obtener la conexión desde la clase Connection
    Connection connection = Conection.getConexion();

    // Construir la consulta SQL
    String query = "SELECT * FROM CrearUsuario WHERE Nombres = '" + name + "' AND Contraseña = '" + pass + "'";

    // Crear el Statement y ejecutar la consulta
    Statement statement = connection.createStatement();
    ResultSet resultSet = statement.executeQuery(query);

    // Verificar si se encontraron resultados
    if (resultSet.next()) {
        JOptionPane.showMessageDialog(null, "Credenciales correctas.");
        Home oforma = new Home();
        oforma.setVisible(true);
        // Aquí puedes realizar las acciones adicionales que deseas realizar cuando las credenciales son correctas
    } else {
        JOptionPane.showMessageDialog(null, "Credenciales incorrectas.");
        // Aquí puedes realizar las acciones adicionales que deseas realizar cuando las credenciales son incorrectas
    }

    // Cerrar los recursos
    resultSet.close();
    statement.close();
    connection.close();
} catch (SQLException e) {
    e.printStackTrace();
}



CREATE PROCEDURE InsertarIngreso
  @Nombre CHAR(76),
  @Contraseña CHAR(20),
  @Cantidad MONEY,
  @Fecha DATE,
  @Descripcion CHAR(30),
  @Divisa CHAR(2)
AS
BEGIN
  DECLARE @IdUsuario INT;

  -- Obtener el IdUsuario correspondiente al nombre y contraseña ingresados
  SELECT @IdUsuario = IdUsuario
  FROM CrearUsuario
  WHERE Nombres = @Nombre AND Contraseña = @Contraseña;

  -- Insertar el nuevo registro en la tabla Ingreso
  INSERT INTO Ingreso (IdUsuario, Cantidad, Fecha, Descripcion_Ingreso, Divisa)
  VALUES (@IdUsuario, @Cantidad, @Fecha, @Descripcion, @Divisa);
END;







CREATE PROCEDURE ValidarUsuario
  @Usuario CHAR(50),
  @Contraseña CHAR(20),
  @Valido BIT OUTPUT

AS
BEGIN
  SET @Valido = 0;
  
  -- Verificar si el usuario y contraseña son válidos
  IF EXISTS (
    SELECT 1
    FROM CrearUsuario
    WHERE Nombres = @Usuario AND Contraseña = @Contraseña
  )
  BEGIN
    SET @Valido = 1;
  END;
END;


alter PROCEDURE LoginUsuario
  @Nomb CHAR(76),
  @Contra CHAR(20)
AS
BEGIN
  -- Realizar la consulta
  SELECT *
  FROM CrearUsuario
  WHERE Nombres = @Nomb AND Contraseña = @Contra;
END;


SELECT *
FROM CrearUsuario
WHERE Nombres = 'Celita' AND Contraseña = 'cel';
exec LoginUsuario 'Lily','123';


CREATE PROCEDURE InsertarIngreso
  @Nombre CHAR(76),
  @Contraseña CHAR(20),
  @Cantidad MONEY,
  @Fecha DATE,
  @Descripcion CHAR(30),
  @Divisa CHAR(2)
AS
BEGIN
  DECLARE @IdUsuario INT;

  -- Obtener el IdUsuario correspondiente al nombre y contraseña ingresados
  SELECT @IdUsuario = IdUsuario
  FROM CrearUsuario
  WHERE Nombres = @Nombre AND Contraseña = @Contraseña;

  -- Insertar el nuevo registro en la tabla Ingreso
  INSERT INTO Ingreso (IdUsuario, Cantidad, Fecha, Descripcion_Ingreso, Divisa)
  VALUES (@IdUsuario, @Cantidad, @Fecha, @Descripcion, @Divisa);
END;
	



CREATE PROCEDURE InsertarRetiro
  @Nombre CHAR(76),
  @Contraseña CHAR(20),
  @Cantidad MONEY,
  @Fecha DATE,
  @Descripcion CHAR(100)
AS
BEGIN
  DECLARE @IdUsuario INT;

  -- Obtener el IdUsuario correspondiente al nombre y contraseña ingresados
  SELECT @IdUsuario = IdUsuario
  FROM CrearUsuario
  WHERE Nombres = @Nombre AND Contraseña = @Contraseña;

  -- Insertar el nuevo registro en la tabla Retiros
  INSERT INTO Retiros (IdUsuario, Cantidad, Fecha_Retiro, Descripcion_Retiro)
  VALUES (@IdUsuario, @Cantidad, @Fecha, @Descripcion);
END;
select * from Retiros

   




-- Table Informe
CREATE TABLE [Informe] (
    [Id_Informe] INT PRIMARY KEY IDENTITY,
    [IdUsuario] INT NOT NULL,
   
    [Fecha_Informe] DATE NULL,
 [Descripcion] CHAR(75) NULL,
    [SumaIngresos] MONEY NULL,
    [SumaRetiros] MONEY NULL,
[CantidadTotal] MONEY NULL,
    FOREIGN KEY ([IdUsuario]) REFERENCES [CrearUsuario] ([IdUsuario]) ON UPDATE NO ACTION ON DELETE NO ACTION
);








CREATE PROCEDURE CalcularInforme
    @Nombre CHAR(76),
    @Contraseña CHAR(20)
AS
BEGIN
    DECLARE @IdUsuario INT;
    DECLARE @SumaIngresos MONEY;
    DECLARE @SumaRetiros MONEY;
    DECLARE @CantidadTotal MONEY;

    -- Obtener el IdUsuario correspondiente al nombre y contraseña ingresados
    SELECT @IdUsuario = IdUsuario
    FROM CrearUsuario
    WHERE Nombres = @Nombre AND Contraseña = @Contraseña;

    -- Calcular la suma de ingresos
    SELECT @SumaIngresos = SUM(Cantidad)
    FROM Ingreso
    WHERE IdUsuario = @IdUsuario;

    -- Calcular la suma de retiros
    SELECT @SumaRetiros = SUM(Cantidad)
    FROM Retiros
    WHERE IdUsuario = @IdUsuario;

    -- Calcular la cantidad total
    SET @CantidadTotal = @SumaIngresos - @SumaRetiros;

    -- Insertar el informe en la tabla "Informe"
    INSERT INTO Informe (IdUsuario, Fecha_Informe,  Descripcion, SumaIngresos, SumaRetiros, CantidadTotal)
    VALUES (@IdUsuario,   GETDATE(),'Informe de transacciones', @SumaIngresos, @SumaRetiros, @CantidadTotal);
END;

EXEC CalcularInforme 'Lily','123';
select *from Informe
select * from Ingreso
select * from Retiros





-- Table Informe
CREATE TABLE [Informe] (
    [Id_Informe] INT PRIMARY KEY IDENTITY,
    [IdUsuario] INT NOT NULL,
   
    [Fecha_Informe] DATE NULL,
 [Descripcion] CHAR(75) NULL,
    [SumaIngresos] MONEY NULL,
    [SumaRetiros] MONEY NULL,
[CantidadTotal] MONEY NULL,
    FOREIGN KEY ([IdUsuario]) REFERENCES [CrearUsuario] ([IdUsuario]) ON UPDATE NO ACTION ON DELETE NO ACTION
);




CREATE PROCEDURE CalcularInforme
    @Nombre CHAR(76),
    @Contraseña CHAR(20)
AS
BEGIN
    DECLARE @IdUsuario INT;
    DECLARE @SumaIngresos MONEY;
    DECLARE @SumaRetiros MONEY;
    DECLARE @CantidadTotal MONEY;

    -- Obtener el IdUsuario correspondiente al nombre y contraseña ingresados
    SELECT @IdUsuario = IdUsuario
    FROM CrearUsuario
    WHERE Nombres = @Nombre AND Contraseña = @Contraseña;

    -- Calcular la suma de ingresos
    SELECT @SumaIngresos = SUM(Cantidad)
    FROM Ingreso
    WHERE IdUsuario = @IdUsuario;

    -- Calcular la suma de retiros
    SELECT @SumaRetiros = SUM(Cantidad)
    FROM Retiros
    WHERE IdUsuario = @IdUsuario;

    -- Calcular la cantidad total
    SET @CantidadTotal = @SumaIngresos - @SumaRetiros;

    -- Insertar el informe en la tabla "Informe"
    INSERT INTO Informe (IdUsuario, Fecha_Informe,  Descripcion, SumaIngresos, SumaRetiros, CantidadTotal)
    VALUES (@IdUsuario,   GETDATE(),'Informe de transacciones', @SumaIngresos, @SumaRetiros, @CantidadTotal);
END;

EXEC CalcularInforme 'Lily','123';
select *from Informe
select * from Ingreso
select * from Retiros
