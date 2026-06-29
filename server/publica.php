<?php

$conexion = mysqli_connect("localhost","root","","sistema_gestion_filas")
    or die(mysqli_connect_error());

$resultado = [
    "ventanilla" => obtenerTurnoArea($conexion, 1),
    "consultorio" => obtenerTurnoArea($conexion, 2),
    "enfermeria" => obtenerTurnoArea($conexion, 3),
    "farmacia" => obtenerTurnoArea($conexion, 4)
];

echo json_encode($resultado);


function obtenerTurnoArea($conexion, $idArea){
    $sql = "SELECT T.`codigo` FROM `historial_atencion` AS H
    INNER JOIN `tiquete` AS T ON H.`id_tiquete` = T.`id_tiquete`
    WHERE H.`id_area` = " . $idArea . " AND H.`estado` = 'En Atencion'
    ORDER BY H.`fecha_inicio_atencion` DESC LIMIT 1";

    $datos = mysqli_query($conexion, $sql);
    $fila = mysqli_fetch_array($datos);

    if($fila == false){
        return null;
    }

    return $fila['codigo'];
}

?>