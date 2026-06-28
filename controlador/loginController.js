$('#ingresar').click( function(){
    let InputUsuario = $('#input-usuario').val();
    let InputPassword = $('#input-contraseña').val();

    console.log("Pass " + InputPassword);
    console.log("Usu " +  InputUsuario);
    
    
    if(InputUsuario.length == 0 || InputPassword.length == 0){
        $('#mensaje').text('Debe ingresar su usuario y contraseña');
        return;
    }

    $.ajax({
        url: './server/login.php',
        type: 'post',
        dataType: 'json',
        data : {
            usuario : InputUsuario,
            password : InputPassword
        }
    }).done(function(respuesta){
        if(respuesta.exito === false){
            $('#mensaje').text('Usuario o Contraseña incorrectos');
        } else {
            window.location.href = 'vista/panelTrabajador.html'
        }
    })
})