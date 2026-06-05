<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@page import="java.util.Random"%>
<%@page import="weka.classifiers.Evaluation"%>
<%@page import="weka.core.*"%>
<%@page import="weka.classifiers.trees.J48"%>
<%@page import="weka.core.converters.ConverterUtils.DataSource"%>
<%@page import="util.Recursividad"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recomendación</title>

<style>

body {
	margin: 0;
	font-family: Arial, sans-serif;
	background: #141414;
	color: white;
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	padding: 30px;
}

.card {
	background: #222;
	width: 90%;
	max-width: 1000px;
	padding: 40px;
	border-radius: 30px;
	box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.5);
}

.header {

	display: flex;

	justify-content: space-between;

	align-items: center;

	margin-bottom: 20px;
}

h1 {
	color: #e50914;
	margin: 0;
}

.contenido {
	display: flex;
	gap: 40px;
	align-items: flex-start;
	justify-content: center;
	margin-top: 20px;
}

.poster {
	width: 300px;
	border-radius: 20px;
}

.info {
	flex: 1;
	text-align: left;
}

.info h2 {
	margin-top: 0;
	font-size: 38px;
	margin-bottom: 10px;
}

.detalles {

	color: #bbb;

	font-size: 18px;

	margin-bottom: 15px;
}

.badge {

	display: inline-block;

	padding: 8px 15px;

	border-radius: 20px;

	background: #333;

	color: #ddd;

	font-size: 14px;
}

.divider {

	height: 1px;

	background: #444;

	margin: 25px 0;
}

.recomendaciones {
	display: flex;
	gap: 20px;
	overflow-x: auto;
	justify-content: flex-start;
	padding-top: 10px;
}

.mini-card {
	min-width: 170px;
	text-align: center;
}

.mini-poster {
	width: 150px;
	border-radius: 15px;
	transition: 0.3s;
}

.mini-poster:hover {
	transform: scale(1.05);
}

.volver {
	display: inline-block;
	padding: 12px 25px;
	background: #e50914;
	color: white;
	text-decoration: none;
	border-radius: 20px;
	transition: 0.3s;
}

.volver:hover {
	background: #b20710;
}

</style>

</head>
<body>

<div class="card">

<%

try{

	String genero =
		request.getParameter("genero");

	String edad =
		request.getParameter("edad");

	String frecuencia =
		request.getParameter("frecuencia");

	String ruta =
		application.getRealPath(
			"/data/peliculas.arff");

	DataSource source =
		new DataSource(ruta);

	Instances data =
		source.getDataSet();

	data.setClassIndex(
		data.numAttributes()-1);

	J48 arbol =
		new J48();

	arbol.buildClassifier(data);

	Evaluation eval =
		new Evaluation(data);

	eval.crossValidateModel(
		arbol,
		data,
		10,
		new Random(1));

	double precision =
		eval.pctCorrect();

	Instance nueva =
		new DenseInstance(
			data.numAttributes());

	nueva.setDataset(data);

	nueva.setValue(
		data.attribute("genero"),
		genero);

	nueva.setValue(
		data.attribute("edad"),
		edad);

	nueva.setValue(
		data.attribute("frecuencia"),
		frecuencia);

	double resultado =
		arbol.classifyInstance(
			nueva);

	String pelicula =
		data.classAttribute()
			.value((int)resultado);

	java.util.ArrayList<String> sugerencias =
		new java.util.ArrayList<String>();

	if (genero.equals("Accion")) {

		sugerencias.add("Avengers");
		sugerencias.add("MadMax");

	}
	else if (genero.equals("Comedia")) {

		sugerencias.add("TheMask");
		sugerencias.add("Superbad");

	}
	else if (genero.equals("Terror")) {

		sugerencias.add("Insidious");
		sugerencias.add("IT");

	}
	else if (genero.equals("Drama")) {

		sugerencias.add("ForrestGump");
		sugerencias.add("PursuitOfHappyness");

	}
	else {

		sugerencias.add("TheMatrix");
		sugerencias.add("Inception");

	}

%>

<div class="header">

	<h1>Película Recomendada</h1>

	<a class="volver" href="index.jsp">

		Volver

	</a>

</div>

<div class="contenido">

	<div>

		<img
			class="poster"
			src="img/<%= pelicula.toLowerCase() %>.jpg">

	</div>

	<div class="info">

		<h2>
			<%= pelicula %>
		</h2>

		<div class="detalles">

			<%= genero %> • <%= edad %> • <%= frecuencia %>

		</div>

		<div class="badge">

			Precisión: <%= String.format("%.2f", precision) %>%

		</div>

		<div class="divider"></div>

		<h3>Más películas similares</h3>

		<div class="recomendaciones">

			<%= Recursividad.mostrarPeliculas(
					sugerencias,
					0)
			%>

		</div>

	</div>

</div>

<%

}catch(Exception e){

%>

<h3>Error</h3>

<pre>
<%= e.getMessage() %>
</pre>

<%
}
%>

</div>

</body>
</html>