<?php

$conexion = mysqli_connect("localhost","root","","sistema_gestion_filas")
    or die(mysqli_connect_error());

$resultado = [
    "ventanilla" => obtenerTurnoArea($conexion, 1),
    "consultorio" => obtenerTurnoArea($conexion, 2),
    "enfermeria" => obtenerTurnoArea($conexion, 3),
    "farmacia" => obtenerTurnoArea($conexion, 4),
    "ultimo" => obtenerUltimoGlobal($conexion)
];

echo json_encode($resultado);


function obtenerTurnoArea($conexion, $idArea){
    $sql = "SELECT T.`codigo`, TR.`nombre` AS trabajador, H.`fecha_inicio_atencion` 
    FROM `historial_atencion` AS H
    INNER JOIN `tiquete` AS T ON H.`id_tiquete` = T.`id_tiquete`
    LEFT JOIN `trabajador` AS TR ON H.`id_trabajador` = TR.`id_trabajador`
    WHERE H.`id_area` = " . $idArea . " AND H.`estado` = 'En Atencion'
    ORDER BY H.`fecha_inicio_atencion` DESC LIMIT 1";

    $datos = mysqli_query($conexion, $sql);
    $fila = mysqli_fetch_array($datos);

    if($fila == false){
        return null;
    }

    return [
        "codigo" => $fila['codigo'],
        "trabajador" => $fila['trabajador'],
        "fecha" => $fila['fecha_inicio_atencion']
    ];
}

function obtenerUltimoGlobal($conexion){
    $sql = "SELECT T.`codigo`, A.`nombre`,TR.`nombre` AS nombreArea
    FROM `historial_atencion` AS H
    INNER JOIN `tiquete` AS T ON H.`id_tiquete` = T.`id_tiquete`
    INNER JOIN `area` AS A ON H.`id_area` = A.`id_area`
    INNER JOIN `trabajador` AS TR ON H.`id_trabajador` = TR.`id_trabajador`
    WHERE H.`estado` = 'En Atencion'
    ORDER BY H.`fecha_inicio_atencion` DESC LIMIT 1";

    $datos = mysqli_query($conexion, $sql);
    $fila = mysqli_fetch_array($datos);

    if($fila == false){
        return null;
    }

    return [
        "codigo" => $fila['codigo'],
        "area" => $fila['nombreArea'],
        "trabajador" => $fila['nombre']
    ];
}

?>