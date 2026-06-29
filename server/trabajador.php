<?php
session_start();

$idTrabajador = $_SESSION['id_trabajador'];
$idArea = $_SESSION['id_area'];

$accion = $_POST['accion'];
$conexion = mysqli_connect("localhost","root","","sistema_gestion_filas") or die(mysqli_connect_error());

if($accion == 1){
    $cola = obtenerCola($conexion,$idArea);
    echo json_encode($cola);

} else if($accion == 2){
    $actual = obtenerTurnoActual($conexion,$idArea,$idTrabajador);
    echo json_encode($actual);

} else if($accion == 3){
    $siguiente = llamarSiguiente($conexion, $idArea, $idTrabajador);
    echo json_encode($siguiente);

} else if($accion == 4){
    $idHistorial = $_POST['idHistorial'];
    $observacion = $_POST['observacion'];
    $resultado = finalizar($conexion,$idHistorial,$observacion);
    echo json_encode($resultado);

} else if($accion == 5 ){
    $idHistorial = $_POST['idHistorial'];
    $observacion = $_POST['observacion'];
    $idTiquete = $_POST['idTiquete'];
    $idAreaDestino = $_POST['areaDestino'];
    $resultado = derivar($conexion, $idHistorial, $idTiquete, $idAreaDestino, $observacion);

    echo json_encode($resultado);
}

function obtenerCola($conexion, $idArea){
    $sql = "SELECT H.`id_tiquete`, T.`codigo`, H.`id_area`, H.`estado`, H.`fecha_creacion`, P.`nombre` FROM `historial_atencion` AS H
    INNER JOIN `tiquete` AS T ON H.`id_tiquete` = T.`id_tiquete` 
    INNER JOIN `persona` AS P ON T.`id_persona`= P.`id_persona`
    WHERE H.`id_area` = '". $idArea ."' AND H.`estado` = 'En Espera'
    ORDER BY H.`fecha_creacion` ASC";

    $datos = mysqli_query($conexion,$sql);
    $filas = array();
    while ($array = mysqli_fetch_array($datos)) {
        array_push($filas, $array);
    }
    return $filas;
}

function obtenerTurnoActual($conexion,$idArea,$idTrabajador){
    $sql = "SELECT H.`id_historial`, H.`id_tiquete`, T.`codigo`, H.`id_area`, H.`estado`, H.`fecha_creacion`, P.`nombre` FROM `historial_atencion` AS H
    INNER JOIN `tiquete` AS T ON H.`id_tiquete` = T.`id_tiquete` 
    INNER JOIN `persona` AS P ON T.`id_persona`= P.`id_persona`
    WHERE H.`id_area` = '". $idArea ."' AND H.`estado` = 'En Atencion' AND H.`id_trabajador` = '". $idTrabajador ."'";

    $datos = mysqli_query($conexion,$sql);
    if(mysqli_num_rows($datos) == 0){
        return [ "enAtencion" => false];
    } else {
        $array = mysqli_fetch_array($datos);
        return $array;
    }
}

function llamarSiguiente($conexion, $idArea, $idTrabajador){
    $sql = "SELECT H.`id_historial`, H.`id_tiquete`, T.`codigo`, H.`id_area`, H.`estado`, H.`fecha_creacion`, P.`nombre` FROM `historial_atencion` AS H
    INNER JOIN `tiquete` AS T ON H.`id_tiquete` = T.`id_tiquete` 
    INNER JOIN `persona` AS P ON T.`id_persona`= P.`id_persona`
    WHERE `estado` = 'En Espera' AND H.`id_area` = '". $idArea ."' ORDER BY `fecha_creacion` ASC LIMIT 1";
    $datos = mysqli_query($conexion, $sql);

    if(mysqli_num_rows($datos) == 0){
        return [ "respuesta" => "No hay más pacientes en cola"];
    } else {
        $fila = mysqli_fetch_array($datos);
        $idHistorial = $fila['id_historial'];
        $sql = "UPDATE `historial_atencion` SET `id_trabajador`='". $idTrabajador ."',`estado`='En Atencion',`fecha_inicio_atencion`= NOW() WHERE id_historial = ".$idHistorial;
        mysqli_query($conexion, $sql);

        return [
            "idHistorial" => $fila['id_historial'],
            "codigo" =>  $fila['codigo'],
            "nombre" =>  $fila['nombre'],
            "estado" =>  $fila['estado']
        ];
    }
}

function finalizar($conexion,$idHistorial,$observacion){
    $sql = "UPDATE `historial_atencion` SET `estado`='Finalizado', `fecha_fin_atencion`= NOW() ,`observacion`='". $observacion ."' WHERE id_historial = ".$idHistorial;
    mysqli_query($conexion, $sql);
    $sql = "UPDATE `tiquete` AS T INNER JOIN `historial_atencion` AS H ON T.`id_tiquete` = H.`id_tiquete` SET T.`estado_global` = 'FINALIZADO' WHERE H.`id_historial` =". $idHistorial;
    mysqli_query($conexion, $sql);
    return ["exito" => true];
}

function derivar($conexion, $idHistorial, $idTiquete, $idAreaDestino, $observacion){
    $sql = "UPDATE `historial_atencion` SET `estado`='Derivado', `fecha_fin_atencion`= NOW(),`observacion`='". $observacion ."' WHERE id_historial = ".$idHistorial;
    mysqli_query($conexion, $sql);
    $sql = "INSERT INTO `historial_atencion` (`id_tiquete`, `id_area`, `estado`) VALUES ('$idTiquete', '$idAreaDestino', 'En Espera')";
    mysqli_query($conexion, $sql);
    return ["exito" => true];
}

?>