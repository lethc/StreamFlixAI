<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
	gap: 50px;
	align-items: flex-start;
	margin-top: 20px;
}

.poster {
	width: 360px;
	border-radius: 20px;
}

.info {
	flex: 1;
	padding-top: 15px;
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

.descripcionIA {
	color: #aaa;
	line-height: 1.7;
	margin-top: 20px;
	max-width: 550px;
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
	padding-top: 10px;
}

.mini-card {
	min-width: 140px;
	text-align: center;
}

.mini-poster {
	width: 120px;
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

/* ---------------------------
   MÉTRICAS DEL MODELO IA
---------------------------- */
.metricas {
	display: flex;
	gap: 15px;
	margin-top: 20px;
	flex-wrap: wrap;
}

.metrica {
	background: #2d2d2d;
	padding: 15px;
	border-radius: 15px;
	min-width: 160px;
}

.metrica span {
	display: block;
	color: #999;
	font-size: 12px;
	margin-bottom: 5px;
}

.metrica strong {
	font-size: 24px;
	color: white;
}

/* ---------------------------
   ÁRBOL J48 DESPLEGABLE
---------------------------- */
details {
	margin-top: 25px;
	background: #2d2d2d;
	padding: 15px;
	border-radius: 15px;
}

summary {
	cursor: pointer;
	font-weight: bold;
	color: #e50914;
}

pre {
	white-space: pre-wrap;
	color: #ccc;
	font-size: 12px;
	margin-top: 15px;
}

.perfil {
	/* 	margin-top: 20px;
	padding: 20px;
	background: #2d2d2d;
	border-radius: 15px; */
	color: #ddd;
	/* line-height: 1.6; */
}

.perfil h3 {
	margin-top: 0;
	color: #e50914;
}

.perfil strong {
	color: white;
}

.poster-container {
	margin-top: 20px;
}
</style>

</head>
<body>

	<div class="card">

		<%
		try {

			/* =====================================
			   DATOS RECIBIDOS DEL FORMULARIO
			===================================== */

			String genero = request.getParameter("genero");

			String edad = request.getParameter("edad");

			String frecuencia = request.getParameter("frecuencia");

			/* =====================================
			   CARGA DEL DATASET ARFF
			===================================== */

			String ruta = application.getRealPath("/data/peliculas.arff");

			DataSource source = new DataSource(ruta);

			Instances data = source.getDataSet();

			data.setClassIndex(data.numAttributes() - 1);

			/* =====================================
			   ENTRENAMIENTO DEL MODELO J48
			===================================== */

			J48 arbol = new J48();

			arbol.buildClassifier(data);

			/* =====================================
			   EVALUACIÓN DEL MODELO
			===================================== */

			Evaluation eval = new Evaluation(data);

			eval.crossValidateModel(arbol, data, 10, new Random(1));

			double precision = eval.pctCorrect();

			/* =====================================
			   CREAR NUEVO USUARIO A PREDECIR
			===================================== */

			Instance nueva = new DenseInstance(data.numAttributes());

			nueva.setDataset(data);

			nueva.setValue(data.attribute("genero"), genero);

			nueva.setValue(data.attribute("edad"), edad);

			nueva.setValue(data.attribute("frecuencia"), frecuencia);

			/* =====================================
			   OBTENER PELÍCULA RECOMENDADA
			===================================== */

			double resultado = arbol.classifyInstance(nueva);

			String pelicula = data.classAttribute().value((int) resultado);

			String descripcion = "";

			/* =====================================
			   RECOMENDACIONES SECUNDARIAS
			   (SE MUESTRAN CON RECURSIVIDAD)
			===================================== */

			java.util.ArrayList<String> sugerencias = new java.util.ArrayList<String>();

			if (genero.equals("Accion")) {

				sugerencias.add("Avengers");
				sugerencias.add("JohnWick");
				sugerencias.add("MadMax");

				descripcion = "Recomendada para usuarios que disfrutan " + "escenas intensas, combates y adrenalina.";

			} else if (genero.equals("Comedia")) {

				sugerencias.add("Deadpool");
				sugerencias.add("TheMask");
				sugerencias.add("Superbad");

				descripcion = "Ideal para usuarios que buscan " + "entretenimiento ligero y divertido.";

			} else if (genero.equals("Terror")) {

				sugerencias.add("TheConjuring");
				sugerencias.add("Insidious");
				sugerencias.add("IT");

				descripcion = "Pensada para espectadores que disfrutan " + "suspenso, tensión y experiencias paranormales.";

			} else if (genero.equals("Drama")) {

				sugerencias.add("Titanic");
				sugerencias.add("ForrestGump");
				sugerencias.add("PursuitOfHappyness");

				descripcion = "Adecuada para usuarios interesados " + "en historias emocionales y personajes profundos.";

			} else {
				sugerencias.add("Interstellar");
				sugerencias.add("TheMatrix");
				sugerencias.add("Inception");

				descripcion = "Perfecta para personas interesadas " + "en tecnología, ciencia y mundos futuristas.";

			}
			sugerencias.remove(pelicula);
		%>

		<!-- CABECERA -->

		<div class="header">

			<h1>Película Recomendada</h1>

			<a class="volver" href="index.jsp"> Volver </a>

		</div>

		<!-- CONTENIDO PRINCIPAL -->

		<div class="contenido">


			<div class="poster-container">

				<img class="poster" src="img/<%=pelicula.toLowerCase()%>.jpg">

			</div>

			<div class="info">

				<h2><%=pelicula%></h2>

				<div class="detalles">

					<%=genero%>
					•
					<%=edad%>
					•
					<%=frecuencia%>

				</div>

				<div class="badge">

					Precisión:
					<%=String.format("%.2f", precision)%>%

				</div>

				<div class="perfil">

					<!-- 					<h3>Perfil de audiencia</h3>
 -->
					<p>
						<%=descripcion%>
					</p>
					<p>
						Edad predominante: <strong><%=edad%></strong>
					</p>
					<p>
						Frecuencia de visualización: <strong><%=frecuencia%></strong>
					</p>


				</div>

				<!-- 				<p class="descripcionIA">Esta recomendación fue generada
					utilizando un árbol de decisión J48 entrenado con Weka, analizando
					género, edad y frecuencia de visualización.</p> -->

				<div class="divider"></div>

				<h3>Más películas similares</h3>

				<div class="recomendaciones">

					<%=Recursividad.mostrarPeliculas(sugerencias, 0)%>

				</div>

			</div>

		</div>

		<!-- =====================================
     	SECCIÓN TÉCNICA DEL PROYECTO
		===================================== -->

<%-- 		<div class="divider"></div>

		<h3>Métricas del modelo</h3>

		<div class="metricas">

			<div class="metrica">

				<span>Precisión</span> <strong> <%=String.format("%.2f", eval.pctCorrect())%>%

				</strong>

			</div>

			<div class="metrica">

				<span>Error Medio</span> <strong> <%=String.format("%.3f", eval.meanAbsoluteError())%>

				</strong>

			</div>

		</div> --%>

		<details>

			<summary> Ver árbol de decisión J48 </summary>

			<pre>
<%=arbol.toString()%>
	</pre>

		</details>

		<%
		} catch (Exception e) {
		%>

		<h3>Error</h3>

		<pre>
<%=e.getMessage()%>
</pre>

		<%
}
%>

	</div>

</body>
</html>