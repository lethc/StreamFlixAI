<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>StreamFlix IA</title>
</head>
<body>

<h1>Sistema de Recomendación de Películas</h1>

<form action="recomendar.jsp" method="get">

<p>
Genero:
<select name="genero">

<option>Accion</option>
<option>Comedia</option>
<option>Terror</option>
<option>Drama</option>
<option>CienciaFiccion</option>

</select>
</p>

<p>
Edad:
<select name="edad">

<option>Joven</option>
<option>Adulto</option>

</select>
</p>

<p>
Frecuencia:
<select name="frecuencia">

<option>Baja</option>
<option>Media</option>
<option>Alta</option>

</select>
</p>

<input
    type="submit"
    value="Obtener recomendación">

</form>

</body>
</html>