-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 30-06-2026 a las 07:46:04
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
  `fecha_fin_atencion` datetime DEFAULT NULL,
  `observacion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `historial_atencion`
--

INSERT INTO `historial_atencion` (`id_historial`, `id_tiquete`, `id_area`, `id_trabajador`, `estado`, `fecha_creacion`, `fecha_inicio_atencion`, `fecha_fin_atencion`, `observacion`) VALUES
(1, 1, 4, 2, 'Finalizado', '2026-06-28 20:04:05', '2026-06-29 00:34:55', '2026-06-29 21:36:38', ''),
(2, 2, 1, 4, 'Finalizado', '2026-06-28 20:04:13', '2026-06-29 00:35:49', '2026-06-29 21:46:46', ''),
(3, 3, 3, 3, 'Finalizado', '2026-06-28 20:04:23', '2026-06-29 00:36:11', '2026-06-29 22:57:13', ''),
(7, 7, 2, 1, 'Finalizado', '2026-06-28 20:14:44', '2026-06-28 22:41:02', '2026-06-28 23:09:03', ''),
(8, 8, 2, 1, 'Finalizado', '2026-06-28 20:14:54', '2026-06-28 23:14:28', '2026-06-28 23:15:51', 'Prueba 1'),
(9, 9, 2, 1, 'Finalizado', '2026-06-28 20:15:10', '2026-06-28 23:16:54', '2026-06-28 23:17:00', 'Prueba 2'),
(10, 10, 2, 1, 'Derivado', '2026-06-28 21:46:41', '2026-06-28 23:25:58', '2026-06-28 23:34:05', 'Necesita retirar medicamentos'),
(12, 11, 2, 1, 'Derivado', '2026-06-28 23:45:41', '2026-06-28 23:46:21', '2026-06-28 23:46:37', 'Prueba 4'),
(14, 12, 2, 1, 'Finalizado', '2026-06-28 23:47:10', '2026-06-28 23:48:06', '2026-06-28 23:48:25', 'No se presento'),
(15, 13, 2, 1, 'Derivado', '2026-06-29 00:33:32', '2026-06-29 00:36:36', '2026-06-29 12:23:36', ''),
(16, 14, 2, 1, 'Finalizado', '2026-06-29 12:23:19', '2026-06-29 12:23:42', '2026-06-29 12:57:12', ''),
(18, 15, 2, 1, 'Derivado', '2026-06-29 12:56:06', '2026-06-29 12:57:19', '2026-06-29 12:57:29', ''),
(19, 16, 2, 1, 'Finalizado', '2026-06-29 12:56:15', '2026-06-29 12:57:38', '2026-06-29 12:57:51', ''),
(20, 17, 2, 1, 'Finalizado', '2026-06-29 12:56:26', '2026-06-29 12:57:55', '2026-06-29 19:12:17', ''),
(23, 19, 2, 1, 'Finalizado', '2026-06-29 17:17:54', '2026-06-29 19:12:48', '2026-06-29 19:12:50', ''),
(24, 20, 2, 1, 'Finalizado', '2026-06-29 19:08:32', '2026-06-29 19:12:53', '2026-06-29 19:12:55', ''),
(25, 21, 2, 1, 'Finalizado', '2026-06-29 19:20:29', '2026-06-29 19:20:43', '2026-06-29 19:44:09', ''),
(26, 22, 2, 1, 'Finalizado', '2026-06-29 20:10:59', '2026-06-29 20:11:14', '2026-06-29 20:21:19', ''),
(27, 23, 2, 1, 'Finalizado', '2026-06-29 20:21:11', '2026-06-29 20:57:04', '2026-06-29 23:10:51', ''),
(28, 10, 1, 4, 'Finalizado', '2026-06-29 21:37:09', '2026-06-29 23:34:19', '2026-06-29 23:34:21', ''),
(29, 24, 2, 1, 'Finalizado', '2026-06-29 22:37:07', '2026-06-29 23:10:56', '2026-06-29 23:11:06', ''),
(30, 25, 2, 1, 'Finalizado', '2026-06-29 22:37:39', '2026-06-29 23:11:12', '2026-06-29 23:11:23', ''),
(31, 26, 2, 1, 'Finalizado', '2026-06-29 22:38:17', '2026-06-29 23:16:17', '2026-06-29 23:16:38', ''),
(32, 27, 3, 3, 'Finalizado', '2026-06-29 23:01:42', '2026-06-29 23:02:25', '2026-06-29 23:10:21', ''),
(33, 15, 1, 4, 'Finalizado', '2026-06-29 23:02:12', '2026-06-29 23:34:26', '2026-06-29 23:34:28', ''),
(34, 28, 3, 3, 'Finalizado', '2026-06-29 23:16:27', '2026-06-29 23:33:54', '2026-06-29 23:33:55', ''),
(35, 29, 4, 2, 'Finalizado', '2026-06-29 23:16:58', '2026-06-29 23:33:07', '2026-06-29 23:33:09', ''),
(36, 30, 3, 3, 'Finalizado', '2026-06-29 23:17:11', '2026-06-29 23:33:58', '2026-06-29 23:34:00', ''),
(37, 31, 2, 1, 'Finalizado', '2026-06-29 23:26:50', '2026-06-29 23:27:22', '2026-06-29 23:30:27', ''),
(38, 32, 2, 1, 'Finalizado', '2026-06-29 23:30:10', '2026-06-29 23:30:32', '2026-06-29 23:32:56', ''),
(39, 33, 1, 4, 'Finalizado', '2026-06-29 23:35:10', '2026-06-29 23:35:26', '2026-06-29 23:35:28', ''),
(40, 34, 1, 4, 'Finalizado', '2026-06-29 23:35:18', '2026-06-29 23:35:33', '2026-06-29 23:35:34', ''),
(41, 35, 1, 4, 'Finalizado', '2026-06-29 23:35:48', '2026-06-29 23:35:56', '2026-06-29 23:35:58', '');

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
(1, 'Juan'),
(2, 'Maria'),
(3, 'Luz'),
(7, 'Jorjanie Espinoza'),
(8, 'Daniel Fajardo'),
(9, 'Justin Lopez'),
(10, 'Josefa Perez'),
(11, 'Karla'),
(12, 'Darlin'),
(13, 'Marcos Romano'),
(14, 'Marlon Gonzalez'),
(15, 'Diego Solis'),
(16, 'Tiago Garro'),
(17, 'Dylan Díaz'),
(18, 'Fernadon Díaz'),
(19, 'Marcos Mandarin'),
(20, 'Duran duran'),
(21, 'Daniel Lopéz'),
(22, 'Dario Lopez'),
(23, 'Claudio Ramiro'),
(24, 'Maicol Lopéz'),
(25, 'Miguel Lozano'),
(26, 'Dylan Fierro'),
(27, 'Mariana Lopez'),
(28, 'Mariana Lopez'),
(29, 'Darlin'),
(30, 'Cleo'),
(31, 'William Bonilla'),
(32, 'Damian Flores'),
(33, 'Maria'),
(34, 'Daniel'),
(35, 'Jorjanie');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `id_rol` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`id_rol`, `nombre`) VALUES
(1, 'Enfermero'),
(2, 'Secretario'),
(3, 'Médico'),
(4, 'Farmacéutico'),
(5, 'Admin');

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
(1, 'FA-001', 1, 'FINALIZADO'),
(2, 'VE-001', 2, 'FINALIZADO'),
(3, 'EN-001', 3, 'FINALIZADO'),
(7, 'CO-001', 7, 'FINALIZADO'),
(8, 'CO-002', 8, 'FINALIZADO'),
(9, 'CO-003', 9, 'FINALIZADO'),
(10, 'CO-004', 10, 'FINALIZADO'),
(11, 'CO-005', 11, 'FINALIZADO'),
(12, 'CO-006', 12, 'FINALIZADO'),
(13, 'CO-007', 13, 'FINALIZADO'),
(14, 'CO-008', 14, 'FINALIZADO'),
(15, 'CO-009', 15, 'FINALIZADO'),
(16, 'CO-010', 16, 'FINALIZADO'),
(17, 'CO-011', 17, 'FINALIZADO'),
(18, 'CO-012', 18, 'FINALIZADO'),
(19, 'CO-013', 19, 'FINALIZADO'),
(20, 'CO-014', 20, 'FINALIZADO'),
(21, 'CO-015', 21, 'FINALIZADO'),
(22, 'CO-016', 22, 'FINALIZADO'),
(23, 'CO-017', 23, 'FINALIZADO'),
(24, 'CO-018', 24, 'FINALIZADO'),
(25, 'CO-019', 25, 'FINALIZADO'),
(26, 'CO-020', 26, 'FINALIZADO'),
(27, 'EN-002', 27, 'FINALIZADO'),
(28, 'EN-003', 28, 'FINALIZADO'),
(29, 'FA-002', 29, 'FINALIZADO'),
(30, 'EN-004', 30, 'FINALIZADO'),
(31, 'CO-021', 31, 'FINALIZADO'),
(32, 'CO-022', 32, 'FINALIZADO'),
(33, 'VE-002', 33, 'FINALIZADO'),
(34, 'VE-003', 34, 'FINALIZADO'),
(35, 'VE-004', 35, 'FINALIZADO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trabajador`
--

CREATE TABLE `trabajador` (
  `id_trabajador` int(11) NOT NULL,
  `cedula` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `password` varchar(35) NOT NULL,
  `id_area` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `trabajador`
--

INSERT INTO `trabajador` (`id_trabajador`, `cedula`, `nombre`, `password`, `id_area`, `id_rol`) VALUES
(1, '1', 'Dr. Jorjanie', '1', 2, 3),
(2, '2', 'Dr. Juan', '2', 4, 4),
(3, '3', 'Dra. Luz', '3', 3, 1),
(4, '4', 'Lic. Veronica', '4', 1, 2);

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
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`id_rol`);

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
  ADD UNIQUE KEY `cedula` (`cedula`),
  ADD KEY `id_area` (`id_area`),
  ADD KEY `trabajador_ibfk_2` (`id_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `historial_atencion`
--
ALTER TABLE `historial_atencion`
  MODIFY `id_historial` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `id_persona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tiquete`
--
ALTER TABLE `tiquete`
  MODIFY `id_tiquete` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `historial_atencion`
--
ALTER TABLE `historial_atencion`
  ADD CONSTRAINT `historial_atencion_ibfk_1` FOREIGN KEY (`id_trabajador`) REFERENCES `trabajador` (`id_trabajador`),
  ADD CONSTRAINT `historial_atencion_ibfk_3` FOREIGN KEY (`id_area`) REFERENCES `area` (`id_area`),
  ADD CONSTRAINT `historial_atencion_ibfk_4` FOREIGN KEY (`id_tiquete`) REFERENCES `tiquete` (`id_tiquete`);

--
-- Filtros para la tabla `tiquete`
--
ALTER TABLE `tiquete`
  ADD CONSTRAINT `tiquete_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id_persona`);

--
-- Filtros para la tabla `trabajador`
--
ALTER TABLE `trabajador`
  ADD CONSTRAINT `trabajador_ibfk_1` FOREIGN KEY (`id_area`) REFERENCES `area` (`id_area`),
  ADD CONSTRAINT `trabajador_ibfk_2` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
