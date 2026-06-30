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
    $observacion = $_POST['observacion'];
    $resultado = finalizar($conexion,$idTrabajador,$idArea,$observacion);
    echo json_encode($resultado);

} else if($accion == 5 ){
    $observacion = $_POST['observacion'];
    $idAreaDestino = $_POST['areaDestino'];
    $resultado = derivar($conexion, $idArea, $idTrabajador, $idAreaDestino, $observacion);

    echo json_encode($resultado);
} else if($accion == 6){
    $estadisticas = array();

    array_push($estadisticas, obtenerEnEspera($conexion, $idArea));
    array_push($estadisticas, obtenerAtendidosHoy($conexion, $idArea));
    array_push($estadisticas, obtenerTiempoPromedio($conexion, $idArea));
    array_push($estadisticas, obtenerTotalHoy($conexion, $idArea));
    
    echo json_encode($estadisticas);
}

function obtenerCola($conexion, $idArea){
    $sql = "SELECT H.`id_tiquete`, T.`codigo`, H.`id_area`, H.`estado`, H.`fecha_creacion`, P.`nombre`, (TIMESTAMPDIFF(MINUTE, H.`fecha_creacion`, NOW())) AS tiempoEspera FROM `historial_atencion` AS H
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
    $array = mysqli_fetch_array($datos);
    
    return $array;
}

function llamarSiguiente($conexion, $idArea, $idTrabajador){
    $sql = "SELECT H.`id_historial`, H.`id_tiquete`, T.`codigo`, H.`id_area`, H.`estado`, H.`fecha_creacion`, P.`nombre` FROM `historial_atencion` AS H
    INNER JOIN `tiquete` AS T ON H.`id_tiquete` = T.`id_tiquete` 
    INNER JOIN `persona` AS P ON T.`id_persona`= P.`id_persona`
    WHERE `estado` = 'En Espera' AND H.`id_area` = '". $idArea ."' ORDER BY `fecha_creacion` ASC LIMIT 1";
    $datos = mysqli_query($conexion, $sql);

    if(mysqli_num_rows($datos) == 0){
        return [ "respuesta" => false];
    } else {
        $fila = mysqli_fetch_array($datos);
        $idHistorial = $fila['id_historial'];
        $sql = "UPDATE `historial_atencion` SET `id_trabajador`='". $idTrabajador ."',`estado`='En Atencion',`fecha_inicio_atencion`= NOW() WHERE id_historial = ".$idHistorial;
        mysqli_query($conexion, $sql);

        return ["respuesta" => true];
    }
}

function finalizar($conexion,$idTrabajador, $idArea,$observacion){
    $sql = "SELECT id_historial FROM historial_atencion 
    WHERE id_area = '". $idArea ."' AND id_trabajador = '". $idTrabajador ."' AND estado = 'En Atencion'";
    $datos = mysqli_query($conexion, $sql);
    $fila = mysqli_fetch_array($datos);
    $idHistorial = $fila['id_historial'];

    $sql = "UPDATE `historial_atencion` SET `estado`='Finalizado', `fecha_fin_atencion`= NOW() ,`observacion`='". $observacion ."' WHERE id_historial = ".$idHistorial;
    mysqli_query($conexion, $sql);
    $sql = "UPDATE `tiquete` AS T INNER JOIN `historial_atencion` AS H ON T.`id_tiquete` = H.`id_tiquete` SET T.`estado_global` = 'FINALIZADO' WHERE H.`id_historial` =". $idHistorial;
    mysqli_query($conexion, $sql);
    return ["exito" => true];
}

function derivar($conexion, $idArea, $idTrabajador, $idAreaDestino, $observacion){
    $sql = "SELECT `id_historial`,`id_tiquete` FROM historial_atencion 
    WHERE id_area = '". $idArea ."' AND id_trabajador = '". $idTrabajador ."' AND estado = 'En Atencion'";
    $datos = mysqli_query($conexion, $sql);
    $fila = mysqli_fetch_array($datos);
    $idHistorial = $fila['id_historial'];
    $idTiquete = $fila['id_tiquete'];

    $sql = "UPDATE `historial_atencion` SET `estado`='Derivado', `fecha_fin_atencion`= NOW(),`observacion`='". $observacion ."' WHERE id_historial = ".$idHistorial;
    mysqli_query($conexion, $sql);
    $sql = "INSERT INTO `historial_atencion` (`id_tiquete`, `id_area`, `estado`) VALUES ('$idTiquete', '$idAreaDestino', 'En Espera')";
    mysqli_query($conexion, $sql);
    return ["exito" => true];
}

function obtenerEnEspera($conexion, $idArea){
    $sql = "SELECT COUNT(*) as total FROM historial_atencion 
    WHERE id_area = ". $idArea ." AND estado = 'En Espera'";
    $fila = mysqli_fetch_array(mysqli_query($conexion, $sql));
    return $fila['total'];
}

function obtenerAtendidosHoy($conexion, $idArea){
    $sql = "SELECT COUNT(*) as total FROM historial_atencion 
    WHERE id_area = ". $idArea ." AND estado = 'Finalizado' 
    AND DATE(fecha_fin_atencion) = CURDATE()";
    $fila = mysqli_fetch_array(mysqli_query($conexion, $sql));
    return $fila['total'];
}

function obtenerTiempoPromedio($conexion, $idArea){
    $sql = "SELECT AVG(TIMESTAMPDIFF(MINUTE, fecha_creacion, fecha_inicio_atencion)) as promedio 
    FROM historial_atencion 
    WHERE id_area = ". $idArea ." AND estado = 'Finalizado' 
    AND DATE(fecha_fin_atencion) = CURDATE()";
    $fila = mysqli_fetch_array(mysqli_query($conexion, $sql));
    return round($fila['promedio'] ?? 0);
}

function obtenerTotalHoy($conexion, $idArea){
    $sql = "SELECT COUNT(*) as total FROM historial_atencion 
    WHERE id_area = ". $idArea ." 
    AND DATE(fecha_creacion) = CURDATE()";
    $fila = mysqli_fetch_array(mysqli_query($conexion, $sql));
    return $fila['total'];
}

?>