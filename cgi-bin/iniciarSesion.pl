#!"C:\xampp\perl\bin\perl.exe"

use strict;
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use DBI;

my $cgi = new CGI;

my $usuario = $cgi->param("usuario");
my $password = $cgi->param("password");

if($usuario !~ /^[a-zA-Z]+$/ or $password !~ /^[a-zA-Z0-9]+$/)
{
print $cgi->header("text/html");
print "<h3 style='color: red;'>Los tipos de datos introducidos no son correctos</h3>";
}
else
{
my $root = "root";
my $pass = "pweb1";
my $host = "localhost";
my $db = "usuariosregistrados";

my $dsn = "DBI:mysql:database=usuariosregistrados;host=localhost;port=3306";

my $mysql = DBI->connect($dsn, $root, $pass);

my $consulta = $mysql->prepare("SELECT * FROM usuarios WHERE usuario='$usuario' AND password='$password'");

$consulta->execute();

my $encontrar = 0;

while($consulta->fetch())
{
$encontrar=1;
}
if ($encontrar eq 1)
{
print $cgi->header("text/html");
print "<meta http-equiv='refresh' content='0;url=http://localhost/proyectofinal/cgi-bin/productos1.pl'>";

}
else
{
print $cgi->header("text/html");
print "<h3 style='color: red;'>Los datos de acceso son incorrectos</h3>";
print "<br>";
print print '<button ><a href="../index.html" style="text-decoration: none; color: black;">Regresar</a></button>';
}

$mysql->disconnect();

}
