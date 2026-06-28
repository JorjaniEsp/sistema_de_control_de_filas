let idAreaSeleccionada = null;
let prefijoAreaSeleccionada = null;

$('#CrearTiquete').prop('disabled', true);

$('.servicio').click(function () {
    $('.servicio').removeClass('seleccionado');
    $(this).addClass('seleccionado');

    idAreaSeleccionada = $(this).data('id');
    prefijoAreaSeleccionada = $(this).data('prfijo');

    verificarCampos();
});

$('#nombre').on('input', function () {
    verificarCampos();
});

function verificarCampos() {
    let nombre = $('#nombre').val().trim();
    
    if (nombre.length >= 3 && idAreaSeleccionada !== null) {
        $('#CrearTiquete').prop('disabled', false);
    } else {
        $('#CrearTiquete').prop('disabled', true);
    }
}

$('#CrearTiquete').click(function () {
    $(this).prop('disabled', true).text('Procesando...');

    let nombrePaciente = $('#nombre').val().trim();

    $.ajax({
        url: '../server/kiosco.php',
        type: 'post',                      
        dataType: 'json',                  
        data: { 
            accion : 1,
            nombre: $('#nombre').val().trim(),
            area: prefijoAreaSeleccionada,
            idArea: idAreaSeleccionada
        }
    }).done(function (respuesta){
        mostrarTiquete(respuesta[0]);
    })
});

function mostrarTiquete(idTiquete){
    $.ajax({
        url: '../server/kiosco.php',
        type: 'post',                      
        dataType: 'json',                  
        data: { 
            accion : 2,
            idTiquete: idTiquete,
        }
    }).done(function (respuesta){

        let fila = respuesta;
        let departamento = '';

        if(fila.id_area == 1) {
            departamento = 'Ventanilla'
        } else if(fila.id_area == 2){
            departamento = 'Consultorio'
        } else if(fila.id_area == 3){
            departamento = 'Enfermeria'
        } else {
            departamento = 'Farmacia'
        }
        

        let html = `
        <div id="tiquete">
            <div id="target">
                <h2>${fila.codigo}</h2>
                <p>${departamento}</p>
            </div>
            
            <div id="info-tiquete">
                <div class="info-item">
                    <span class="label">Posición en cola</span>
                    <span class="value">${fila.posicion}</span>
                </div>
                
                <div class="info-item no-border">
                    <span class="value small-text">Espere ser llamado en las pantallas</span>
                </div>
            </div>
        </div>
    `;

    $('#contenedor-btnServicios').html(html);
    })
}