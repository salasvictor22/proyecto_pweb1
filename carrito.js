// carrito.js

document.addEventListener("DOMContentLoaded", function () {
    const carritoContenido = document.getElementById("productos-carrito");
    const totalPrecio = document.getElementById("total-precio");

    let productosEnCarrito = JSON.parse(localStorage.getItem("carrito")) || [];

    function mostrarCarrito() {
        carritoContenido.innerHTML = "";
        let total = 0;

        // Usaremos un objeto para rastrear la cantidad de cada producto
        const cantidadProductos = {};

        productosEnCarrito.forEach((producto) => {
            // Usaremos una clave única basada en el nombre del producto
            const claveProducto = producto.nombre;

            // Si el producto no existe en el objeto, lo inicializamos con cantidad 1
            if (!cantidadProductos[claveProducto]) {
                cantidadProductos[claveProducto] = {
                    cantidad: 1,
                    producto: producto
                };
            } else {
                // Si ya existe, incrementamos la cantidad
                cantidadProductos[claveProducto].cantidad++;
            }

            total += parseFloat(producto.precio.split(" ")[1]);
        });

        // Agregar los productos al carrito de manera única
        Object.values(cantidadProductos).forEach((productoCantidad) => {
            const productoTr = document.createElement("tr");
            productoTr.innerHTML = `
                <td>${productoCantidad.producto.nombre}</td>
                <td>${productoCantidad.cantidad}</td>
                <td>${productoCantidad.producto.precio}</td>
                <td>${(productoCantidad.cantidad * parseFloat(productoCantidad.producto.precio.split(" ")[1])).toFixed(2)}</td>
                <td><button class="eliminar">Eliminar</button></td>
            `;
            carritoContenido.appendChild(productoTr);
        });

        totalPrecio.textContent = `S/ ${total.toFixed(2)}`;

        // Agregar event listener para botones de eliminar
        const botonesEliminar = document.querySelectorAll(".eliminar");
        botonesEliminar.forEach((boton, index) => {
            boton.addEventListener("click", function () {
                eliminarProducto(index);
            });
        });
    }

    function eliminarProducto(index) {
        productosEnCarrito.splice(index, 1);
        localStorage.setItem("carrito", JSON.stringify(productosEnCarrito));
        mostrarCarrito();
    }

    mostrarCarrito();
}); 