-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 23-06-2026 a las 15:02:25
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sistema_gestion_filas`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `area`
--

CREATE TABLE `area` (
  `id_area` int(11) NOT NULL,
  `prefijo` varchar(5) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `area`
--

INSERT INTO `area` (`id_area`, `prefijo`, `nombre`) VALUES
(1, 'VE', 'Ventanilla'),
(2, 'CO', 'Consultorio'),
(3, 'EN', 'Enfermería'),
(4, 'FA', 'Farmacia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_atencion`
--

CREATE TABLE `historial_atencion` (
  `id_historial` int(11) NOT NULL,
  `id_tiquete` int(11) NOT NULL,
  `id_area` int(11) NOT NULL,
  `id_trabajador` int(11) DEFAULT NULL,
  `estado` varchar(20) NOT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_inicio_atencion` datetime DEFAULT NULL,
  `fecha_fin_atencion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `historial_atencion`
--

INSERT INTO `historial_atencion` (`id_historial`, `id_tiquete`, `id_area`, `id_trabajador`, `estado`, `fecha_creacion`, `fecha_inicio_atencion`, `fecha_fin_atencion`) VALUES
(2, 2, 3, NULL, 'En Espera', '2026-06-23 01:25:58', NULL, NULL),
(3, 3, 2, NULL, 'En Espera', '2026-06-23 01:37:25', NULL, NULL),
(4, 4, 1, NULL, 'En Espera', '2026-06-23 01:41:02', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `id_persona` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`id_persona`, `nombre`) VALUES
(3, 'Jorjanie Josseth'),
(4, 'Jorjanie'),
(5, 'Josseth'),
(6, 'Luz');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiquete`
--

CREATE TABLE `tiquete` (
  `id_tiquete` int(11) NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `id_persona` int(11) NOT NULL,
  `estado_global` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tiquete`
--

INSERT INTO `tiquete` (`id_tiquete`, `codigo`, `id_persona`, `estado_global`) VALUES
(1, 'FA-001', 3, 'EN_ESPERA'),
(2, 'EN-001', 4, 'EN_ESPERA'),
(3, 'CO-001', 5, 'EN_ESPERA'),
(4, 'VE-001', 6, 'EN_ESPERA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trabajador`
--

CREATE TABLE `trabajador` (
  `id_trabajador` int(11) NOT NULL,
  `nombre` int(100) NOT NULL,
  `password` varchar(35) NOT NULL,
  `id_area` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `area`
--
ALTER TABLE `area`
  ADD PRIMARY KEY (`id_area`);

--
-- Indices de la tabla `historial_atencion`
--
ALTER TABLE `historial_atencion`
  ADD PRIMARY KEY (`id_historial`),
  ADD KEY `id_tiquete` (`id_tiquete`),
  ADD KEY `id_area` (`id_area`),
  ADD KEY `id_trabajador` (`id_trabajador`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`id_persona`);

--
-- Indices de la tabla `tiquete`
--
ALTER TABLE `tiquete`
  ADD PRIMARY KEY (`id_tiquete`),
  ADD KEY `id_persona` (`id_persona`);

--
-- Indices de la tabla `trabajador`
--
ALTER TABLE `trabajador`
  ADD PRIMARY KEY (`id_trabajador`),
  ADD KEY `id_area` (`id_area`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `historial_atencion`
--
ALTER TABLE `historial_atencion`
  MODIFY `id_historial` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `id_persona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tiquete`
--
ALTER TABLE `tiquete`
  MODIFY `id_tiquete` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `historial_atencion`
--
ALTER TABLE `historial_atencion`
  ADD CONSTRAINT `historial_atencion_ibfk_1` FOREIGN KEY (`id_trabajador`) REFERENCES `trabajador` (`id_trabajador`),
  ADD CONSTRAINT `historial_atencion_ibfk_2` FOREIGN KEY (`id_tiquete`) REFERENCES `tiquete` (`id_tiquete`),
  ADD CONSTRAINT `historial_atencion_ibfk_3` FOREIGN KEY (`id_area`) REFERENCES `area` (`id_area`);

--
-- Filtros para la tabla `tiquete`
--
ALTER TABLE `tiquete`
  ADD CONSTRAINT `tiquete_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id_persona`);

--
-- Filtros para la tabla `trabajador`
--
ALTER TABLE `trabajador`
  ADD CONSTRAINT `trabajador_ibfk_1` FOREIGN KEY (`id_area`) REFERENCES `area` (`id_area`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
