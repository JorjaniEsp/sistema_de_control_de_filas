<?php

$conexion = mysqli_connect("localhost","root","","sistema_gestion_filas")
    or die(mysqli_connect_error());

$accion = $_POST['accion'];

if($accion == '1'){
    $nombre = $_POST['nombre'];
    $area = $_POST['area'];
    $idArea = $_POST['idArea'];
    $idPaciente = insertarPaciente($conexion,$nombre);
    $infoTiquete = crearTiquete($conexion,$idArea,$area,$idPaciente);
    insertarHistorial($conexion, $infoTiquete[0],$idArea);
    echo json_encode($infoTiquete);
} else if($accion == '2') {
    $idTiquete = $_POST['idTiquete'];
    echo json_encode(obtenerTiquete($conexion,$idTiquete));

} else {
    $idArea = $_POST['idArea'];
    $espera = filaEspera($conexion,$idArea);
    echo json_encode($espera);
}

function insertarPaciente($conexion, $nombre){
    
    $sql = "INSERT INTO `persona`(`nombre`) VALUES ('$nombre')";
    mysqli_query($conexion,$sql);
    return mysqli_insert_id($conexion);
}

function crearTiquete($conexion,$idArea,$area,$idPaciente){
    $num = obtenerUltimoId($conexion,$idArea) + 1;
    $codigo = "";
    if ($num < 10) {
        $codigo = $area . "-00" . $num;
    } else if ($num < 100) {
        $codigo = $area . "-0" . $num;
    } else {
        $codigo = $area . "-" . $num;
    }

    $sql = "INSERT INTO `tiquete`(`codigo`, `id_persona`, `estado_global`) VALUES ('$codigo','$idPaciente','EN_ESPERA')";
    mysqli_query($conexion,$sql);

    $idTiquete = mysqli_insert_id($conexion);
    return [$idTiquete, $codigo];
}

function obtenerUltimoId($conexion, $area){
    $sql = "SELECT * FROM `tiquete` WHERE `codigo` LIKE '" . $area . "-%'";
    $datos = mysqli_query($conexion,$sql);
    $cant = 0;
    while ($array = mysqli_fetch_array($datos)) {
        $cant += 1;
    }
    return $cant;
}

function insertarHistorial($conexion,$idTiquete,$idArea){
    $sql = "INSERT INTO `historial_atencion` (`id_tiquete`, `id_area`, `estado`) VALUES ('$idTiquete', '$idArea', 'En Espera')";
    mysqli_query($conexion,$sql);
}

function filaEspera($conexion, $idArea){
    $sql = "SELECT * FROM `historial_atencion` WHERE `id_area` = " . $idArea . " AND `estado` = 'En Espera' ORDER BY `fecha_creacion` ASC";
    $datos = mysqli_query($conexion,$sql);
    $filas = array();
    while ($array = mysqli_fetch_array($datos)) {
        array_push($filas, $array);
    }
    return $filas;
}

function obtenerTiquete($conexion, $idTiquete){
    
        $sql = "SELECT historial_atencion.estado, historial_atencion.id_area, historial_atencion.fecha_creacion, tiquete.codigo FROM historial_atencion
        JOIN tiquete ON historial_atencion.id_tiquete = tiquete.id_tiquete
        WHERE historial_atencion.id_tiquete =" . $idTiquete;

        $datos = mysqli_query($conexion, $sql);

        $filas = array();
        while ($array = mysqli_fetch_array($datos)) {
            array_push($filas, $array);
        }
        return $filas;
}

?>