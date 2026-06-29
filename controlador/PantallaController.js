$(document).ready(function(){
    cargarTurnosPublicos();
});

function cargarTurnosPublicos(){
    $.ajax({
        url: '../server/publica.php',
        type: 'post',
        dataType: 'json'
    }).done(function(respuesta){

        actualizarTarjeta('ventanilla', respuesta.ventanilla);
        actualizarTarjeta('consultorio', respuesta.consultorio);
        actualizarTarjeta('enfermeria', respuesta.enfermeria);
        actualizarTarjeta('farmacia', respuesta.farmacia);

    })
}

function actualizarTarjeta(area, codigo){
    if(codigo == null){
        $('#codigo-' + area).text('Sin atención');
    } else {
        $('#codigo-' + area).text(codigo);
    }
}

setInterval(function(){
    cargarTurnosPublicos();
}, 4000);

console.log(new Date())

setInterval(function () {
    const ahora = new Date();

    const dia = ahora.getDate();         
    const mes = ahora.getMonth() + 1;    
    const año = ahora.getFullYear();     

    const horas = ahora.getHours();      
    const minutos = ahora.getMinutes();  
    const segundos = ahora.getSeconds(); 

    $('#fecha').text(`Fecha: ${dia}/${mes}/${año}`)
    $('#hora').text(`Hora: ${horas}:${minutos}:${segundos}`)
}, 1000)

let indiceActual = 0;

function rotarCarrusel(){
    let slides = $('#carrusel .slide');
    
    slides.eq(indiceActual).removeClass('activa');
    
    indiceActual = indiceActual + 1;
    if(indiceActual >= slides.length){
        indiceActual = 0;
    }
    
    slides.eq(indiceActual).addClass('activa');
}

setInterval(rotarCarrusel, 4000);