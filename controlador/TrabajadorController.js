$(document).ready(function(){
    verificarSesion();
});

let idArea = 0;

let idAreaSeleccionada = null;

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
        idArea = respuesta.idArea;
        cargarTurnoActual()
        cargarCola();
    })
}

function cargarCola(){
    $.ajax({
        url : '../server/trabajador.php',
        type: 'post',
        dataType: 'json',
        data : {
            accion : 1
        }
    }).done(function(respuesta){
        console.log(respuesta);
        if(respuesta.length === 0){
            $('#cuerpo-cola').html('<tr><td colspan="4">No hay turnos pendientes</td></tr>');
        } else {
            let salida = '';
            for(let i = 0; i < respuesta.length; i++){

                if(i == 0){
                    salida += `
                        <tr id="primera-fila">
                            <td> <span class="possiciones">${i+1}</span></td>
                            <td>${respuesta[i]['codigo']}</td>
                            <td>${respuesta[i]['nombre']}</td>
                            <td>${formatear(respuesta[i]['tiempoEspera'])}</td>
                            <td><span class="estados" id="siguiente-estado">${respuesta[i]['estado']}</span></td>
                        </tr>
                    `;
                } else {
                    salida += `<tr>
                            <td> <span class="possiciones">${i+1}</span></td>
                            <td> <span id='siguiente-codigo'>${respuesta[i]['codigo']}</span></td>
                            <td>${respuesta[i]['nombre']}</td>
                            <td>${formatear(respuesta[i]['tiempoEspera'])}</td>
                            <td><span class="estados" id="siguiente-estado">${respuesta[i]['estado']}</span></td>
                        </tr>`
                }
            }

            $('#cuerpo-cola').html(salida);
        }

    })
}

function cargarTurnoActual(){
    $.ajax({
        url : '../server/trabajador.php',
        type: 'post',
        dataType: 'json',
        data : {
            accion : 2
        }
    }).done(function (respuesta) {
        if (respuesta === null) {
            console.log("entro al if")
            $('#turno-actual').html(`<button id="llamar-siguiente">Llamar Siguiente</button>`);
            $('#llamar-siguiente').click(function () {
                llamarSiguiente();
            })
        } else {
            mostrarAcciones(respuesta);
        }
    })
}

// codigo    nombre   
function mostrarAcciones(info){
    let seleciones = idArea;
    let salida = `
        <div id="nombre-paciente">
        <h2>${info['codigo']}</h2>
        <h4>${info['nombre']}</h4>
        </div>
        <label for="input-observaciones">Obersvaciones (opcional)</label>
        <input type="text" name="observaciones" id="input-observaciones">
        <label for="areas">Destino (selecione el área a derivar)</label>
        <select id="areas">
            ${opcionesArea(seleciones)}
        </select>
        <div id="btn-opciones">
            <button id="derivar">Derivar</button>
            <button id="finalizar">Finalizar</button>
        </div>
    `;
    $('#turno-actual').html(salida)
    $('#finalizar').click(function(){
        finalizar();
    })
    $('#derivar').click(function(){
        derivar();
    })
}

function formatear(tiempo){
    if(tiempo > 59){
        return `${Math.floor(tiempo/60)} h ${tiempo%60} min`
    } else {
        return `${tiempo} min`
    }
}

function opcionesArea(idArea){
    let selecciones = '';
    if(idArea == 1){
        selecciones += `
            <option value="2">Consultorio</option>
            <option value="3">Enfermería</option>
            <option value="4">Farmacia</option>
        `;
    } else if(idArea == 2){
        selecciones += `
            <option value="1">Ventanilla</option>
            <option value="3">Enfermería</option>
            <option value="4">Farmacia</option>
        `;
    } else if(idArea == 3){
        selecciones += `
            <option value="1">Ventanilla</option>
            <option value="2">Consultorio</option>
            <option value="4">Farmacia</option>
        `;
    } else {
        selecciones += `
            <option value="1">Ventanilla</option>
            <option value="2">Consultorio</option>
            <option value="3">Enfermería</option>
        `;
    }
    return selecciones;
}

function llamarSiguiente() {
    console.log("tira clicl")
    $.ajax({
        url: '../server/trabajador.php',
        type: 'post',
        dataType: 'json',
        data: {
            accion: 3
        }
    }).done(function (respuesta) {
        if (respuesta.respuesta) {
            cargarTurnoActual();
            cargarCola();
        }
    })
}

function finalizar(){
    $.ajax({
        url : '../server/trabajador.php',
        type: 'post',
        dataType: 'json',
        data : {
            accion : 4,
            observacion : $('#input-observaciones').val()
        }
    }).done(function(respuesta){
        cargarTurnoActual();
    })
}

function derivar(){
    $.ajax({
        url : '../server/trabajador.php',
        type: 'post',
        dataType: 'json',
        data : {
            accion : 5,
            areaDestino : $('#areas').val(),
            observacion : $('#input-observaciones').val()
        }
    }).done(function(respuesta){
        cargarTurnoActual();
    })
}

setInterval(function(){
    cargarCola();
}, 5000);

