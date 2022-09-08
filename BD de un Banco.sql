CREATE DATABASE BANCO;

USE BANCO;

CREATE TABLE TiposDeCuenta(
ID_Tipo INT NOT NULL AUTO_INCREMENT,
Descripcion VARCHAR(50),
PRIMARY KEY (ID_Tipo));

INSERT INTO TiposDeCuenta(Descripcion)
VALUES('Cuenta Corriente'),
('Cuenta Ahorro'),
('Cuenta Virtual'),
('Cuenta Jubilados');

SELECT * FROM TiposDeCuenta;

CREATE TABLE Monedas(
ID_Moneda INT NOT NULL AUTO_INCREMENT,
Descripcion VARCHAR(50),
Simbolo VARCHAR(3),
PRIMARY KEY(ID_Moneda));

INSERT INTO Monedas(Descripcion,Simbolo)
VALUES('DOLAR','USD'),
('EURO','EUR'),
('PESOS ARGENTINOS','ARS'),
('PESOS URUGUAYOS','UYU'),
('REAL BRASILERO','BRL'),
('BITCOIN','BTC');

SELECT * FROM Monedas;

CREATE TABLE Paises(
ID_Pais INT NOT NULL AUTO_INCREMENT,
Nombre VARCHAR (50),
Abreviatura VARCHAR(2),
PRIMARY KEY(ID_Pais));

INSERT INTO Paises(Nombre,Abreviatura)
VALUES('Argentina','AR'),
('Uruguay','UY'),
('Brasil','BR'),
('Venezuela','VE');

SELECT * FROM Paises;

CREATE TABLE Usuarios(
ID_Usuario INT NOT NULL AUTO_INCREMENT,
Nombre VARCHAR(50),
Apellido VARCHAR(50),
EMAIL VARCHAR(50),
Nombre_Usuario VARCHAR(10),
Contraseña VARCHAR(12),
Pais INT NOT NULL,
PRIMARY KEY (ID_Usuario),
FOREIGN KEY(Pais) REFERENCES Paises(ID_Pais));

INSERT INTO Usuarios (Nombre,Apellido,EMAIL,Nombre_Usuario,Contraseña,Pais)
VALUES ('Marina','Paludi','paludi@gmail.com','MPALUDI',1234,1),
('Constanza','Romero','romero@gmail.com','CROMERO',1234,1),
('Alex','Robles','robles@gmail.com','AROBLES',1234,1),
('Daniela','Gonzalez','gonzalez@gmail.com','DGONZALEZ',1234,2),
('Erica','Maldonado','maldonado@gmail.com','EMALDONADO',1234,2),
('Oscar','Sosa','sosa@gmail.com','OSOSA',1234,2),
('Fabel','Chipana','chipana@gmail.com','FCHIPANA',1234,3),
('Gaston','Romero','romero@gmail.com','GROMERO',1234,3),
('Karina','Barbero','barbero@gmail.com','KMOLAS',1234,3),
('Nerea','Molas','molas@gmail.com','NMOLAS',1234,4),
('Tobias','Ayala','ayala@gmail.com','TAYALA',1234,4),
('Williams','Suarez','suarez@gmail.com','WSUAREZ',1234,4);

SELECT * FROM Usuarios;

CREATE TABLE Cuentas(
ID_Cuenta INT NOT NULL AUTO_INCREMENT,
Numero_Cuenta INT NOT NULL,
TipoCuenta INT NOT NULL,
Usuario_Titular INT NOT NULL,
Moneda INT NOT NULL,
PRIMARY KEY (ID_Cuenta),
FOREIGN KEY (TipoCuenta) REFERENCES TiposDeCuenta (ID_Tipo),
FOREIGN KEY (Usuario_Titular) REFERENCES Usuarios (ID_Usuario),
FOREIGN KEY (Moneda) REFERENCES Monedas (ID_Moneda));

INSERT INTO Cuentas(Numero_Cuenta,TipoCuenta,Usuario_Titular,Moneda)
VALUES (123456789,1,1,1),
(123456781,1,2,1),
(123456782,1,3,2),
(123456783,2,4,2),
(123456784,2,5,3),
(123456785,2,6,3),
(123456786,3,7,4),
(123456787,3,8,4),
(123456788,3,9,5),
(123456712,4,10,5),
(123456713,4,11,7),
(123456714,4,12,7);

SELECT * FROM Cuentas;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#Obtener los nombres de usuario que tengan cuenta en moneda Euros

SELECT Nombre_Usuario AS 'Usuario'
FROM Usuarios
JOIN Cuentas
ON Usuarios.ID_Usuario = Cuentas.Usuario_Titular
JOIN Monedas
ON Cuentas.moneda = Monedas.ID_Moneda
WHERE Monedas.Descripcion = 'EURO';

#Actualizar el correo electrónico del usuario Oscar Sosa a "oscarsosa@gmail.com"

UPDATE Usuarios
SET EMAIL = 'oscarsosa@gmail.com'
WHERE Nombre = 'Oscar'
AND Apellido = 'Sosa';

#Obtener todos los usuarios de Uruguay que tengan cuentas del tipo Cuenta Ahorro

SELECT Usuarios.*,Paises.Nombre AS Pais
FROM Usuarios
JOIN Paises
ON Usuarios.Pais = Paises.ID_Pais
JOIN Cuentas
ON Cuentas.Usuario_Titular = Usuarios.ID_Usuario
JOIN TiposDeCuenta
ON TiposDeCuenta.ID_Tipo = Cuentas.TipoCuenta
WHERE Paises.Nombre = 'Uruguay'
AND TiposDeCuenta.Descripcion = 'Cuenta Ahorro';


#Obtener los nombres y apellidos de los usuarios que tengan cuentas en moneda Dolar

SELECT usu.nombre AS 'Nombre', usu.apellido AS 'Apellido'
FROM Usuarios usu
JOIN Cuentas cue
ON cue.Usuario_Titular = usu.ID_Usuario
JOIN Monedas mon
ON mon.ID_Moneda = cue.moneda
WHERE mon.Descripcion = 'Dolar';

#Actualizar el numero de cuenta del usuario Marina Paludi a "987654321"
SELECT ID_usuario 
FROM Usuarios
WHERE Nombre = 'Marina'
AND Apellido = 'Paludi';
#Hago esta consulta para saber cual es el ID del usuario MARINA PALUDI
#En la siguiente consulta actualizo
UPDATE Cuentas
SET Numero_Cuenta = 987654321
WHERE Usuario_Titular = 1;

#Obtener todos los usuarios de Brasil que tengan cuentas del tipo Cuenta Jubilados

SELECT usu.* 
FROM Usuarios usu
JOIN Paises pai
ON pai.ID_Pais = usu.pais
JOIN Cuentas cue
ON cue.Usuario_Titular = usu.ID_Usuario
JOIN TiposDeCuenta tdc
ON cue.TipoCuenta = tdc.ID_Tipo
WHERE tdc.Descripcion = 'Cuenta Jubilados'
AND pai.nombre = 'Brasil';
#En mi BD solo tengo usuarios de Venezuela con cuentas de Jubilado, por eso la query no trae nada

#Seleccionar los nombres pertenecientes a usuarios con cuentas ahorro

SELECT usu.Nombre
FROM Usuarios usu
JOIN Cuentas cue
ON cue.Usuario_Titular = usu.ID_Usuario
JOIN TiposDeCuenta tdc
ON cue.TipoCuenta = tdc.ID_Tipo
WHERE tdc.Descripcion = 'Cuenta Ahorro';

#Mostrar los numeros de cuenta de los usuarios de Uruguay

SELECT cue.Numero_Cuenta
FROM Cuentas cue
JOIN Usuarios usu
ON usu.ID_Usuario = cue.Usuario_Titular
JOIN Paises pai
ON usu.pais = pai.ID_Pais
WHERE pai.Nombre = 'Uruguay';

#Seleccionar los Usuarios con tipo de cuenta Jubilados

SELECT usu.*
FROM Usuarios usu
JOIN Cuentas cue
ON cue.Usuario_Titular = usu.ID_Usuario
JOIN TiposDeCuenta tdc
ON cue.TipoCuenta = tdc.ID_Tipo
WHERE tdc.Descripcion = 'Cuenta Jubilados';

#Seleccionar las cuentas virtuales con saldos en bitcoins

SELECT tdc.ID_Tipo AS 'ID del tipo de Cuenta', tdc.Descripcion AS 'Tipo de Cuenta'
FROM TiposDeCuenta tdc
JOIN Cuentas cue
ON cue.TipoCuenta = tdc.ID_Tipo
JOIN Monedas mon
ON mon.ID_Moneda = cue.Moneda
WHERE mon.Descripcion = 'Bitcoin'
AND tdc.Descripcion = 'Cuenta Virtual';

#En mi BD solo tengo cuentas de Jubilado con saldo en Bitcoin, por eso la query no trae nada