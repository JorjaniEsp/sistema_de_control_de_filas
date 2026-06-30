<?php
session_start();

$conexion = mysqli_connect("localhost","root","","sistema_gestion_filas") or die(mysqli_connect_error());

$usuario = $_POST['usuario'];
$password = $_POST['password'];

$resultado = verificarLogin($conexion, $usuario, $password);
echo json_encode($resultado);


function verificarLogin($conexion, $usuario, $password){

    $sql = "SELECT t.id_trabajador, t.nombre, t.password, t.id_area, t.id_rol, a.nombre as nombreArea, r.nombre as nombreRol
    FROM trabajador as t
    JOIN area as a ON t.id_area = a.id_area
    JOIN rol as r ON t.id_rol = r.id_rol
    WHERE t.cedula = '" . $usuario . "'";

    $datos = mysqli_query($conexion, $sql);
    $fila = mysqli_fetch_array($datos);

    if($fila == null){
        return ["exito" => false];
    }

    if($fila['password'] != $password){
        return ["exito" => false];
    }

    $_SESSION['id_trabajador'] = $fila['id_trabajador'];
    $_SESSION['id_area'] = $fila['id_area'];
    $_SESSION['id_rol'] = $fila['id_rol'];

    return [
        "exito" => true,
        "nombre" => $fila['nombre'],
        "idArea" => $fila['id_area'],
        "nombreArea" => $fila['nombreArea'],
        "nombreRol" => $fila['nombreRol']
    ];
}

?>