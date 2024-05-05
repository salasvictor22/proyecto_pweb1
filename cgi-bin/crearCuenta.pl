#!"C:\xampp\perl\bin\perl.exe"
use strict;
use warnings;
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use DBI;


my $cgi = new CGI;

my $username = $cgi->param('usuario');
my $password = $cgi->param('password');

my $root = "root";
my $pass = "pweb1";

my $dsn = "DBI:mysql:database=usuariosregistrados;host=localhost;port=3306";

my $mysql = DBI->connect($dsn, $root, $pass)  or die("No se pudo conectar!");

my $sql = "INSERT INTO usuarios(usuario, password) VALUES (?, ?)";
my $sth = $mysql->prepare($sql);
$sth->execute($username, $password) or die "Error al insertar datos: $DBI::errstr";

print $cgi->header(-type=>'text/html', -charset=>'utf-8');
print "<p>Registro exitoso</p>";
print '<button ><a href="../index.html" style="text-decoration: none; color: black;">Regresar</a></button>';

$mysql->disconnect;

