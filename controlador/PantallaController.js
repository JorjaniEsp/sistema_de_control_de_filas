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

        if(respuesta.ultimo == null) {
            $('#codigo-ultimo').text('--');
            $('#detalle-ultimo').text('Sin tiquetes recientes');
        } else {
            if($('#codigo-ultimo').text() !== respuesta.ultimo.codigo) {
                $('#tarjeta-ultimo-llamado').fadeOut(100).fadeIn(100).fadeOut(100).fadeIn(100);
            }
            
            $('#codigo-ultimo').text(respuesta.ultimo.codigo);
            $('#detalle-ultimo').text(`${respuesta.ultimo.area} → ${respuesta.ultimo.trabajador}`);
        }
    })
}

function actualizarTarjeta(area, info){
    let elemento = $('#codigo-' + area);
    if(info == null){
        elemento.html('Sin atención');
    } else {
        elemento.html(`${info.codigo} <span class="punto-atencion">→ ${info.trabajador}</span>`);
    }
}

setInterval(function(){
    cargarTurnosPublicos();
}, 4000);

setInterval(function () {
    const ahora = new Date();
    const dia = ahora.getDate();         
    const mes = ahora.getMonth() + 1;    
    const año = ahora.getFullYear();     
    const horas = ahora.getHours();      
    const minutos = ahora.getMinutes();  

    $('#fecha').text(`Fecha: ${dia}/${mes}/${año}`)
    $('#hora').text(`Hora: ${horas}:${minutos}`)
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