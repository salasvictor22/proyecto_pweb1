function mostrarProductos(categoria) {
    // Ocultar todos los contenedores de productos
    var contenedores = document.querySelectorAll('.productos-container');
    contenedores.forEach(function(contenedor) {
        contenedor.style.display = 'none';
    });

    // Mostrar solo el contenedor correspondiente a la categoría seleccionada
    var contenedorSeleccionado = document.getElementById(categoria);
    if (contenedorSeleccionado) {
        contenedorSeleccionado.style.display = 'grid';
        contenedorSeleccionado.style.gridTemplateColumns ='repeat(3,1fr)';
        contenedorSeleccionado.style.gridGap = '25px';
        contenedorSeleccionado.style.maxWidth = '1450px';
        contenedorSeleccionado.style.margin = '0 auto';
        contenedorSeleccionado.style.marginTop = '10px';
        contenedorSeleccionado.style.marginLeft = '290px';
    }
}