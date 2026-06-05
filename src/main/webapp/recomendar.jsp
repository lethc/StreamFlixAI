<%@page import="weka.core.*"%>
<%@page import="weka.classifiers.trees.J48"%>
<%@page import="weka.core.converters.ConverterUtils.DataSource"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recomendación</title>
</head>
<body>

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

%>

<h1>Película Recomendada</h1>

<h2>
<%= pelicula %>
</h2>

<img
    src="img/<%= pelicula.toLowerCase() %>.jpg"
    width="250">

<br><br>

<a href="index.jsp">
Volver
</a>

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

</body>
</html>