<?php
session_start();

if(!isset($_SESSION['id_trabajador'])){
    echo json_encode(["logueado" => false]);
    exit;
}

$conexion = mysqli_connect("localhost","root","","sistema_gestion_filas") or die(mysqli_connect_error());

$idTrabajador = $_SESSION['id_trabajador'];

$sql = "SELECT t.nombre, t.id_area, a.nombre as nombreArea, r.nombre as nombreRol
FROM trabajador as t
JOIN area as a ON t.id_area = a.id_area
JOIN rol as r ON t.id_rol = r.id_rol
WHERE t.id_trabajador = " . $idTrabajador;

$datos = mysqli_query($conexion, $sql);
$fila = mysqli_fetch_array($datos);

echo json_encode([
    "logueado" => true,
    "nombre" => $fila['nombre'],
    "idArea" => $fila['id_area'],
    "nombreArea" => $fila['nombreArea'],
    "nombreRol" => $fila['nombreRol']
]);
?>