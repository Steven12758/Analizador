package semantico;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 *
 * @author root
 */
public class main {

    public static void main(String[] args) {
        
        Path pathAbsolute = Paths.get("");
	String directoryName = pathAbsolute.toAbsolutePath().toString();
        String path = "";
        String pathParser = "";
        String os = System.getProperty("os.name").toLowerCase();
        
        if (os.contains("win")) {
            //Windows
            path = "src\\semantico\\";
            pathParser = "src\\semantico";
            directoryName+="\\";
        }else{
            //Linux
            path = "src/semantico/";
            pathParser = "src/semantico";
            directoryName+="/";
        }
 
	
        /*Generar Lexico*/
        System.out.println("Current Working Directory is = " +directoryName+path);
        generarLexer(directoryName+path+"Lexer.flex");
        
        /*Generar Sintactico*/
        String opciones[] = new String[7];

        //Seleccionamos la opción de dirección de destino
        opciones[0] = "-destdir";

        //Le damos la dirección, carpeta donde se va a generar el parser.java & el simbolosxxx.java
        opciones[1] = pathParser;

        //Seleccionamos la opción de nombre de archivo simbolos
        opciones[2] = "-symbols";

        //Le damos el nombre que queremos que tenga
        opciones[3] = "sym";

        //Seleccionamos la opcion de clase parser
        opciones[4] = "-parser";

        //Le damos nombre a esa clase del paso anterior
        opciones[5] = "parser";

        //Le decimos donde se encuentra el archivo .cup 
        opciones[6] = path+"Syntax.cup";
        try {
            java_cup.Main.main(opciones);
        } catch (Exception ex) {
            System.out.print(ex);
        }
    }

    public static void generarLexer(String path) {
        File file = new File(path);
        JFlex.Main.generate(file);
        
    }
}
