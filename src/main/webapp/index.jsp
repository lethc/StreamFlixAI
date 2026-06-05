<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>StreamFlix IA</title>

<style>
body {
	margin: 0;
	font-family: Arial, sans-serif;
	background: #141414;
	color: white;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.card {
	background: #222;
	padding: 40px;
	border-radius: 30px;
	width: 400px;
	box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.5);
}

h1 {
	text-align: center;
	color: #e50914;
}

label {
	display: block;
	margin-top: 15px;
	margin-bottom: 5px;
}

select {
	width: 100%;
	padding: 10px;
	border: none;
	border-radius: 15px;
}

button {
	width: 100%;
	margin-top: 25px;
	padding: 12px;
	border: none;
	border-radius: 20px;
	
	background: #e50914;
	color: white;
	font-size: 16px;
	cursor: pointer;
}

button:hover {
	background: #b20710;
}
</style>

</head>
<body>

	<div class="card">

		<h1>STREAMFLIX IA</h1>

		<form action="recomendar.jsp" method="get">

			<label>Género</label> <select name="genero">

				<option>Accion</option>
				<option>Comedia</option>
				<option>Terror</option>
				<option>Drama</option>
				<option>CienciaFiccion</option>

			</select> <label>Edad</label> <select name="edad">

				<option>Joven</option>
				<option>Adulto</option>

			</select> <label>Frecuencia</label> <select name="frecuencia">

				<option>Baja</option>
				<option>Media</option>
				<option>Alta</option>

			</select>

			<button type="submit">Obtener recomendación</button>

		</form>

	</div>

</body>
</html>