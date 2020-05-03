-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-05-2020 a las 06:44:40
-- Versión del servidor: 10.1.36-MariaDB
-- Versión de PHP: 7.2.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sat`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_multa` (IN `_pi_dni` VARCHAR(8), IN `_pi_fecha` DATE, IN `_pi_punto` INT, IN `_pi_monto` NUMERIC, IN `_pi_correo` VARCHAR(80), IN `_pi_tipo_multa` VARCHAR(20), OUT `_p_cod_error` INT, OUT `_p_msj_error` VARCHAR(100), OUT `_po_id_multa` INT)  this_proc:BEGIN
    DECLARE _v_cant_multas INT;
    DECLARE _v_id_multa    INT;
    --
    IF _pi_monto > 1000 THEN
        SET _p_cod_error = 1;
        SET _p_msj_error = 'La multa no puede ser mayor a 1000 soles.';
        LEAVE this_proc;
    END IF;
    IF _pi_tipo_multa = 'Pico placa' THEN
        SET _p_cod_error = 2;
        SET _p_msj_error = 'La multa para pico y placa no puede ser menor a 500.';
        LEAVE this_proc;
    END IF;
    SELECT COUNT(1)
      INTO _v_cant_multas
      FROM multa
     WHERE dni            = _pi_dni
       AND DATE(fec_regi) = _pi_fecha;
    IF _v_cant_multas >= 2 THEN
        SET _p_cod_error = 3;
        SET _p_msj_error = 'No se puede registrar mas de 2 multas por día.';
        LEAVE this_proc;
    END IF;
    -- DEMAS VALIDACIONES
    
    -- INSERT
    INSERT INTO `sat`.`multa`
             (`dni`  , `tipo_multa`  , `monto`  , `correo`  , `punto`  , `fec_regi`)
      VALUES (_pi_dni, _pi_tipo_multa, _pi_monto, _pi_correo, _pi_punto, _pi_fecha)
    ;
    SELECT LAST_INSERT_ID() INTO _v_id_multa;
    SET _p_cod_error = 0;
    SET _p_msj_error = 'Se registró la multa.';
    SET _po_id_multa = _v_id_multa;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `multa`
--

CREATE TABLE `multa` (
  `id_multa` int(11) NOT NULL,
  `dni` varchar(8) DEFAULT NULL,
  `tipo_multa` varchar(30) DEFAULT NULL,
  `monto` decimal(6,2) DEFAULT NULL,
  `correo` varchar(80) DEFAULT NULL,
  `punto` int(11) DEFAULT NULL,
  `fec_regi` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `multa`
--

INSERT INTO `multa` (`id_multa`, `dni`, `tipo_multa`, `monto`, `correo`, `punto`, `fec_regi`) VALUES
(2, '22334455', 'Luz Roja', '123.00', 'asdadad', 6, '2020-07-10 00:00:00'),
(3, '66559988', 'Pico y Palca', '1000.00', 'asdad', 2, '1999-02-11 00:00:00'),
(4, '11225533', 'Pico y Palca', '999.00', 'asdasd', 2, '2020-12-10 00:00:00'),
(5, '66644477', 'Luz Roja', '200.00', 'asdad', 6, '2020-09-06 00:00:00'),
(6, '22555444', 'Límite de velocidad', '144.00', 'asdads', 6, '2020-06-22 00:00:00'),
(8, '66997744', 'Límite de velocidad', '94.35', 'sdad', 10, '2020-05-02 00:00:00'),
(9, '55555556', 'Luz Roja', '111.00', 'saxas', 33, '1996-09-20 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_multa`
--

CREATE TABLE `tipo_multa` (
  `id_tipo` int(11) NOT NULL,
  `desc_tipo_multa` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo_multa`
--

INSERT INTO `tipo_multa` (`id_tipo`, `desc_tipo_multa`) VALUES
(1, 'Pico y Palca'),
(2, 'Luz Roja'),
(3, 'Límite de velocidad');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `multa`
--
ALTER TABLE `multa`
  ADD PRIMARY KEY (`id_multa`);

--
-- Indices de la tabla `tipo_multa`
--
ALTER TABLE `tipo_multa`
  ADD PRIMARY KEY (`id_tipo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `multa`
--
ALTER TABLE `multa`
  MODIFY `id_multa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `tipo_multa`
--
ALTER TABLE `tipo_multa`
  MODIFY `id_tipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
