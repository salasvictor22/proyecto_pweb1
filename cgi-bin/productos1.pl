#!"C:\xampp\perl\bin\perl.exe"

use strict;
use warnings;
use CGI;
use DBI;


my $cgi = CGI->new;

# Establecer el tipo de contenido de la respuesta como HTML
print $cgi->header('text/html');

# Conectar a la base de datos
my $dbh = DBI->connect("DBI:mysql:database=usuariosregistrados;host=localhost", "root", "pweb1")
    or die "Error de conexión a la base de datos: $DBI::errstr";

# Preparar la consulta SQL para seleccionar todos los productos
my $sth = $dbh->prepare("SELECT NombreProducto, Precio, Imagen FROM productos");
# Preparar la consulta SQL para seleccionar todos los productos de la sección 'abarrotes'
my $sth_abarrotes = $dbh->prepare("SELECT NombreProducto, Precio, Imagen FROM productos WHERE Categoria = 'abarrotes'");
# Preparar la consulta SQL para seleccionar todos los productos de la sección 'bebidas'
my $sth_bebidas = $dbh->prepare("SELECT NombreProducto, Precio, Imagen FROM productos WHERE Categoria = 'bebidas'");
# Preparar la consulta SQL para seleccionar todos los productos de la sección 'lacteos'
my $sth_lacteos = $dbh->prepare("SELECT NombreProducto, Precio, Imagen FROM productos WHERE Categoria = 'lacteos'");
# Preparar la consulta SQL para seleccionar todos los productos de la sección 'golosinas'
my $sth_golosinas = $dbh->prepare("SELECT NombreProducto, Precio, Imagen FROM productos WHERE Categoria = 'golosinas'");
# Preparar la consulta SQL para seleccionar todos los productos de la sección 'limpieza'
my $sth_limpieza = $dbh->prepare("SELECT NombreProducto, Precio, Imagen FROM productos WHERE Categoria = 'limpieza'");

# Ejecutar la consulta
$sth->execute() or die "Error al ejecutar la consulta: $DBI::errstr";
$sth_abarrotes->execute() or die "Error al ejecutar la consulta de abarrotes: $DBI::errstr";
$sth_bebidas->execute() or die "Error al ejecutar la consulta de bebidas: $DBI::errstr";
$sth_lacteos->execute() or die "Error al ejecutar la consulta de lácteos: $DBI::errstr";
$sth_golosinas->execute() or die "Error al ejecutar la consulta de golosinas: $DBI::errstr";
$sth_limpieza->execute() or die "Error al ejecutar la consulta de limpieza: $DBI::errstr";

# Imprimir la estructura HTML con los productos
print <<HTML;
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../estilos.css">
    <link href="https://fonts.googleapis.com/css2?family=Afacad:wght@400;500&family=Josefin+Sans&family=Kalnia:wght@300&family=Lemon&display=swap" rel="stylesheet">
    <title>Productos</title>
    <script src="../mostrarSeccion.js"></script>
</head>
<body>
    <div>
        <header>
            <h1>Tienda Don Mario</h1>
            <nav>
                <ul>
                    <li><a href="../index.html">Inicio</a></li>
                    <li><a href="productos1.pl">Productos</a></li>
                    <li><a href="../carrito.html">Carrito</a></li>
                    <li><a href="../contacto.html">Contacto</a></li>
                </ul>   
            </nav>
        </header>
    </div>
    <div id="contenedor">
        <div id="submenu">
            <nav>
                <div><li onclick="mostrarProductos('todos')">Todos los productos</li></div>
                <div><li onclick="mostrarProductos('abarrotes')">Abarrotes</li></div>
                <div><li onclick="mostrarProductos('bebidas')">Bebidas</li></div>
                <div><li onclick="mostrarProductos('lacteos')">Lacteos</li></div>
                <div><li onclick="mostrarProductos('golosinas')">Golosinas</li></div>
                <div><li onclick="mostrarProductos('limpieza')">Limpieza</li></div>
            </nav>
        </div>
        <div id="todos" class="productos-container">
HTML

# Iterar sobre los resultados de la consulta y generar la estructura HTML para cada producto
while (my ($nombre_producto, $precio, $imagen) = $sth->fetchrow_array()) {
    print <<HTML;
            <div class="productos">
                <div><img src="$imagen" alt="$nombre_producto"></div>
                <div>$nombre_producto</div>
                <h3>S/ $precio</h3>
                <div class="botones">
                    <button class="carrito">Agregar al carrito</button>
                    <button class="comprar" onclick="agregarAlCarrito()">Comprar</button>
                </div>
            </div>
HTML
}
print <<HTML;
        </div>
        <div id="abarrotes" class="productos-container" style="display: none;">
HTML

# Imprimir productos de la sección 'abarrotes'
while (my ($nombre_producto, $precio, $imagen) = $sth_abarrotes->fetchrow_array()) {
    print <<HTML;
            <div class="productos">
                <div><img src="$imagen" alt="$nombre_producto"></div>
                <div>$nombre_producto</div>
                <h3>S/ $precio</h3>
                <div class="botones">
                    <button class="carrito">Agregar al carrito</button>
                    <button class="comprar">Comprar</button>
                </div>
            </div>
HTML
}
print <<HTML;
        </div>
        <div id="bebidas" class="productos-container" style="display: none;">
HTML

# Imprimir productos de la sección 'bebidas
while (my ($nombre_producto, $precio, $imagen) = $sth_bebidas->fetchrow_array()) {
    print <<HTML;
            <div class="productos">
                <div><img src="$imagen" alt="$nombre_producto"></div>
                <div>$nombre_producto</div>
                <h3>S/ $precio</h3>
                <div class="botones">
                    <button class="carrito">Agregar al carrito</button>
                    <button class="comprar">Comprar</button>
                </div>
            </div>
HTML
}
print <<HTML;
        </div>
        <div id="lacteos" class="productos-container" style="display: none;">
HTML

# Imprimir productos de la sección 'lacteos'
while (my ($nombre_producto, $precio, $imagen) = $sth_lacteos->fetchrow_array()) {
    print <<HTML;
            <div class="productos">
                <div><img src="$imagen" alt="$nombre_producto"></div>
                <div>$nombre_producto</div>
                <h3>S/ $precio</h3>
                <div class="botones">
                    <button class="carrito">Agregar al carrito</button>
                    <button class="comprar">Comprar</button>
                </div>
            </div>
HTML
}
print <<HTML;
        </div>
        <div id="golosinas" class="productos-container" style="display: none;">
HTML

# Imprimir productos de la sección 'golosinas'
while (my ($nombre_producto, $precio, $imagen) = $sth_golosinas->fetchrow_array()) {
    print <<HTML;
            <div class="productos">
                <div><img src="$imagen" alt="$nombre_producto"></div>
                <div>$nombre_producto</div>
                <h3>S/ $precio</h3>
                <div class="botones">
                    <button class="carrito">Agregar al carrito</button>
                    <button class="comprar">Comprar</button>
                </div>
            </div>
HTML
}
print <<HTML;
        </div>
        <div id="limpieza" class="productos-container" style="display: none;">
HTML

# Imprimir productos de la sección 'limpieza'
while (my ($nombre_producto, $precio, $imagen) = $sth_limpieza->fetchrow_array()) {
    print <<HTML;
            <div class="productos">
                <div><img src="$imagen" alt="$nombre_producto"></div>
                <div>$nombre_producto</div>
                <h3>S/ $precio</h3>
                <div class="botones">
                    <button class="carrito">Agregar al carrito</button>
                    <button class="comprar">Comprar</button>
                </div>
            </div>
HTML
}


# Finalizar la estructura HTML
print <<HTML;
        </div>
    </div>
    <script>
            document.addEventListener("DOMContentLoaded", function() {
                const botonesCarrito = document.querySelectorAll(".carrito");
        
                botonesCarrito.forEach(boton => {
                    boton.addEventListener("click", function() {
                        const productoDiv = this.closest(".productos");
                        const nombreProducto = productoDiv.querySelector("div:nth-child(2)").innerText;
                        const precioProducto = productoDiv.querySelector("h3").innerText;
        
                        const producto = {
                            nombre: nombreProducto,
                            precio: precioProducto
                        };
        
                        const productosEnCarrito = JSON.parse(localStorage.getItem("carrito")) || [];
                        productosEnCarrito.push(producto);
                        localStorage.setItem("carrito", JSON.stringify(productosEnCarrito));
        
                        alert("Producto agregado al carrito");
                    });
                });
            });
        </script>
</body>
</html>
HTML

# Cerrar la conexión a la base de datos
$sth->finish();
$sth_abarrotes->finish();
$sth_bebidas->finish();
$sth_lacteos->finish();
$sth_golosinas->finish();
$sth_limpieza->finish();
$dbh->disconnect();
