-- Universidad de la Sierra Sur 
-- Alumno: Luis Wonen Olvera Vásquez
-- Profesor: Rolando Pedro Gabriel
-- Proyecto: 1er Parcial Bases de datos 2

-- Creando la base de datos si esta no existe 
Create database if not exists Juego;
-- Eliminando la base de datos si esta existe
Drop Database If Exists Juego;
-- Creando la base de nueva cuenta
Create Database Juego;

-- Seleccionamos la base de datos para trabajar en ella 
Use Juego;

-- Creando la tabla Jugadores
CREATE TABLE Jugadores(
    idJugador INT NOT NULL AUTO_INCREMENT,
    nombreJugador VARCHAR(45) NOT NULL,
    nivel INT NULL,
    fecha DATE NOT NULL,
    edad INT,
    CONSTRAINT jugadores_pk PRIMARY KEY(idJugador)
);

-- Creando la tabla Campeones
CREATE TABLE Campeones(
    idCampeon INT NOT NULL AUTO_INCREMENT,
    nombreCampeon VARCHAR(45) NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    precio DECIMAL(8,2) NULL,
    fecha DATE NOT NULL,
    edad INT,
    CONSTRAINT campeones_clave_alt UNIQUE (nombreCampeon),
    CONSTRAINT campeones_pk PRIMARY KEY(idCampeon)
);

-- Creando la tabla Batallas
CREATE TABLE Batallas(
    jugadorId INT NOT NULL,
    campeonId INT NOT NULL,
    cantidad INT NOT NULL,
    CONSTRAINT batallas_jugadores FOREIGN KEY (jugadorId)
        REFERENCES jugadores (idJugador)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT batallas_campeones FOREIGN KEY (campeonId)
        REFERENCES campeones (idCampeon)
        ON DELETE RESTRICT
        ON UPDATE CASCADE, 
        CONSTRAINT batallas_pk PRIMARY KEY  (jugadorId, campeonId)
);



-- 1. Implementar un procedimiento almacenado para crear un jugador.
DELIMITER //
CREATE PROCEDURE `spCrearRegistroJugador` (
	IN _nombreJugador VARCHAR (45),
    IN _nivel INT,
    IN _fecha DATE,
    IN _edad INT
)
BEGIN
	INSERT INTO jugadores (
		nombreJugador, 
        nivel, 
        fecha,
        edad
	)
	VALUES(
		_nombreJugador,
        _nivel,
        _fecha,
        _edad
    );
END //
DELIMITER ;


-- 2.Implementar un procedimiento almacenado para crear un campeon.
DELIMITER //
CREATE PROCEDURE `spCrearRegistroCampeon` (
	IN _nombreCampeon VARCHAR (45),
    IN _tipo VARCHAR(20),
    IN _precio DECIMAL(8,2),
    IN _fecha DATE,
    IN _edad INT
    
)
BEGIN
	INSERT INTO campeones (
		nombreCampeon, 
        tipo, 
        precio,
        fecha,
        edad
	)
	VALUES(
		_nombreCampeon,
        _tipo,
        _precio,
        _fecha,
        _edad
    );
END //
DELIMITER ;



-- 3.Implementar un procedimiento almacenado para crear una batalla
DELIMITER //
CREATE PROCEDURE `spCrearRegistroBatallas` (
	IN _jugadorId INT,
    IN _campeonId INT,
    IN _cantidad INT
)
BEGIN
	INSERT INTO batallas (
		jugadorId, 
        campeonId, 
        cantidad
	)
	VALUES(
		_jugadorId,
        _campeonId,
        _cantidad
    );
END //
DELIMITER ;


-- 4.Implementar un procedimiento almacenado para actualizar un jugador
DELIMITER //
CREATE PROCEDURE `spActualizarJugador`(
	IN _nombreJugador VARCHAR(45),
	IN _nivel INT,
    IN _fecha DATE,
    IN _edad INT,
	IN _idJugador INT
)
BEGIN
	UPDATE Jugadores 
    SET nombreJugador = _nombreJugador,
		nivel = _nivel,
		fecha = _fecha,
        edad = _edad
	WHERE 
		idJugador = _idJugador;
END //
DELIMITER ;


-- 5.Implementar un procedimiento almacenado para actualizar un campeón 
DELIMITER //
CREATE PROCEDURE `spActualizarCampeon`(
	IN _nombreCampeon VARCHAR(45),
    IN _tipo VARCHAR(45),
    IN _precio DECIMAL(8,2),
    IN _fecha DATE,
    IN _edad INT,
    IN _idCampeon INT
    
)
BEGIN
	UPDATE Campeones 
    SET nombreCampeon = _nombreCampeon,
		tipo = _tipo,
        nivel = _nivel,
		fecha = _fecha,
        edad = _edad
	WHERE 
		idCampeon = _idCampeon;
END //
DELIMITER ;


-- 6.Implementar un procedimiento almacenado para actualizar una batalla 
DELIMITER //
CREATE PROCEDURE `spActualizarBatalla`(
	IN _cantidad INT,
    IN _campeonId INT,
    IN _jugadorId INT 
) 
BEGIN 
	UPDATE Batallas
    SET cantidad = _cantidad
	WHERE 
		campeonId = _campeonId and jugadorId = _campeonId;
END //
DELIMITER ;


-- 7.Implemetar un procedimiento almacenado para eliminar un jugador
DELIMITER //
CREATE PROCEDURE `spEliminarJugador`(
	IN _idJugador INT
)
BEGIN
	DELETE FROM 
		Jugadores 
    WHERE 
		idJugador = _idJugador;
END //
DELIMITER ;


-- 8.Implementar un procediiento almacenado para eliminar un campeon
DELIMITER //
CREATE PROCEDURE `spEliminarCampeon`(
    IN _idCampeon INT
    
)
BEGIN
	DELETE FROM 
		Campeones
    WHERE 
		idCampeon = _idCampeon;	
END //
DELIMITER ;
		
-- 9.Implementar un procedimiento almacenado para eliminar una batalla
DELIMITER //
CREATE PROCEDURE `spEliminarBatalla`(
    IN _campeonId INT,
    IN _jugadorId INT
    
)
BEGIN
	DELETE FROM 
		Batallas
    WHERE 
		campeonId = _campeonId and jugadorId = _jugadorId;	
END //
DELIMITER ;

-- 10.Implementar un procedimiento almacenado para obtener todos los registros de los jugadores
DELIMITER //
CREATE PROCEDURE `spObtenerJugador`()
BEGIN
	SELECT * FROM 	
		Jugadores;
END //
DELIMITER ;

-- 11.Implementar un procedimiento almacenado para obtener todos los registros de los campeones
DELIMITER //
CREATE PROCEDURE `spObtenerCampeon`()
BEGIN
	SELECT * FROM 
		Campeones;
END //
DELIMITER ;

-- 12.Implementar un procedimiento almacenado para obtener todos los registros de las batallas
DELIMITER //
CREATE PROCEDURE `spObtenerBatallas`()
BEGIN
	SELECT * FROM 
		Batallas;
END //
DELIMITER ;


-- 13.Implementar un procedimiento almacenado para obtener un registro en especifico de jugadores
DELIMITER //
CREATE PROCEDURE `spObtenerEspecificoJugador`(
 IN _idJugador INT 
)
BEGIN
	SELECT * FROM 
		Jugadores
    WHERE
		idJugador = _idJugador;
END //
DELIMITER ;



-- 14.Implementar un procedimiento almacenado para obtener un registro en especifico de campeones
DELIMITER //
CREATE PROCEDURE `spObtenerEspecificoCampeon`(
 IN _idCampeon INT 
)
BEGIN
	SELECT * FROM 
		Campeones
    WHERE
		idCampeon = _idCampeon;
END //
DELIMITER ;

-- 15.Implementar un procedimiento almacenado para obtener todos los jugadores que han combatido o no, y si el jugador ha combatido mostrar con que campeones a participado


-- 16.Implementar un procedimiento almacenado para mostrar unicamente los jugadores que han combatido y mostrar con que campeones han participado y cuantas vexes a contratado a dicho campeon .alter
DELIMITER //
CREATE PROCEDURE `spCombateJugadores`()
begin
	SELECT 
		Ju.nombreJugador, 
		Ca.nombreCampeon
	FROM Jugadores Ju
		INNER JOIN Batallas BA
		ON Ju.idJugador = BA.jugadorId
		INNER JOIN Campeones Ca
		ON Ca.campeonId = Ca.idCampeon;
END //
DELIMITER ;

-- 17.Implementar un procedimiento almacenado para obtener el o los campeones que han sido 

-- 21.Implementar un procedimiento almacenado que muestre a los jugadores jovenes
DELIMITER //
CREATE PROCEDURE `spJugadoresJovenes`(
	IN _idJugador INT,
    IN _edad INT
)
BEGIN
	SELECT 
		Ju.nombreJugador,
        Ju.edad
	FROM Jugadores Ju
    WHERE
		edad <= 18;
END //
DELIMITER ;


-- 22.Implementar un procedimiento almacenado que muestre a los jugadores adultos
DELIMITER //
CREATE PROCEDURE `spJugadoresAdultos`(
	IN _idJugador INT,
    IN _edad INT
)
BEGIN
	SELECT 
		Ju.nombreJugador,
        Ju.edad
	FROM Jugadores Ju
    WHERE
		edad > 18;
END //
DELIMITER ;

-- 27.Implementar una funcion para obtener el total de jugadores
DELIMITER //
CREATE FUNCTION `spTotalJugadores`()
	RETURNS INTEGER
BEGIN 
	DECLARE TOTAL INTEGER;
    SET
		TOTAL = (SELECT COUNT(idJugador) FROM Jugadores);
        RETURN TOTAL;
END //
DELIMITER ; 



-- 28.Implementar una funcion para obtener el total de campeones
DELIMITER //
CREATE FUNCTION `spTotalCampeones`()
	RETURNS INTEGER
BEGIN 
	DECLARE TOTALC INTEGER;
    SET
		TOTALC = (SELECT COUNT(idCampeon) FROM Campeones);
        RETURN TOTALC;
END //
DELIMITER ; 


-- 29.Implementar una funcion para obtener el total en contratar campeones
DELIMITER //
CREATE FUNCTION `fnObtenerPrecioTotalCampeones` ()
	RETURNS DECIMAL(8,2)
	
    BEGIN
		DECLARE totalPrecio DECIMAL(8,2);
        SET totalPrecio = (SELECT SUM(precio) FROM campeones);
        RETURN totalPrecio;
    END //
DELIMITER ;



-- 32.Implementar una funcion que retorne el total que se a gastado un jugador en especifico.
DELIMITER //
CREATE FUNCTION `fnObtenerTotalPagoJugador` (_nombreJugador VARCHAR(45))
	RETURNS DECIMAL(8,2)
	
    BEGIN
		DECLARE totalPago DECIMAL(8,2);
        SET totalPago = (SELECT 
						 SUM(c.precio * b.cantidad)
						 FROM jugadores j
						 INNER JOIN batallas b
						 ON j.idJugador = b.jugadorId
						 INNER JOIN campeones c
						 ON b.campeonId = c.idCampeon
						 WHERE j.nombreJugador = _nombreJugador
                         );
        RETURN totalPago;
    END //
DELIMITER ;







