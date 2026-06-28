$(document).ready(function(){
    verificarSesion();
});

$('#cerrarSesion').click(function() {
    $.ajax({
        url : '../server/cerrarSesion.php',
        type: 'post',
        dataType: 'json'
    }).done(function(respuesta){
        window.location.href = '../index.html';
    })
})

function verificarSesion(){
    $.ajax({
        url: '../server/sesion.php',
        type: 'post',
        dataType: 'json'
    }).done(function(respuesta){

        if(respuesta.logueado == false){
            window.location.href = '../index.html';
            return;
        }

        $('#nombre-trabajador').text(respuesta.nombre);
        $('#area-trabajador').text(respuesta.nombreArea);

    })


}