package util;
import java.util.ArrayList;

public class Recursividad {

	public static String mostrarPeliculas(
	        ArrayList<String> peliculas,
	        int indice) {

	    if(indice >= peliculas.size()) {
	        return "";
	    }

	    String pelicula =
	        peliculas.get(indice);

	    return

	        "<div class='mini-card'>"

	        + "<img class='mini-poster' src='img/"
	        + pelicula.toLowerCase()
	        + ".jpg'>"

	        + "<p>"
	        + pelicula
	        + "</p>"

	        + "</div>"

	        + mostrarPeliculas(
	                peliculas,
	                indice + 1);
	}
}